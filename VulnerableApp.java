import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class VulnerableApp {
    private static final Logger logger = LogManager.getLogger(VulnerableApp.class);

    public static void main(String[] args) {
        String input = System.getenv("USER_INPUT");
        logger.info("Received user input: {}", input);
        System.out.println("App ran with input: " + input);
    }
}
