From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: RFC: fast transactions in EC [was: a problem about the two patches
 in bug 10724 & 11428]
Date: Thu, 04 Sep 2008 01:55:45 +0400
Message-ID: <48BF07E1.8080304@suse.de>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>	 <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de>	 <48BC57C9.2040409@suse.de>	 <1220421722.4007.4.camel@yakui_zhao.sh.intel.com>  <48BE32AF.0@suse.de>	 <1220429030.4007.22.camel@yakui_zhao.sh.intel.com>	 <48BE427C.3070204@suse.de> <1220430856.4007.38.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070005040900090405000607"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:47398 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754184AbYICVzb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2008 17:55:31 -0400
In-Reply-To: <1220430856.4007.38.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lenb@kernel.org

This is a multi-part message in MIME format.
--------------070005040900090405000607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
Here is the patch, which moves almost all transaction functionality into interrupt handler, which is IMHO good.

with the enabled DEBUG, the interrupt picture looks like this (single transaction):
[  228.823886] ACPI: EC: ---> status = 0x08 -- this is a check for IBF=0 before starting transaction
[  228.823888] ACPI: EC: transaction start
[  228.823890] ACPI: EC: <--- command = 0x80 -- here we write command
[  228.824123] ACPI: EC: ~~~> interrupt -- this interrupt is generated with the same content in status register as before writing a command...
[  228.824127] ACPI: EC: ---> status = 0x08
[  228.824129] ACPI: EC: <--- data = 0x58
[  228.824152] ACPI: EC: ~~~> interrupt -- and now EC start sending us interrupts like crazy...
[  228.824155] ACPI: EC: ---> status = 0x02
[  228.824169] ACPI: EC: ~~~> interrupt
[  228.824172] ACPI: EC: ---> status = 0x02
[  228.824186] ACPI: EC: ~~~> interrupt
[  228.824189] ACPI: EC: ---> status = 0x02
[  228.824203] ACPI: EC: ~~~> interrupt
[  228.824206] ACPI: EC: ---> status = 0x02
[  228.824219] ACPI: EC: ~~~> interrupt
[  228.824222] ACPI: EC: ---> status = 0x02
[  228.824236] ACPI: EC: ~~~> interrupt
[  228.824239] ACPI: EC: ---> status = 0x02
[  228.824253] ACPI: EC: ~~~> interrupt
[  228.824256] ACPI: EC: ---> status = 0x02
[  228.824270] ACPI: EC: ~~~> interrupt
[  228.824273] ACPI: EC: ---> status = 0x02
[  228.824287] ACPI: EC: ~~~> interrupt
[  228.824290] ACPI: EC: ---> status = 0x02
[  228.824304] ACPI: EC: ~~~> interrupt
[  228.824307] ACPI: EC: ---> status = 0x02
[  228.824321] ACPI: EC: ~~~> interrupt
[  228.824324] ACPI: EC: ---> status = 0x02
[  228.824337] ACPI: EC: ~~~> interrupt
[  228.824340] ACPI: EC: ---> status = 0x02
[  228.824354] ACPI: EC: ~~~> interrupt
[  228.824357] ACPI: EC: ---> status = 0x02
[  228.824371] ACPI: EC: ~~~> interrupt
[  228.824374] ACPI: EC: ---> status = 0x02
[  228.824388] ACPI: EC: ~~~> interrupt
[  228.824391] ACPI: EC: ---> status = 0x02
[  228.824405] ACPI: EC: ~~~> interrupt
[  228.824408] ACPI: EC: ---> status = 0x02
[  228.824422] ACPI: EC: ~~~> interrupt
[  228.824425] ACPI: EC: ---> status = 0x02
[  228.824439] ACPI: EC: ~~~> interrupt
[  228.824442] ACPI: EC: ---> status = 0x02
[  228.824455] ACPI: EC: ~~~> interrupt
[  228.824458] ACPI: EC: ---> status = 0x02
[  228.824472] ACPI: EC: ~~~> interrupt
[  228.824475] ACPI: EC: ---> status = 0x02
[  228.824489] ACPI: EC: ~~~> interrupt
[  228.824492] ACPI: EC: ---> status = 0x02
[  228.824506] ACPI: EC: ~~~> interrupt
[  228.824509] ACPI: EC: ---> status = 0x02
[  228.824523] ACPI: EC: ~~~> interrupt
[  228.824526] ACPI: EC: ---> status = 0x02
[  228.824540] ACPI: EC: ~~~> interrupt
[  228.824543] ACPI: EC: ---> status = 0x02
[  228.824557] ACPI: EC: ~~~> interrupt
[  228.824560] ACPI: EC: ---> status = 0x02
[  228.824573] ACPI: EC: ~~~> interrupt
[  228.824576] ACPI: EC: ---> status = 0x02
[  228.824590] ACPI: EC: ~~~> interrupt
[  228.824593] ACPI: EC: ---> status = 0x02
[  228.824607] ACPI: EC: ~~~> interrupt
[  228.824610] ACPI: EC: ---> status = 0x02
[  228.824624] ACPI: EC: ~~~> interrupt
[  228.824627] ACPI: EC: ---> status = 0x02
[  228.824641] ACPI: EC: ~~~> interrupt
[  228.824644] ACPI: EC: ---> status = 0x02
[  228.824658] ACPI: EC: ~~~> interrupt
[  228.824661] ACPI: EC: ---> status = 0x02
[  228.824675] ACPI: EC: ~~~> interrupt
[  228.824678] ACPI: EC: ---> status = 0x02
[  228.824691] ACPI: EC: ~~~> interrupt
[  228.824694] ACPI: EC: ---> status = 0x02
[  228.824708] ACPI: EC: ~~~> interrupt
[  228.824711] ACPI: EC: ---> status = 0x02
[  228.824785] ACPI: EC: ~~~> interrupt    --- one more "real" interrupt. Others are just garbage.
[  228.824788] ACPI: EC: ---> status = 0x01
[  228.824791] ACPI: EC: ---> data = 0x35
[  228.824805] ACPI: EC: ~~~> interrupt
[  228.824808] ACPI: EC: ---> status = 0x00
[  228.824822] ACPI: EC: ~~~> interrupt
[  228.824825] ACPI: EC: ---> status = 0x00
[  228.824839] ACPI: EC: ~~~> interrupt
[  228.824842] ACPI: EC: ---> status = 0x00
[  228.824856] ACPI: EC: ~~~> interrupt
[  228.824859] ACPI: EC: ---> status = 0x00
[  228.824873] ACPI: EC: ~~~> interrupt
[  228.824876] ACPI: EC: ---> status = 0x00
[  228.824890] ACPI: EC: ~~~> interrupt
[  228.824893] ACPI: EC: ---> status = 0x00
[  228.824907] ACPI: EC: ~~~> interrupt
[  228.824910] ACPI: EC: ---> status = 0x00
[  228.824924] ACPI: EC: ~~~> interrupt
[  228.824926] ACPI: EC: ---> status = 0x00
[  228.824940] ACPI: EC: ~~~> interrupt
[  228.824943] ACPI: EC: ---> status = 0x00
[  228.824957] ACPI: EC: ~~~> interrupt
[  228.824960] ACPI: EC: ---> status = 0x00
[  228.824974] ACPI: EC: ~~~> interrupt
[  228.824977] ACPI: EC: ---> status = 0x00
[  228.824991] ACPI: EC: ~~~> interrupt
[  228.824994] ACPI: EC: ---> status = 0x00
[  228.825008] ACPI: EC: ~~~> interrupt
[  228.825011] ACPI: EC: ---> status = 0x00
[  228.825025] ACPI: EC: ~~~> interrupt
[  228.825028] ACPI: EC: ---> status = 0x00
[  228.825042] ACPI: EC: ~~~> interrupt
[  228.825044] ACPI: EC: ---> status = 0x00
[  228.825058] ACPI: EC: ~~~> interrupt
[  228.825061] ACPI: EC: ---> status = 0x00
[  228.825075] ACPI: EC: ~~~> interrupt
[  228.825078] ACPI: EC: ---> status = 0x00
[  228.825092] ACPI: EC: ~~~> interrupt
[  228.825095] ACPI: EC: ---> status = 0x00
[  228.825109] ACPI: EC: ~~~> interrupt
[  228.825112] ACPI: EC: ---> status = 0x00
[  228.825126] ACPI: EC: ~~~> interrupt
[  228.825129] ACPI: EC: ---> status = 0x00
[  228.825143] ACPI: EC: ~~~> interrupt
[  228.825146] ACPI: EC: ---> status = 0x00
[  228.825160] ACPI: EC: ~~~> interrupt
[  228.825162] ACPI: EC: ---> status = 0x00
[  228.825176] ACPI: EC: ~~~> interrupt
[  228.825179] ACPI: EC: ---> status = 0x00
[  228.825193] ACPI: EC: ~~~> interrupt
[  228.825196] ACPI: EC: ---> status = 0x00
[  228.825210] ACPI: EC: ~~~> interrupt
[  228.825213] ACPI: EC: ---> status = 0x00
[  228.825227] ACPI: EC: ~~~> interrupt
[  228.825230] ACPI: EC: ---> status = 0x00
[  228.825244] ACPI: EC: ~~~> interrupt
[  228.825247] ACPI: EC: ---> status = 0x00
[  228.825261] ACPI: EC: ~~~> interrupt
[  228.825264] ACPI: EC: ---> status = 0x00
[  228.825277] ACPI: EC: ~~~> interrupt
[  228.825280] ACPI: EC: ---> status = 0x00
[  228.825294] ACPI: EC: ~~~> interrupt
[  228.825297] ACPI: EC: ---> status = 0x00
[  228.825311] ACPI: EC: ~~~> interrupt
[  228.825314] ACPI: EC: ---> status = 0x00
[  228.825328] ACPI: EC: ~~~> interrupt
[  228.825331] ACPI: EC: ---> status = 0x00
[  228.825345] ACPI: EC: ~~~> interrupt
[  228.825348] ACPI: EC: ---> status = 0x00
[  228.825362] ACPI: EC: ~~~> interrupt
[  228.825365] ACPI: EC: ---> status = 0x00
[  228.825379] ACPI: EC: ~~~> interrupt
[  228.825381] ACPI: EC: ---> status = 0x00
[  228.825387] ACPI: EC: transaction end

