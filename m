From: Len Brown <lenb@kernel.org>
Subject: [PATCH 120/122] ACPI suspend: fix build warning when
 CONFIG_ACPI_SLEEP=n
Date: Thu, 23 Oct 2008 02:39:34 -0400
Message-ID: <b849075c0e08ea43400c1341c78eeca76ab08d8a.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbYJWGoI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:08 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:06 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

=46rom: Len Brown <len.brown@intel.com>

drivers/acpi/sleep/main.c:27: warning: =E2=80=98acpi_target_sleep_state=
=E2=80=99 defined but not used

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 7603788..26571ba 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -24,7 +24,6 @@
 #include "sleep.h"
=20
 u8 sleep_states[ACPI_S_STATE_COUNT];
-static u32 acpi_target_sleep_state =3D ACPI_STATE_S0;
=20
 static void acpi_sleep_tts_switch(u32 acpi_state)
 {
@@ -78,6 +77,7 @@ static int acpi_sleep_prepare(u32 acpi_state)
 }
=20
 #ifdef CONFIG_ACPI_SLEEP
+static u32 acpi_target_sleep_state =3D ACPI_STATE_S0;
 /*
  * ACPI 1.0 wants us to execute _PTS before suspending devices, so we =
allow the
  * user to request that behavior by using the 'acpi_old_suspend_orderi=
ng'
--=20
1.5.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
