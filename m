From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: ACPI resume fails on HP nx6125 with 64 bit kernel
Date: Tue, 16 Aug 2005 23:02:28 +0200
Message-ID: <43025464.2010004@gmx.net>
References: <20050815193848.GB17525@srcf.ucam.org> <20050816151142.GA516@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030606070200050400000905"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050816151142.GA516-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------030606070200050400000905
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Pavel Machek schrieb:
> Hi!
> 
> 
>>Attempting to resume an HP nx6125 results in the system hanging with a
>>blank screen. Hacking serial setup code into wakeup.S so I can get
>>serial console on resume gives me:
> 
> 
> Can we get copy of those hacks?

I did create such a patch some time ago because I had the same problem.
Russell King said it should work out of the box, so I'm now working
together with him to get it debugged.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

--------------030606070200050400000905
Content-Type: text/x-patch;
 name="serial_early_abuse.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial_early_abuse.diff"

diff -urp linux-2.6.11.8-orig/drivers/acpi/sleep/main.c linux-2.6.11.8/drivers/acpi/sleep/main.c
--- linux-2.6.11.8-orig/drivers/acpi/sleep/main.c	2005-04-30 03:22:59.000000000 +0200
+++ linux-2.6.11.8/drivers/acpi/sleep/main.c	2005-05-12 04:34:15.000000000 +0200
@@ -23,6 +23,7 @@ u8 sleep_states[ACPI_S_STATE_COUNT];
 
 static struct pm_ops acpi_pm_ops;
 
+extern void emerg_uart_setup(char *options);
 extern void do_suspend_lowlevel_s4bios(void);
 extern void do_suspend_lowlevel(void);
 
@@ -126,6 +127,8 @@ static int acpi_pm_enter(suspend_state_t
 	if (pm_state > PM_SUSPEND_STANDBY)
 		acpi_restore_state_mem();
 
+	emerg_uart_setup("io,0x3f8,115200n8");
+
 
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
diff -urp linux-2.6.11.8-orig/drivers/serial/8250_early.c linux-2.6.11.8/drivers/serial/8250_early.c
--- linux-2.6.11.8-orig/drivers/serial/8250_early.c	2005-04-30 03:27:09.000000000 +0200
+++ linux-2.6.11.8/drivers/serial/8250_early.c	2005-05-12 04:34:15.000000000 +0200
@@ -26,6 +26,7 @@
  * matching ttyS device and start a console there.
  */
 
+#include <linux/module.h>
 #include <linux/tty.h>
 #include <linux/init.h>
 #include <linux/console.h>
@@ -41,10 +42,10 @@ struct early_uart_device {
 	unsigned int baud;
 };
 
-static struct early_uart_device early_device __initdata;
-static int early_uart_registered __initdata;
+static struct early_uart_device early_device;
+static int early_uart_registered;
 
-static unsigned int __init serial_in(struct uart_port *port, int offset)
+static unsigned int serial_in(struct uart_port *port, int offset)
 {
 	if (port->iotype == UPIO_MEM)
 		return readb(port->membase + offset);
@@ -52,7 +53,7 @@ static unsigned int __init serial_in(str
 		return inb(port->iobase + offset);
 }
 
-static void __init serial_out(struct uart_port *port, int offset, int value)
+static void serial_out(struct uart_port *port, int offset, int value)
 {
 	if (port->iotype == UPIO_MEM)
 		writeb(value, port->membase + offset);
@@ -62,7 +63,7 @@ static void __init serial_out(struct uar
 
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
-static void __init wait_for_xmitr(struct uart_port *port)
+static void wait_for_xmitr(struct uart_port *port)
 {
 	unsigned int status;
 
@@ -74,13 +75,13 @@ static void __init wait_for_xmitr(struct
 	}
 }
 
-static void __init putc(struct uart_port *port, unsigned char c)
+static void putc(struct uart_port *port, unsigned char c)
 {
 	wait_for_xmitr(port);
 	serial_out(port, UART_TX, c);
 }
 
-static void __init early_uart_write(struct console *console, const char *s, unsigned int count)
+static void early_uart_write(struct console *console, const char *s, unsigned int count)
 {
 	struct uart_port *port = &early_device.port;
 	unsigned int ier;
@@ -101,7 +102,7 @@ static void __init early_uart_write(stru
 	serial_out(port, UART_IER, ier);
 }
 
-static unsigned int __init probe_baud(struct uart_port *port)
+static unsigned int probe_baud(struct uart_port *port)
 {
 	unsigned char lcr, dll, dlm;
 	unsigned int quot;
@@ -116,7 +117,7 @@ static unsigned int __init probe_baud(st
 	return (port->uartclk / 16) / quot;
 }
 
-static void __init init_port(struct early_uart_device *device)
+static void init_port(struct early_uart_device *device)
 {
 	struct uart_port *port = &device->port;
 	unsigned int divisor;
@@ -135,7 +136,7 @@ static void __init init_port(struct earl
 	serial_out(port, UART_LCR, c & ~UART_LCR_DLAB);
 }
 
-static int __init parse_options(struct early_uart_device *device, char *options)
+static int parse_options(struct early_uart_device *device, char *options)
 {
 	struct uart_port *port = &device->port;
 	int mapsize = 64;
@@ -173,14 +174,16 @@ static int __init parse_options(struct e
 			device->baud);
 	}
 
+	/* This screws up the console during emergency restore
 	printk(KERN_INFO "Early serial console at %s 0x%lx (options '%s')\n",
 		mmio ? "MMIO" : "I/O port",
 		mmio ? port->mapbase : (unsigned long) port->iobase,
 		device->options);
+	*/
 	return 0;
 }
 
-static int __init early_uart_setup(struct console *console, char *options)
+static int early_uart_setup(struct console *console, char *options)
 {
 	struct early_uart_device *device = &early_device;
 	int err;
@@ -195,7 +198,15 @@ static int __init early_uart_setup(struc
 	return 0;
 }
 
-static struct console early_uart_console __initdata = {
+void emerg_uart_setup(char *options)
+{
+	memset(&early_device, 0, sizeof(struct early_uart_device));
+	early_uart_setup(NULL, options);
+	early_uart_write(NULL, "\n", 1);
+}
+EXPORT_SYMBOL(emerg_uart_setup);
+
+static struct console early_uart_console = {
 	.name	= "uart",
 	.write	= early_uart_write,
 	.setup	= early_uart_setup,
@@ -203,7 +214,7 @@ static struct console early_uart_console
 	.index	= -1,
 };
 
-static int __init early_uart_console_init(void)
+static int early_uart_console_init(void)
 {
 	if (!early_uart_registered) {
 		register_console(&early_uart_console);
@@ -213,7 +224,7 @@ static int __init early_uart_console_ini
 }
 console_initcall(early_uart_console_init);
 
-int __init early_serial_console_init(char *cmdline)
+int early_serial_console_init(char *cmdline)
 {
 	char *options;
 	int err;
@@ -222,13 +233,15 @@ int __init early_serial_console_init(cha
 	if (!options)
 		return -ENODEV;
 
-	options = strchr(cmdline, ',') + 1;
+	//FIXME: This was wrong. Submit as separate fix.
+	//options = strchr(cmdline, ',') + 1;
+	options = strchr(options, ',') + 1;
 	if ((err = early_uart_setup(NULL, options)) < 0)
 		return err;
 	return early_uart_console_init();
 }
 
-static int __init early_uart_console_switch(void)
+static int early_uart_console_switch(void)
 {
 	struct early_uart_device *device = &early_device;
 	struct uart_port *port = &device->port;

--------------030606070200050400000905--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