"transaction end" happens to be printed than EC stops sending interrupts. It looks like we get 100% interrupt load for 1ms or so...
This piece does not have 0x20 (SCI) bit set, so it is not a query issue.

I'm out of ideas, so if you have some, please speak up.
Also, Intel wants back this problematic notebook in 2 weeks, so I will not be able to debug it afterwards.

Regards,
Alex.

--------------070005040900090405000607
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

 drivers/acpi/ec.c |  181 ++++++++++++++++++++++-------------------------------
 1 files changed, 74 insertions(+), 107 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index bdc9b6b..0167b93 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
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
@@ -167,21 +169,6 @@ static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
 	outb(data, ec->data_addr);
 }
 
-static inline int acpi_ec_check_status(struct acpi_ec *ec, enum ec_event event)
-{
-	if (test_bit(EC_FLAGS_WAIT_GPE, &ec->flags))
-		return 0;
-	if (event == ACPI_EC_EVENT_OBF_1) {
-		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_OBF)
-			return 1;
-	} else if (event == ACPI_EC_EVENT_IBF_0) {
-		if (!(acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF))
-			return 1;
-	}
-
-	return 0;
-}
-
 static void ec_schedule_ec_poll(struct acpi_ec *ec)
 {
 	if (test_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags))
@@ -189,47 +176,45 @@ static void ec_schedule_ec_poll(struct acpi_ec *ec)
 				      msecs_to_jiffies(ACPI_EC_DELAY));
 }
 
