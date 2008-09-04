From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: RFC: fast transactions in EC [was: a problem about the two	patches
 in bug 10724 & 11428]
Date: Thu, 04 Sep 2008 08:51:53 +0400
Message-ID: <48BF6969.2040602@suse.de>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>	 <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de>	 <48BC57C9.2040409@suse.de>	 <1220421722.4007.4.camel@yakui_zhao.sh.intel.com>  <48BE32AF.0@suse.de>	 <1220429030.4007.22.camel@yakui_zhao.sh.intel.com>	 <48BE427C.3070204@suse.de>	 <1220430856.4007.38.camel@yakui_zhao.sh.intel.com>	 <48BF07E1.8080304@suse.de> <1220497095.4007.76.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060006050205000705060402"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:57464 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751493AbYIDEvc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2008 00:51:32 -0400
In-Reply-To: <1220497095.4007.76.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lenb@kernel.org

This is a multi-part message in MIME format.
--------------060006050205000705060402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Zhao Yakui wrote:
> On Thu, 2008-09-04 at 01:55 +0400, Alexey Starikovskiy wrote:
>> Hi,
>> Here is the patch, which moves almost all transaction functionality into interrupt handler, which is IMHO good.
>>
>> with the enabled DEBUG, the interrupt picture looks like this (single transaction):
> Thanks for your work and efforts. Maybe you have tested the patch on
> your laptop. But IMO this is not reasonable. In the following cases
> maybe the patch can't work well.
>    a. EC GPE storm.  According to ACPI spec the EC uses the pulse
> interrupt and interrupt is firmware generated using an EC GPIO output,
> which is connected with chipset GPIO input. If the pulse waveform is
> very wide, maybe several EC GPE interrupts will be triggered although EC
> firmware generates one pulse waveform. How can we read the corresponding
> data from EC in the GPE interrupt service handler? Maybe the read/write
> data is completely incorrect.
>    b. If there is no EC interrupt although OBF_1 bit is valid.(In theory
> when OBF_1 is valid, EC should trigger GPE interrupt). In such case the
> read/write flowchart will be wrong.
Ok, both issues are solved by following patch. Interrupts are down to ~500 from 70000.
Regards,
Alex.

--------------060006050205000705060402
Content-Type: text/x-diff;
 name="fast_transaction.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fast_transaction.patch"

ACPI: EC: do transaction from interrupt context

From:  <>

It is easier and faster to do transaction directly from interrupt context
rather than waking control thread.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |  203 ++++++++++++++++++++++++-----------------------------
 1 files changed, 91 insertions(+), 112 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index bdc9b6b..5a344e6 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -26,8 +26,8 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
-/* Uncomment next line to get verbose print outs*/
-/* #define DEBUG */
+/* Uncomment next line to get verbose printout */
+#define DEBUG
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -65,18 +65,11 @@ enum ec_command {
 	ACPI_EC_COMMAND_QUERY = 0x84,
 };
 
-/* EC events */
-enum ec_event {
-	ACPI_EC_EVENT_OBF_1 = 1,	/* Output buffer full */
-	ACPI_EC_EVENT_IBF_0,		/* Input buffer empty */
-};
-
 #define ACPI_EC_DELAY		500	/* Wait 500ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 #define ACPI_EC_UDELAY		100	/* Wait 100us before polling EC again */
 
 enum {
-	EC_FLAGS_WAIT_GPE = 0,		/* Don't check status until GPE arrives */
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
 	EC_FLAGS_GPE_MODE,		/* Expect GPE to be sent for status change */
 	EC_FLAGS_NO_GPE,		/* Don't use GPE mode */
@@ -95,6 +88,14 @@ struct acpi_ec_query_handler {
 	u8 query_bit;
 };
 
+struct transaction_data {
+	const u8 *wdata;
+	u8 *rdata;
+	u8 command;
+	u8 wlen;
+	u8 rlen;
+};
+
 static struct acpi_ec {
 	acpi_handle handle;
 	unsigned long gpe;
@@ -106,6 +107,7 @@ static struct acpi_ec {
 	wait_queue_head_t wait;
 	struct list_head list;
 	struct delayed_work work;
+	struct transaction_data t;
 	atomic_t irq_count;
 	u8 handlers_installed;
 } *boot_ec, *first_ec;
@@ -152,13 +154,13 @@ static inline u8 acpi_ec_read_data(struct acpi_ec *ec)
 {
 	u8 x = inb(ec->data_addr);
 	pr_debug(PREFIX "---> data = 0x%2.2x\n", x);
-	return inb(ec->data_addr);
+	return x;
 }
 
 static inline void acpi_ec_write_cmd(struct acpi_ec *ec, u8 command)
 {
 	pr_debug(PREFIX "<--- command = 0x%2.2x\n", command);
-	outb(command, ec->command_addr);
+	outb((ec->t.command = command), ec->command_addr);
 }
 
 static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
@@ -167,69 +169,62 @@ static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
 	outb(data, ec->data_addr);
 }
 
-static inline int acpi_ec_check_status(struct acpi_ec *ec, enum ec_event event)
+static void ec_schedule_ec_poll(struct acpi_ec *ec)
 {
-	if (test_bit(EC_FLAGS_WAIT_GPE, &ec->flags))
-		return 0;
-	if (event == ACPI_EC_EVENT_OBF_1) {
-		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_OBF)
-			return 1;
-	} else if (event == ACPI_EC_EVENT_IBF_0) {
-		if (!(acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF))
-			return 1;
-	}
+	if (test_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags))
+		schedule_delayed_work(&ec->work,
+				      msecs_to_jiffies(ACPI_EC_DELAY));
+}
 
