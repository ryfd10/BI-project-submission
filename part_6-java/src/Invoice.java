import java.math.BigDecimal;
import java.util.Date;

public class Invoice {

    public int invoiceId;
    public Integer customerId;        // Integer כדי לאפשר null
    public Date invoiceDate;
    public Date dueDate;
    public BigDecimal amount;
    public BigDecimal paidAmount;
    public boolean paid;
    public Long daysLate = null;

    public Invoice(int invoiceId,
                   Integer customerId,
                   Date invoiceDate,
                   Date dueDate,
                   BigDecimal amount,
                   BigDecimal paidAmount,
                   boolean paid) {

        this.invoiceId = invoiceId;
        this.customerId = customerId;
        this.invoiceDate = invoiceDate;
        this.dueDate = dueDate;
        this.amount = amount;
        this.paidAmount = paidAmount;
        this.paid = paid;
    }

    // חישוב חוב פתוח
    public BigDecimal getDebt() {
        if (amount == null || paidAmount == null) {
            return BigDecimal.ZERO;
        }
        return amount.subtract(paidAmount);
    }

    // בדיקה האם החשבונית לא שולמה במלואה
    public boolean isNotFullyPaid() {
        if (amount == null || paidAmount == null) {
            return true;
        }
        return paidAmount.compareTo(amount) < 0;
    }

    // חישוב מספר ימי איחור
    public void calculateDaysLate(Date today) {
        if (dueDate != null && isNotFullyPaid() && today.after(dueDate)) {
            long diffMillis = today.getTime() - dueDate.getTime();
            this.daysLate = diffMillis / (1000 * 60 * 60 * 24);
        }
    }
}