-static void ec_switch_to_poll_mode(struct acpi_ec *ec)
-{
-	set_bit(EC_FLAGS_NO_GPE, &ec->flags);
-	clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
-	acpi_disable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
-	set_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
+static int ec_transaction_done(struct acpi_ec *ec) {
+	if (!ec->t.command)
+		return 1;
+	if (!ec->t.wlen && !ec->t.rlen)
+		return 1;
+	return 0;
 }
 
-static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
+static void gpe_transaction(struct acpi_ec *ec, u8 status)
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
+	if (!ec->t.command)
+		return;
+	if (ec->t.wlen > 0) {
+		if ((status & ACPI_EC_FLAG_IBF) == 0) {
+			acpi_ec_write_data(ec, *(ec->t.wdata++));
+			--ec->t.wlen;
 		}
-	} else {
-		unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
-		clear_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
-		while (time_before(jiffies, delay)) {
-			if (acpi_ec_check_status(ec, event))
-				return 0;
-			msleep(1);
+	} else if (ec->t.rlen > 0) {
+		if ((status & ACPI_EC_FLAG_OBF) == 1) {
+			*(ec->t.rdata++) = acpi_ec_read_data(ec);
+			--ec->t.rlen;
 		}
-		if (acpi_ec_check_status(ec,event))
-			return 0;
 	}
-	pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = %s\n",
-		acpi_ec_read_status(ec),
-		(event == ACPI_EC_EVENT_OBF_1) ? "\"b0=1\"" : "\"b1=0\"");
-	return -ETIME;
+}
+
+static void acpi_ec_wait(struct acpi_ec *ec)
+{
+	if (wait_event_timeout(ec->wait, ec_transaction_done(ec),
+			       msecs_to_jiffies(ACPI_EC_DELAY)))
+		return;
+	/* missing GPEs, switch back to poll mode */
+	if (printk_ratelimit())
+		pr_info(PREFIX "missing confirmations, "
+				"switch off interrupt mode.\n");
+#if 0
+	set_bit(EC_FLAGS_NO_GPE, &ec->flags);
+	clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
+#endif
+	return;
 }
 
 static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
