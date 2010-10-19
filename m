From: Stephen Hemminger <shemminger@vyatta.com>
Subject: [PATCH] acpi: make sleep_states and acpi_gts_bfs_check static
Date: Mon, 18 Oct 2010 18:47:25 -0700
Message-ID: <20101018184725.7e3ddf33@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.vyatta.com ([76.74.103.46]:47986 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328Ab0JSBr3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Oct 2010 21:47:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

Only used in one file so should be static.

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

--- a/drivers/acpi/sleep.c	2010-10-06 13:49:36.786991555 +0900
+++ b/drivers/acpi/sleep.c	2010-10-06 13:50:24.185974243 +0900
@@ -25,7 +25,7 @@
 #include "internal.h"
 #include "sleep.h"
 
-u8 sleep_states[ACPI_S_STATE_COUNT];
+static u8 sleep_states[ACPI_S_STATE_COUNT];
 
 static void acpi_sleep_tts_switch(u32 acpi_state)
 {
@@ -680,7 +680,7 @@ static void acpi_power_off(void)
  * paths through the BIOS, so disable _GTS and _BFS by default,
  * but do speak up and offer the option to enable them.
  */
-void __init acpi_gts_bfs_check(void)
+static void __init acpi_gts_bfs_check(void)
 {
 	acpi_handle dummy;
 
