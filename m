From: Len Brown <lenb@kernel.org>
Subject: [PATCH 41/60] ACPI: Make Embedded Controller command timeout delay
 configurable
Date: Mon, 25 Oct 2010 02:20:49 -0400
Message-ID: <7a18e96dcbdec3c96876444ae2c7e36ce458e151.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50545 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab0JYHLM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:12 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:10 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Here and then there show up machines which need higher timeout values.
Finding this on affected machines can be cumbersome, because
ACPI_EC_DELAY is a compile option -> make it configurable via boot param.

This can even be provided writable at runtime via:
/sys/modules/acpi/parameters/ec_delay

Known machines where this helps:
Some HP machines where for whatever reasons specific EC accesses take
very long at resume from S3 (in _WAK function).
The AE_TIME error is passed upwards and the ACPI interpreter will
not execute the rest of the _WAK function which results in not properly
initialized devices/variables with different side-effects.

Afaik, on some MSI machines this helped as well.

If this param is needed there probably are underlying problems like:
  - EC firmware bug
  - A kernel EC driver bug
  - An ACPI interpreter behavior (e.g. timings when specific
    EC accesses happen and how) which the EC does not like
  - ...
which should get evaluated further, but often are nasty or
impossible to fix from OS side.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index f31291b..372ff80 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -83,6 +83,11 @@ enum {
 	EC_FLAGS_BLOCKED,		/* Transactions are blocked */
 };
 
+/* ec.c is compiled in acpi namespace so this shows up as acpi.ec_delay param */
+static unsigned int ec_delay __read_mostly = ACPI_EC_DELAY;
+module_param(ec_delay, uint, 0644);
+MODULE_PARM_DESC(ec_delay, "Timeout(ms) waited until an EC command completes");
+
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
 /* External interfaces use first EC only, so remember */
 typedef int (*acpi_ec_query_func) (void *data);
@@ -210,7 +215,7 @@ static int ec_poll(struct acpi_ec *ec)
 	int repeat = 2; /* number of command restarts */
 	while (repeat--) {
 		unsigned long delay = jiffies +
-			msecs_to_jiffies(ACPI_EC_DELAY);
+			msecs_to_jiffies(ec_delay);
 		do {
 			/* don't sleep with disabled interrupts */
 			if (EC_FLAGS_MSI || irqs_disabled()) {
@@ -265,7 +270,7 @@ static int ec_check_ibf0(struct acpi_ec *ec)
 
 static int ec_wait_ibf0(struct acpi_ec *ec)
 {
-	unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
+	unsigned long delay = jiffies + msecs_to_jiffies(ec_delay);
 	/* interrupt wait manually if GPE mode is not active */
 	while (time_before(jiffies, delay))
 		if (wait_event_timeout(ec->wait, ec_check_ibf0(ec),
-- 
1.7.3.2.90.gd4c43

