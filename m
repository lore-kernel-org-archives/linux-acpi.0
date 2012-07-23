From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Resend][PATCH] ACPI / PM: Fix build warning in sleep.c for CONFIG_ACPI_SLEEP unset
Date: Mon, 23 Jul 2012 21:01:02 +0200
Message-ID: <201207232101.02472.rjw@sisk.pl>
References: <20120721214156.GA2515@linux.vnet.ibm.com> <201207221940.51764.rjw@sisk.pl> <20120722202843.GQ2435@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120722202843.GQ2435@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: paulmck@linux.vnet.ibm.com, "Kirill A. Shutemov" <kirill@shutemov.name>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


If CONFIG_ACPI_SLEEP is unset, the compiler complains that
pwr_btn_event_pending is defined but not used.  To silence the
warning, move the definition of pwr_btn_event_pending under an
appropriate #ifdef.

Reported-by: Paul E. McKenney <paul.mckenney@linaro.org>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/acpi/sleep.c
===================================================================
--- linux.orig/drivers/acpi/sleep.c
+++ linux/drivers/acpi/sleep.c
@@ -57,7 +57,6 @@ MODULE_PARM_DESC(gts, "Enable evaluation
 MODULE_PARM_DESC(bfs, "Enable evaluation of _BFS on resume".);
 
 static u8 sleep_states[ACPI_S_STATE_COUNT];
-static bool pwr_btn_event_pending;
 
 static void acpi_sleep_tts_switch(u32 acpi_state)
 {
@@ -110,6 +109,7 @@ static int acpi_sleep_prepare(u32 acpi_s
 
 #ifdef CONFIG_ACPI_SLEEP
 static u32 acpi_target_sleep_state = ACPI_STATE_S0;
+static bool pwr_btn_event_pending;
 
 /*
  * The ACPI specification wants us to save NVS memory regions during hibernation