+static int ec_transaction_done(struct acpi_ec *ec) {
+	if (!ec->t.command)
+		return 1;
+	if (!ec->t.wlen && !ec->t.rlen)
+		return 1;
 	return 0;
 }
 
-static void ec_schedule_ec_poll(struct acpi_ec *ec)
+static void gpe_transaction(struct acpi_ec *ec, u8 status)
 {
-	if (test_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags))
-		schedule_delayed_work(&ec->work,
-				      msecs_to_jiffies(ACPI_EC_DELAY));
+	if (!ec->t.command)
+		return;
+	if (ec->t.wlen > 0) {
+		if ((status & ACPI_EC_FLAG_IBF) == 0) {
+			acpi_ec_write_data(ec, *(ec->t.wdata++));
+			--ec->t.wlen;
+		}
+	} else if (ec->t.rlen > 0) {
+		if ((status & ACPI_EC_FLAG_OBF) == 1) {
+			*(ec->t.rdata++) = acpi_ec_read_data(ec);
+			--ec->t.rlen;
+		}
+	}
 }
 
-static void ec_switch_to_poll_mode(struct acpi_ec *ec)
+static int acpi_ec_wait(struct acpi_ec *ec)
 {
+	if (wait_event_timeout(ec->wait, ec_transaction_done(ec),
+			       msecs_to_jiffies(ACPI_EC_DELAY)))
+		return 0;
+	/* missing GPEs, switch back to poll mode */
+	if (printk_ratelimit())
+		pr_info(PREFIX "missing confirmations, "
+				"switch off interrupt mode.\n");
 	set_bit(EC_FLAGS_NO_GPE, &ec->flags);
 	clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
-	acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
-	set_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
+	return 1;
 }
 
-static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
+static void acpi_ec_gpe_query(void *ec_cxt);
+
+static int ec_check_sci(struct acpi_ec *ec, u8 state)
 {
-	atomic_set(&ec->irq_count, 0);
-	if (likely(test_bit(EC_FLAGS_GPE_MODE, &ec->flags)) &&
-	    likely(!force_poll)) {
-		if (wait_event_timeout(ec->wait, acpi_ec_check_status(ec, event),
-				       msecs_to_jiffies(ACPI_EC_DELAY)))
-			return 0;
-		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-		if (acpi_ec_check_status(ec, event)) {
-			/* missing GPEs, switch back to poll mode */
-			if (printk_ratelimit())
-				pr_info(PREFIX "missing confirmations, "
-						"switch off interrupt mode.\n");
-			ec_switch_to_poll_mode(ec);
-			ec_schedule_ec_poll(ec);
-			return 0;
-		}
-	} else {
-		unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
-		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-		while (time_before(jiffies, delay)) {
-			if (acpi_ec_check_status(ec, event))
-				return 0;
-			msleep(1);
-		}
-		if (acpi_ec_check_status(ec,event))
-			return 0;
+	if (state & ACPI_EC_FLAG_SCI) {
+		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
+			return acpi_os_execute(OSL_EC_BURST_HANDLER,
+				acpi_ec_gpe_query, ec);
 	}
-	pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = %s\n",
-		acpi_ec_read_status(ec),
-		(event == ACPI_EC_EVENT_OBF_1) ? "\"b0=1\"" : "\"b1=0\"");
-	return -ETIME;
+	return 0;
 }
 
 static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
