From: Yann Droneaud <ydroneaud@mandriva.com>
Subject: [PATCH 2/2] IPMI and acpi=off|ht : ipmi_si_intf-acpi-disabled
Date: 16 May 2005 23:47:52 +0200
Message-ID: <m2y8aeyh9z.fsf@firedrake.mandriva.com>
References: <m27jhyzwj6.fsf@firedrake.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261911AbVEPVud@vger.kernel.org>
In-Reply-To: <m27jhyzwj6.fsf@firedrake.mandriva.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
Cc: Yann Droneaud <ydroneaud@mandriva.com>
List-Id: linux-acpi@vger.kernel.org


This patch fix ipmi_si_intf to not use ACPI tables if the ACPI
subsystem is disabled.

--- linux-2.6.11.9/drivers/char/ipmi/ipmi_si_intf.c	2005-05-11 18:41:12.000000000 -0400
+++ linux-2.6.11.9-fixes/drivers/char/ipmi/ipmi_si_intf.c	2005-05-16 16:38:11.780589696 -0400
@@ -1443,6 +1443,9 @@ static int try_init_acpi(int intf_num, s
 	char             *io_type;
 	u8 		 addr_space;
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	if (acpi_failure)
 		return -ENODEV;
 

Signed-Off-by: ydroneaud@mandriva.com

-- 
Yann Droneaud <ydroneaud@mandriva.com>
Consulting Engineer
Professional Services
Mandriva http://mandriva.com/ (previously known as Mandrakesoft)
