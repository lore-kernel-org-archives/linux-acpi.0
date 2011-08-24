From: Huang Ying <ying.huang@intel.com>
Subject: Re: kernel oops and panic in acpi_atomic_read under 2.6.39.3.   call
 trace included
Date: Wed, 24 Aug 2011 12:16:15 +0800
Message-ID: <4E547B0F.6000001@intel.com>
References: <201108171751.51648.rick@microway.com>    <8338f9871d1f52f9376a1eca319a7866.squirrel@www.microway.com>    <201108222047.11086.rjw@sisk.pl> <201108221651.35654.rick@microway.com>    <20110823171432.GA10794@redhat.com> <faf1d1211a8d409b39119e44727b3c83.squirrel@www.microway.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060809020007080004040503"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31295 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788Ab1HXEOC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Aug 2011 00:14:02 -0400
In-Reply-To: <faf1d1211a8d409b39119e44727b3c83.squirrel@www.microway.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "rick@microway.com" <rick@microway.com>
Cc: Don Zickus <dzickus@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Houghton <rhoughton@microway.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

This is a multi-part message in MIME format.
--------------060809020007080004040503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Rick,

It appears that panic occurs in acpi_atomic_read.  I think the most 
likely cause is that the acpi_generic_address is not pre-mapped.  Can 
you try the patch attached?

It will print registers mapped and accessed.  To use it, run the 
following command line before workload.

dmesg | grep GHES

Then try to find something like

GHES: gar accessed: x, xxxx

in kernel log when panic occurs.

Best Regards,
Huang Ying


--------------060809020007080004040503
Content-Type: text/x-patch;
 name="dbg_ghes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dbg_ghes.patch"

---
 drivers/acpi/apei/ghes.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -299,6 +299,9 @@ static struct ghes *ghes_new(struct acpi
 		return ERR_PTR(-ENOMEM);
 	ghes->generic = generic;
 	rc = acpi_pre_map_gar(&generic->error_status_address);
+	pr_info(GHES_PFX "gar mapped: %d, 0x%llx\n",
+		generic->error_status_address.space_id,
+		generic->error_status_address.address);
 	if (rc)
 		goto err_free;
 	error_block_length = generic->error_block_length;
@@ -398,6 +401,9 @@ static int ghes_read_estatus(struct ghes
 	u32 len;
 	int rc;
 
+	pr_info(GHES_PFX "gar accessed: %d, 0x%llx\n",
+		g->error_status_address.space_id,
+		g->error_status_address.address);
 	rc = acpi_atomic_read(&buf_paddr, &g->error_status_address);
 	if (rc) {
 		if (!silent && printk_ratelimit())

--------------060809020007080004040503--
