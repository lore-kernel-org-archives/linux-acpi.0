From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI power off regression in 2.6.23-rc8 (NOT in rc7)
Date: Tue, 25 Sep 2007 16:05:35 +0400
Message-ID: <46F8F98F.60206@gmail.com>
References: <20070925065109.GA3080@localhost.localdomain> <20070925095855.GA4982@localhost.localdomain> <200709251345.11370.rjw@sisk.pl> <200709251405.26861.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060202000600080209040106"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:17895 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbXIYMFk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Sep 2007 08:05:40 -0400
Received: by ug-out-1314.google.com with SMTP id z38so924326ugc
        for <linux-acpi@vger.kernel.org>; Tue, 25 Sep 2007 05:05:39 -0700 (PDT)
In-Reply-To: <200709251405.26861.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Damien Wyart <damien.wyart@free.fr>, Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Frans Pop <elendil@planet.nl>, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060202000600080209040106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Rafael J. Wysocki wrote:
> On Tuesday, 25 September 2007 13:45, Rafael J. Wysocki wrote:
>> On Tuesday, 25 September 2007 11:58, Damien Wyart wrote:
>>>>> No, I do not have CONFIG_ACPI_SLEEP set,
>>>>> because I do not have CONFIG_PM_SLEEP set,
>>>>> because I do not want SUSPEND and/or HIBERNATION.
>>>> Same answer from my side: I do not have CONFIG_ACPI_SLEEP for the same
>>>> reason (and this worked fine without them in rc7). I do not think
>>>> these settings should have changed between rc7 and rc8.
>> Well, we haven't changed much.
>>
>>> Also, another test I just did: on another computer, rc8 is fine
>>> regarding ACPI power off, even if CONFIG_ACPI_SLEEP is not set. I can
>>> provide config if needed.
>> On the box that fails to power off, can you please test -rc8 with these two
>> commits reverted:
>>
>> commit 5a50fe709d527f31169263e36601dd83446d5744
>> ACPI: suspend: consolidate handling of Sx states addendum
>>
>> commit f216cc3748a3a22c2b99390fddcdafa0583791a2
>> ACPI: suspend: consolidate handling of Sx states.
>>
>> and see if it works?
> 
> If it does, please test the patch from this message
> 
> http://marc.info/?l=linux-kernel&m=119052978117735&w=4
> 
> on top of vanilla 2.6.23-rc8.
You will need one more patch on top of just mentioned one.

Regards,
Alex.
> 
> Greetings,
> Rafael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


--------------060202000600080209040106
Content-Type: text/x-patch;
 name="fix-ACPI_SLEEP_states.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-ACPI_SLEEP_states.patch"

ACPI: suspend: fix ACPI_SLEEP states

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/sleep/Makefile |    2 +-
 drivers/acpi/sleep/main.c   |    7 +++++--
 include/acpi/acpi_drivers.h |    4 ----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/sleep/Makefile b/drivers/acpi/sleep/Makefile
index ba9bd40..f1fb888 100644
--- a/drivers/acpi/sleep/Makefile
+++ b/drivers/acpi/sleep/Makefile
@@ -1,5 +1,5 @@
 obj-y					:= wakeup.o
-obj-$(CONFIG_ACPI_SLEEP)		+= main.o
+obj-y					+= main.o
 obj-$(CONFIG_ACPI_SLEEP)		+= proc.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index c79edcb..86415f1 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -24,8 +24,6 @@
 
 u8 sleep_states[ACPI_S_STATE_COUNT];
 
-static u32 acpi_target_sleep_state = ACPI_STATE_S0;
-
 int acpi_sleep_prepare(u32 acpi_state)
 {
 #ifdef CONFIG_ACPI_SLEEP
@@ -48,6 +46,9 @@ int acpi_sleep_prepare(u32 acpi_state)
 }
 
 #ifdef CONFIG_SUSPEND
+
+static u32 acpi_target_sleep_state = ACPI_STATE_S0;
+
 static struct pm_ops acpi_pm_ops;
 
 extern void do_suspend_lowlevel(void);
@@ -299,6 +300,7 @@ int acpi_suspend(u32 acpi_state)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_PM_SLEEP
 /**
  *	acpi_pm_device_sleep_state - return preferred power state of ACPI device
  *		in the system sleep state given by %acpi_target_sleep_state
@@ -373,6 +375,7 @@ int acpi_pm_device_sleep_state(struct device *dev, int wake, int *d_min_p)
 		*d_min_p = d_min;
 	return d_max;
 }
+#endif
 
 static void acpi_power_off_prepare(void)
 {
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 202acb9..f85f77a 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -147,10 +147,6 @@ static inline void unregister_hotplug_dock_device(acpi_handle handle)
 /*--------------------------------------------------------------------------
                                   Suspend/Resume
   -------------------------------------------------------------------------- */
-#ifdef CONFIG_ACPI_SLEEP
 extern int acpi_sleep_init(void);
-#else
-static inline int acpi_sleep_init(void) { return 0; }
-#endif
 
 #endif /*__ACPI_DRIVERS_H__*/

--------------060202000600080209040106--
