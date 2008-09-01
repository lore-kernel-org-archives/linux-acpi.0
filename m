From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Tue, 02 Sep 2008 00:35:57 +0400
Message-ID: <48BC522D.60905@suse.de>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com> <20080901122158.GB21970@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040803050200090404000905"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:49694 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750876AbYIAUgB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Sep 2008 16:36:01 -0400
In-Reply-To: <20080901122158.GB21970@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

This is a multi-part message in MIME format.
--------------040803050200090404000905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Henrique de Moraes Holschuh wrote:
> On Mon, 01 Sep 2008, Zhao Yakui wrote:
>>     Will the above two patches hit the upstream kernel? If the above two patches hits the upstream kernel, it 
>> seems that the boot option of "ec_intr=" comes back again and EC can't be switched from interrupt mode to polling 
>> mode if EC GPE interrupt is missing. In such case maybe the battery/AC/thermal driver can't work well if the info of
>> battery/AC/thermal is related with EC. Maybe there exists the regression on some laptops.
> 
> Right now, the fact that it gives up on interrupt mode too easily IS causing
> regressions on ThinkPads (like the T43 I own).  Since polling mode does
> work, it is just a performance regression, so you won't get many reports
> about it since most people don't look for such stuff in their kernel logs.
> 
> Some ECs trigger the interrupt/poll-mode checks just on small windows
> (typically during resume -- might even be a bug somewhere in ACPICA or
> Linux, and not on the EC).  We should not be giving up using interrupt mode
> on these so easily.  Maybe retry enabling interrupt mode after some seconds
> a few times (like 3 or 5)?  If it is a transient problem, that will avoid
> the permanent performance regression of polled mode.
> 
How about such patch?

Regards,
Alex.

--------------040803050200090404000905
Content-Type: text/x-diff;
 name="never_give_up_gpe_mode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="never_give_up_gpe_mode.patch"

ACPI: EC: retry gpe mode after 5 sec timeout

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index f338d2b..15663c2 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -74,6 +74,7 @@ enum ec_event {
 #define ACPI_EC_DELAY		500	/* Wait 500ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 #define ACPI_EC_UDELAY		100	/* Wait 100us before polling EC again */
+#define ACPI_EC_GPE_RETRY	5000	/* Wait 5s before trying to use GPE again */
 
 enum {
 	EC_FLAGS_WAIT_GPE = 0,		/* Don't check status until GPE arrives */
@@ -102,6 +103,7 @@ static struct acpi_ec {
 	unsigned long data_addr;
 	unsigned long global_lock;
 	unsigned long flags;
+	unsigned long gpe_retry;
 	struct mutex lock;
 	wait_queue_head_t wait;
 	struct list_head list;
@@ -205,6 +207,9 @@ static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 						"switch off interrupt mode.\n");
 			set_bit(EC_FLAGS_NO_GPE, &ec->flags);
 			clear_bit(EC_FLAGS_GPE_MODE, &ec->flags);
+			 /* check again in 5 seconds */
+			ec->gpe_retry = jiffies +
+				msecs_to_jiffies(ACPI_EC_GPE_RETRY);
 			return 0;
 		}
 	} else {
@@ -530,7 +535,8 @@ static u32 acpi_ec_gpe_handler(void *data)
 				acpi_ec_gpe_query, ec);
 	} else if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
 		   !test_bit(EC_FLAGS_NO_GPE, &ec->flags) &&
-		   in_interrupt()) {
+		   in_interrupt() &&
+		   !time_before(jiffies, ec->gpe_retry)) {
 		/* this is non-query, must be confirmation */
 		if (printk_ratelimit())
 			pr_info(PREFIX "non-query interrupt received,"

--------------040803050200090404000905--
