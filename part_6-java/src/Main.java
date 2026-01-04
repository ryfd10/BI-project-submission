import java.util.*;
import java.math.BigDecimal;
import java.math.RoundingMode;

public class Main {

    public static void main(String[] args) {

        List<Invoice> invoices = new ArrayList<>();

        // יצירת תאריכים לדוגמה
        Calendar cal = Calendar.getInstance();

        cal.set(2023, Calendar.OCTOBER, 10);
        Date invoiceDate1 = cal.getTime();
        cal.set(2023, Calendar.NOVEMBER, 10);
        Date dueDate1 = cal.getTime();

        cal.set(2023, Calendar.NOVEMBER, 15);
        Date invoiceDate2 = cal.getTime();
        cal.set(2023, Calendar.DECEMBER, 15);
        Date dueDate2 = cal.getTime();

        // נתוני דוגמה
        invoices.add(new Invoice(1, 100, invoiceDate1, dueDate1,
                new BigDecimal("1000"), new BigDecimal("500"), false));

        invoices.add(new Invoice(2, 100, invoiceDate2, dueDate2,
                new BigDecimal("700"), new BigDecimal("700"), true));

        invoices.add(new Invoice(3, 200, invoiceDate1, dueDate1,
                new BigDecimal("800"), new BigDecimal("300"), false));

        invoices.add(new Invoice(4, null, invoiceDate2, dueDate2,
                new BigDecimal("200"), null, false));

        // חישוב סכומים
        BigDecimal totalDebt = BigDecimal.ZERO;
        BigDecimal totalAmount = BigDecimal.ZERO;

        for (Invoice inv : invoices) {
            if (inv.amount != null) {
                totalAmount = totalAmount.add(inv.amount);
            }

            BigDecimal debt = inv.getDebt();
            if (debt.compareTo(BigDecimal.ZERO) > 0) {
                totalDebt = totalDebt.add(debt);
            }
        }

        System.out.println("Total open debt: " + totalDebt);

        // חשבוניות עם חוב
        System.out.println("Invoices with open debt:");
        for (Invoice inv : invoices) {
            BigDecimal debt = inv.getDebt();
            if (debt.compareTo(BigDecimal.ZERO) > 0) {
                System.out.println("Invoice " + inv.invoiceId + " | Debt: " + debt);
            }
        }

        // אחוז חוב
        if (!totalAmount.equals(BigDecimal.ZERO)) {
            BigDecimal percent =
                    totalDebt.divide(totalAmount, 2, RoundingMode.HALF_UP)
                             .multiply(new BigDecimal("100"));

            System.out.println("Debt percentage: " + percent + "%");
        }

        // חשבוניות באיחור
        System.out.println("Overdue invoices:");
        Date today = new Date();

        for (Invoice inv : invoices) {
            inv.calculateDaysLate(today);
            if (inv.daysLate != null) {
                System.out.println("Invoice " + inv.invoiceId +
                        " | Days late: " + inv.daysLate +
                        " | Debt: " + inv.getDebt());
            }
        }

        // צבירה לפי לקוח
        Map<Integer, BigDecimal> debtByCustomer = new HashMap<>();

        for (Invoice inv : invoices) {
            if (inv.customerId != null) {
                BigDecimal debt = inv.getDebt();
                if (debt.compareTo(BigDecimal.ZERO) > 0) {
                    debtByCustomer.merge(inv.customerId, debt, BigDecimal::add);
                }
            }
        }

        System.out.println("Customer debts (sorted):");
        debtByCustomer.entrySet().stream()
                .sorted((e1, e2) -> e2.getValue().compareTo(e1.getValue()))
                .forEach(e ->
                        System.out.println("Customer " + e.getKey() +
                                " | Debt: " + e.getValue()));
    }
}
