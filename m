From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [RESEND] [RFC PATCH 6/6] ACPI: set waking vectors in all FACS
	tables
Date: Thu, 13 Nov 2008 10:28:44 +0800
Message-ID: <1226543324.15014.196.camel@rzhang-dt>
References: <1226478552.15014.176.camel@rzhang-dt>
	 <4911F71203A09E4D9981D27F9D8308580D8AAB60@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29584 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbYKMC2S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 21:28:18 -0500
In-Reply-To: <4911F71203A09E4D9981D27F9D8308580D8AAB60@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thu, 2008-11-13 at 01:02 +0800, Moore, Robert wrote:
> I'm beginning to think that the complete version of this support will include support for BOTH global locks, in both FACS tables. We don't know how to determine which one is the real one.
> 
well, yes, we can't fix this bug until we know which FACS to use.
another proposal is to use RSDT instead of XSDT if multiple valid FACS
tables exist. Just like the way we handle the "32bit/64bit GPE address
not match" problem.

thanks,
rui

> >-----Original Message-----
> >From: Zhang, Rui
> >Sent: Wednesday, November 12, 2008 12:29 AM
> >To: Len Brown
> >Cc: linux-acpi; Zhang, Rui; Moore, Robert; Rafael J. Wysocki
> >Subject: [RESEND] [RFC PATCH 6/6] ACPI: set waking vectors in all FACS
> >tables
> >
> >
> >Set the waking vectors in all FACS tables
> >in acpi_gbl_root_table_list.
> >
> >Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >---
> > drivers/acpi/hardware/hwsleep.c |   10 ++++++++++
> > 1 file changed, 10 insertions(+)
> >
> >Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
> >===================================================================
> >--- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c	2008-11-13
> >04:29:35.000000000 +0800
> >+++ linux-2.6/drivers/acpi/hardware/hwsleep.c	2008-11-13
> >04:29:43.000000000 +0800
> >@@ -90,6 +90,16 @@
> >
> > 	facs->firmware_waking_vector = (u32)physical_address;
> >
> >+	status = acpi_get_table(ACPI_SIG_FACS, 2,
> >+		ACPI_CAST_INDIRECT_PTR(struct acpi_table_header, &facs));
> >+	if (ACPI_FAILURE(status))
> >+		return_ACPI_STATUS(AE_OK);
> >+
> >+	if (facs->version >= 1)
> >+		facs->xfirmware_waking_vector = 0;
> >+
> >+	facs->firmware_waking_vector = (u32)physical_address;
> >+
> > 	return_ACPI_STATUS(AE_OK);
> > }
> >
> >
> 

