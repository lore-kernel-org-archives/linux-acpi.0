From: Len Brown <len.brown@intel.com>
Subject: Re: udev broken by recent ACPI git commits
Date: Mon, 13 Nov 2006 06:16:37 -0500
Message-ID: <200611130616.38174.len.brown@intel.com>
References: <200611010004.28483.rjw@sisk.pl> <200611011147.42498.rjw@sisk.pl> <200611030039.28762.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WQFWFUwQWUoabgV"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:12772 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1754428AbWKMLOT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Nov 2006 06:14:19 -0500
In-Reply-To: <200611030039.28762.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

--Boundary-00=_WQFWFUwQWUoabgV
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Please test that the latest ACPICA patch works on your system and shout if it doesn't.
> In particular, if you've got an nx6325 like Rafael's, it would be interesting to know
> if you see the same issue.
> 
> You can snag the latest ACPICA patch vs  top of Linus' tree via git or plain patch here:
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git acpica
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.19/acpi-acpica-20061011-2.6.19-rc4.diff.gz

Rafael,
What BIOS version is running on your nx6325?
What do you see if you add the patch below to the ACPICA  patch?

thanks,
-Len


--Boundary-00=_WQFWFUwQWUoabgV
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="git.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="git.diff"

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 328bd73..d39cd90 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -513,6 +513,9 @@ static unsigned long get_cmos_time(void)
 		if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
 					acpi_gbl_FADT.century)
 			extyear = CMOS_READ(acpi_gbl_FADT.century);
+printk("get_cmos_time(): acpi_gbl_FADT.century %d extyear %d\n",
+	acpi_gbl_FADT.century, extyear);
+extyear = 0;
 #endif
 	} while (sec != CMOS_READ(RTC_SECONDS));
 

--Boundary-00=_WQFWFUwQWUoabgV--
