From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH] ACPI: eliminate unused variable warning for
	 !ACPI_SLEEP
Date: Tue, 07 Dec 2010 14:52:25 +0000
Message-ID: <4CFE583902000078000266E9@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 drivers/acpi/sleep.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.37-rc5/drivers/acpi/sleep.c
+++ 2.6.37-rc5-acpi-sleep-warning/drivers/acpi/sleep.c
@@ -27,8 +27,6 @@
 
 static u8 sleep_states[ACPI_S_STATE_COUNT];
 
-static u32 acpi_target_sleep_state = ACPI_STATE_S0;
-
 static void acpi_sleep_tts_switch(u32 acpi_state)
 {
 	union acpi_object in_arg = { ACPI_TYPE_INTEGER };
@@ -81,6 +79,8 @@ static int acpi_sleep_prepare(u32 acpi_s
 }
 
 #ifdef CONFIG_ACPI_SLEEP
+static u32 acpi_target_sleep_state = ACPI_STATE_S0;
+
 /*
  * The ACPI specification wants us to save NVS memory regions during hibernation
  * and to restore them during the subsequent resume.  Windows does that also for