@@ -237,45 +232,38 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 					u8 * rdata, unsigned rdata_len,
 					int force_poll)
 {
-	int result = 0;
-	set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 	pr_debug(PREFIX "transaction start\n");
+	set_bit(EC_FLAGS_NO_GPE, &ec->flags);
+	clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
+	acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+	ec->t.wdata = wdata;
+	ec->t.wlen = wdata_len;
+	ec->t.rdata = rdata;
+	ec->t.rlen = rdata_len;
 	acpi_ec_write_cmd(ec, command);
-	for (; wdata_len > 0; --wdata_len) {
-		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
-		if (result) {
-			pr_err(PREFIX
-			       "write_cmd timeout, command = %d\n", command);
-			goto end;
-		}
-		set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-		acpi_ec_write_data(ec, *(wdata++));
-	}
-
-	if (!rdata_len) {
-		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, force_poll);
-		if (result) {
-			pr_err(PREFIX
-			       "finish-write timeout, command = %d\n", command);
-			goto end;
-		}
-	} else if (command == ACPI_EC_COMMAND_QUERY)
-		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-
-	for (; rdata_len > 0; --rdata_len) {
-		result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1, force_poll);
-		if (result) {
-			pr_err(PREFIX "read timeout, command = %d\n", command);
-			goto end;
+	if (force_poll ||
+	    !test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ||
+	    acpi_ec_wait(ec)) {
+		unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
+		while (time_before(jiffies, delay)) {
+			gpe_transaction(ec, acpi_ec_read_status(ec));
+			msleep(1);
+			if (ec_transaction_done(ec))
+				goto end;
 		}
-		/* Don't expect GPE after last read */
-		if (rdata_len > 1)
-			set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-		*(rdata++) = acpi_ec_read_data(ec);
 	}
-      end:
+end:
 	pr_debug(PREFIX "transaction end\n");
-	return result;
+	ec->t.command = 0;
+	ec_check_sci(ec, acpi_ec_read_status(ec));
+	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+	return 0;
+}
+
+static int ec_check_ibf0(struct acpi_ec *ec)
+{
+	u8 status = acpi_ec_read_status(ec);
+	return (status & ACPI_EC_FLAG_IBF) == 0;
 }
 
 static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
@@ -301,8 +289,8 @@ static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
 		}
 	}
 
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, 0);
-	if (status) {
+	if (!wait_event_timeout(ec->wait, ec_check_ibf0(ec),
+				msecs_to_jiffies(ACPI_EC_DELAY))) {
 		pr_err(PREFIX "input buffer is not empty, "
 				"aborting transaction\n");
 		goto end;
@@ -439,6 +427,7 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 * data)
 	 */
 
 	result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_QUERY, NULL, 0, &d, 1, 0);
+	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
 	if (result)
 		return result;
 
@@ -517,26 +506,17 @@ static u32 acpi_ec_gpe_handler(void *data)
 {
 	acpi_status status = AE_OK;
 	struct acpi_ec *ec = data;
-	u8 state = acpi_ec_read_status(ec);
-	static bool warn_done = 0;
+	u8 state;
 
 	pr_debug(PREFIX "~~~> interrupt\n");
-	atomic_inc(&ec->irq_count);
-	if (!warn_done && atomic_read(&ec->irq_count) > 5) {
-		pr_warning(PREFIX "GPE storm detected, try to use ec_intr=0 "
-			"kernel option, if you see problems with keyboard.\n");
-		warn_done = 1;
-		goto end;
-	}
-	clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-	if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags))
+	state = acpi_ec_read_status(ec);
+
+	gpe_transaction(ec, state);
+	if ((status & ACPI_EC_FLAG_IBF) == 0)
 		wake_up(&ec->wait);
 
-	if (state & ACPI_EC_FLAG_SCI) {
-		if (!test_and_set_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
-			status = acpi_os_execute(OSL_EC_BURST_HANDLER,
-				acpi_ec_gpe_query, ec);
-	} else if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
+	status = ec_check_sci(ec, state);
+	if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
 		   !test_bit(EC_FLAGS_NO_GPE, &ec->flags) &&
 		   in_interrupt()) {
 		/* this is non-query, must be confirmation */
@@ -546,7 +526,6 @@ static u32 acpi_ec_gpe_handler(void *data)
 		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 		clear_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
 	}
-end:
 	ec_schedule_ec_poll(ec);
 	return ACPI_SUCCESS(status) ?
 	    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;

--------------060006050205000705060402--