@@ -237,45 +222,33 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 					u8 * rdata, unsigned rdata_len,
 					int force_poll)
 {
-	int result = 0;
-	set_bit(EC_FLAGS_WAIT_GPE, &ec->flags);
 	pr_debug(PREFIX "transaction start\n");
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
+	if (!force_poll && test_bit(EC_FLAGS_GPE_MODE, &ec->flags))
+		acpi_ec_wait(ec);
+	else {
+		unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
+		while (time_before(jiffies, delay)) {
+			gpe_transaction(ec, acpi_ec_read_status(ec));
+			if (ec_transaction_done(ec))
+				goto end;
+			udelay(5);
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
+	return 0;
+}
+
+static int ec_check_ibf0(struct acpi_ec *ec)
+{
+	u8 status = acpi_ec_read_status(ec);
+	return (status & ACPI_EC_FLAG_IBF) == 0;
 }
 
 static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
@@ -301,8 +274,8 @@ static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
 		}
 	}
 
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0, 0);
-	if (status) {
+	if (!wait_event_timeout(ec->wait, ec_check_ibf0(ec),
+				msecs_to_jiffies(ACPI_EC_DELAY))) {
 		pr_err(PREFIX "input buffer is not empty, "
 				"aborting transaction\n");
 		goto end;
@@ -439,6 +412,7 @@ static int acpi_ec_query(struct acpi_ec *ec, u8 * data)
 	 */
 
 	result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_QUERY, NULL, 0, &d, 1, 0);
+	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
 	if (result)
 		return result;
 
@@ -517,19 +491,13 @@ static u32 acpi_ec_gpe_handler(void *data)
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
 
 	if (state & ACPI_EC_FLAG_SCI) {
@@ -546,7 +514,6 @@ static u32 acpi_ec_gpe_handler(void *data)
 		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 		clear_bit(EC_FLAGS_RESCHEDULE_POLL, &ec->flags);
 	}
-end:
 	ec_schedule_ec_poll(ec);
 	return ACPI_SUCCESS(status) ?
 	    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;

--------------070005040900090405000607--
