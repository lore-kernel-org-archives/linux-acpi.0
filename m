From: karsten wiese <annabellesgarden@yahoo.de>
Subject: [PATCH] Resume a K8T800 Mainboard from S3
Date: Thu, 15 Jun 2006 16:45:21 +0200 (CEST)
Message-ID: <20060615144521.42691.qmail@web26503.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1182695020-1150382721=:41990"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web26503.mail.ukl.yahoo.com ([217.146.176.40]:1396 "HELO
	web26503.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030455AbWFOOpW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Jun 2006 10:45:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

--0-1182695020-1150382721=:41990
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

 
 

__________________________________________________
Do You Yahoo!?
Sie sind Spam leid? Yahoo! Mail verfügt über einen herausragenden Schutz gegen Massenmails. 
http://mail.yahoo.com 
--0-1182695020-1150382721=:41990
Content-Type: text/x-diff; name="resume_K8T800.patch"
Content-Description: 737575855-resume_K8T800.patch
Content-Disposition: inline; filename="resume_K8T800.patch"

Resume an AMD64@K8T800 Mainboard from S3

Make an AMD64@K8T800 Mainboard (MS-6702) resume succesfully
reseting "Abnormal Power-OFF" Bit.
BIOS here doesn't vector back to OS if not done.

Signed-off-by: <annabellesgarden@yahoo.de>


diff -upr rc6-mm2/drivers/acpi/sleep/main.c rc6-mm2-kw/drivers/acpi/sleep/main.c
--- rc6-mm2/drivers/acpi/sleep/main.c	2006-06-10 13:12:46.000000000 +0200
+++ rc6-mm2-kw/drivers/acpi/sleep/main.c	2006-06-15 16:21:55.000000000 +0200
@@ -91,6 +91,15 @@ static int acpi_pm_enter(suspend_state_t
 		break;
 
 	case PM_SUSPEND_MEM:
+		if (acpi_state == ACPI_STATE_S3)
+			/* Make an AMD64@K8T800 Mainboard (MS-6702) resume succesfully
+			   reseting "Abnormal Power-OFF" Bit.
+			   BIOS doesn't vector back to OS if not done.
+			   FIXME: Better move this to PCI-Quirks ?
+			*/
+			acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
+						ACPI_REGISTER_PM1_STATUS,
+					       (u16)0x800);
 		do_suspend_lowlevel();
 		break;
 

--0-1182695020-1150382721=:41990--
