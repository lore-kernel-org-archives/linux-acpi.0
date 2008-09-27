From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] fix math in acpi_system_write_alarm() (resend)
Date: Sat, 27 Sep 2008 10:10:44 +0800
Message-ID: <1222481444.9104.16.camel@rzhang-dt>
References: <20080926233200.GB6061@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38094 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbYI0CLo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Sep 2008 22:11:44 -0400
In-Reply-To: <20080926233200.GB6061@cosmic.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2008-09-26 at 16:32 -0700, Jordan Crouse wrote:
> This patch fixes the day of month math in acpi_system_write_alarm().
> The previous code assumed that there were 31 days in every month.
> We caught this on June 30 when the month changed, but the system
> stayed suspended waiting for June 31st.
> 
> I know /proc/acpi/alarm is being deprecated, but its still there,
> and I think as long as somebody can use it in anger, it should
> correct.
> 
agree.

len, I think we should also apply this patch.

Subject: ACPI: deprecate /proc/acpi/alarm

/proc/acpi/alarm is deprecated.
users can use /sys/class/rtc/rtcX/wakealarm instead.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig      |    1 +
 drivers/acpi/sleep/proc.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/sleep/proc.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/proc.c
+++ linux-2.6/drivers/acpi/sleep/proc.c
@@ -78,7 +78,7 @@ acpi_system_write_sleep(struct file *fil
 }
 #endif				/* CONFIG_ACPI_PROCFS */
 
-#if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE) || !defined(CONFIG_X86)
+#if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE) || !defined(CONFIG_X86) || !define(CONFIG_ACPI_PROCFS)
 /* use /sys/class/rtc/rtcX/wakealarm instead; it's not ACPI-specific */
 #else
 #define	HAVE_ACPI_LEGACY_ALARM
Index: linux-2.6/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.orig/drivers/acpi/Kconfig
+++ linux-2.6/drivers/acpi/Kconfig
@@ -60,6 +60,7 @@ config ACPI_PROCFS
 	  /proc/acpi/fadt (/sys/firmware/acpi/tables/FACP)
 	  /proc/acpi/debug_layer (/sys/module/acpi/parameters/debug_layer)
 	  /proc/acpi/debug_level (/sys/module/acpi/parameters/debug_level)
+	  /proc/acpi/alarm (/sys/class/rtc/rtcX/wakealarm)
 
 	  This option has no effect on /proc/acpi/ files
 	  and functions which do not yet exist in /sys.


