From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [RESEND] [RFC PATCH 6/6] ACPI: set waking vectors in all FACS
	tables
Date: Wed, 12 Nov 2008 09:02:24 -0800
Message-ID: <4911F71203A09E4D9981D27F9D8308580D8AAB60@orsmsx503.amr.corp.intel.com>
References: <1226478552.15014.176.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48706 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbYKLRC2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2008 12:02:28 -0500
In-Reply-To: <1226478552.15014.176.camel@rzhang-dt>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

I'm beginning to think that the complete version of this support will include support for BOTH global locks, in both FACS tables. We don't know how to determine which one is the real one.


>-----Original Message-----
>From: Zhang, Rui
>Sent: Wednesday, November 12, 2008 12:29 AM
>To: Len Brown
>Cc: linux-acpi; Zhang, Rui; Moore, Robert; Rafael J. Wysocki
>Subject: [RESEND] [RFC PATCH 6/6] ACPI: set waking vectors in all FACS
>tables
>
>
>Set the waking vectors in all FACS tables
>in acpi_gbl_root_table_list.
>
>Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>---
> drivers/acpi/hardware/hwsleep.c |   10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
>===================================================================
>--- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c     2008-11-13
>04:29:35.000000000 +0800
>+++ linux-2.6/drivers/acpi/hardware/hwsleep.c  2008-11-13
>04:29:43.000000000 +0800
>@@ -90,6 +90,16 @@
>
>       facs->firmware_waking_vector = (u32)physical_address;
>
>+      status = acpi_get_table(ACPI_SIG_FACS, 2,
>+              ACPI_CAST_INDIRECT_PTR(struct acpi_table_header, &facs));
>+      if (ACPI_FAILURE(status))
>+              return_ACPI_STATUS(AE_OK);
>+
>+      if (facs->version >= 1)
>+              facs->xfirmware_waking_vector = 0;
>+
>+      facs->firmware_waking_vector = (u32)physical_address;
>+
>       return_ACPI_STATUS(AE_OK);
> }
>
>

