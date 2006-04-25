From: Arnaud Patard <apatard@mandriva.com>
Subject: [PATCH RFC] Suppress power button event on S3 resume
Date: Tue, 25 Apr 2006 16:03:18 +0200
Message-ID: <m3psj5bvmh.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ezoffice.mandriva.com ([84.14.106.134]:25616 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP id S932226AbWDYN55
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Apr 2006 09:57:57 -0400
Received: from anduin.mandriva.com (anduin.mandriva.com [192.168.100.45])
	by office.mandriva.com (Postfix) with ESMTP id C01443C7
	for <linux-acpi@vger.kernel.org>; Tue, 25 Apr 2006 15:57:52 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id 0E8E5FF855
	for <linux-acpi@vger.kernel.org>; Tue, 25 Apr 2006 16:03:19 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--=-=-=


Hi,

I got this week-end the problem described by the thread "how to back
from suspend without shutdown". I've hacked a little patch for solving
this issue. I've tested with the 2.6.17rc1 on two platforms and it's
working.

Regards,
Arnaud Patard


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
 filename=suppress_power_button_event_on_s3_resume.patch

Suppress POWER_BUTTON event on S3 resume.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>

 ---

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -105,6 +105,14 @@ static int acpi_pm_enter(suspend_state_t
 	default:
 		return -EINVAL;
 	}
+
+	/* ACPI 3.0 specs (P62) says that it's the responsabilty
+	 * of the OSPM to clear the status bit [ implying that the
+	 * POWER_BUTTON event should not reach userspace ]
+	 */
+	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3))
+		acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
+
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
 

--=-=-=--

