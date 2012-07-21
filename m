From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH] acpi: fix pwr_btn_event_pending build error
Date: Sat, 21 Jul 2012 14:41:56 -0700
Message-ID: <20120721214156.GA2515@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:38823 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606Ab2GUVmA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Jul 2012 17:42:00 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Sat, 21 Jul 2012 15:42:00 -0600
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hello!

A recent build for KVM on x86 resulted in the following build error:

drivers/acpi/sleep.c:60:13: warning: =E2=80=98pwr_btn_event_pending=E2=80=
=99 defined but not
+used [-Wunused-variable]

This patch silences this error.

Signed-off-by: Paul E. McKenney <paul.mckenney@linaro.org>

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 8856102..18347aa 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -57,7 +57,9 @@ MODULE_PARM_DESC(gts, "Enable evaluation of _GTS on s=
uspend.");
 MODULE_PARM_DESC(bfs, "Enable evaluation of _BFS on resume".);
=20
 static u8 sleep_states[ACPI_S_STATE_COUNT];
+#ifdef CONFIG_ACPI_SLEEP
 static bool pwr_btn_event_pending;
+#endif /* #ifdef CONFIG_ACPI_SLEEP */
=20
 static void acpi_sleep_tts_switch(u32 acpi_state)
 {

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
