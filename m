From: liguang <lig.fnst@cn.fujitsu.com>
Subject: [rebased-again][PATCH 4/4] remove include asm/acpi.h in process_driver.c
Date: Mon, 25 Feb 2013 10:38:37 +0800
Message-ID: <1361759917-5195-5-git-send-email-lig.fnst@cn.fujitsu.com>
References: <1361759917-5195-1-git-send-email-lig.fnst@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361759917-5195-1-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, hpa@zytor.com, pavel@ucw.cz, rjw@sisk.pl, lv.zheng@intel.com, jarkko.sakkinen@intel.com, dave@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Cc: liguang <lig.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

process_driver.c include linux/acpi.h which already
include asm/acpi.h, so remove it.

Reviewed-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
---
 drivers/acpi/processor_driver.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index df34bd0..341258a 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -53,7 +53,6 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 #include <asm/smp.h>
-#include <asm/acpi.h>
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
-- 
1.7.2.5
