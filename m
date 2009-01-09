From: Len Brown <lenb@kernel.org>
Subject: [PATCH 92/94] ACPI: fix build warning
Date: Fri, 09 Jan 2009 04:27:34 -0500
Message-ID: <2602a671ad7321a25d253c080837e4569a9bceed.1231492614.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44602 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbZAIJ2v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:51 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700BQ96BUP6Y6@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:42 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

=46rom: Len Brown <len.brown@intel.com>

when CONFIG_RTC_DRV_CMOS=3Dm
and thus !defined(HAVE_ACPI_LEGACY_ALARM)

drivers/acpi/proc.c:85: warning: =E2=80=98cmos_bcd_read=E2=80=99 declar=
ed =E2=80=98static=E2=80=99 but
never defined

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/proc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 232d4b6..2d0e6b5 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -84,10 +84,10 @@ acpi_system_write_sleep(struct file *file,
 #define	HAVE_ACPI_LEGACY_ALARM
 #endif
=20
-static u32 cmos_bcd_read(int offset, int rtc_control);
-
 #ifdef	HAVE_ACPI_LEGACY_ALARM
=20
+static u32 cmos_bcd_read(int offset, int rtc_control);
+
 static int acpi_system_alarm_seq_show(struct seq_file *seq, void *offs=
et)
 {
 	u32 sec, min, hr;
--=20
1.5.6.6

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
