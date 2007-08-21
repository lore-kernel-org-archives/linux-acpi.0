From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: [Git Patch] ACPI: Fix a warning of discarding qualifiers from
	pointer target type
Date: Tue, 21 Aug 2007 23:07:14 +0800
Message-ID: <20070821150714.GA7591@hacking>
References: <20070821132038.GA22254@ff.dom.local>
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:10521 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760372AbXHUPHm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Aug 2007 11:07:42 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1230194rvb
        for <linux-acpi@vger.kernel.org>; Tue, 21 Aug 2007 08:07:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070821132038.GA22254@ff.dom.local>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarek Poplawski <jarkao2@o2.pl>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de, len.brown@intel.com, Andrew Morton <akpm@osdl.org>


Fix this warning:

drivers/acpi/ec.c: In function `acpi_ec_ecdt_probe':
drivers/acpi/ec.c:873: warning: passing arg 1 of `acpi_get_devices' discards qualifiers from pointer target type

(I don't know whether this fix hits the real problem.)

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---
 drivers/acpi/ec.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.23-rc3-git3/drivers/acpi/ec.c
===================================================================
--- linux-2.6.23-rc3-git3.orig/drivers/acpi/ec.c
+++ linux-2.6.23-rc3-git3/drivers/acpi/ec.c
@@ -869,8 +869,8 @@ int __init acpi_ec_ecdt_probe(void)
 		boot_ec->handle = ACPI_ROOT_OBJECT;
 	} else {
 		printk(KERN_DEBUG PREFIX "Look up EC in DSDT\n");
-		status = acpi_get_devices(ec_device_ids[0].id, ec_parse_device,
-						boot_ec, NULL);
+		status = acpi_get_devices((char *)ec_device_ids[0].id,
+						ec_parse_device, boot_ec, NULL);
 		if (ACPI_FAILURE(status))
 			goto error;
 	}
