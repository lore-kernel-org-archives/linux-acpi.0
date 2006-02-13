From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] HPET: handle multiple ACPI EXTENDED_IRQ resources
Date: Mon, 13 Feb 2006 13:49:13 -0800
Message-ID: <20060213134913.13352735.akpm@osdl.org>
References: <200602071650.27379.bjorn.helgaas@hp.com>
	<20060212225528.GC21804@localhost>
	<200602131424.28369.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:57306 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964870AbWBMVuK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Feb 2006 16:50:10 -0500
In-Reply-To: <200602131424.28369.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: bob.picco@hp.com, robert.picco@hp.com, venkatesh.pallipadi@intel.com, linux-acpi@vger.kernel.org, len.brown@intel.com, ambx1@neo.rr.com, rdunlap@xenotime.net

Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>
>  Andrew, I know it's late in the 2.6.16 cycle, but it would be really
>  nice if this patch made it.  Without it, HPETs on new HP boxes don't
>  work, so we're going to have to get it in the distros some way or
>  another.

OK..

What about hpet-fix-acpi-memory-range-length-handling.patch?


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

ACPI address space descriptors contain _MIN, _MAX, and _LEN.  _MIN and _MAX
are the bounds within which the region can be moved (this is clarified in
Table 6-38 of the ACPI 3.0 spec).  We should use _LEN to determine the size
of the region, not _MAX - _MIN + 1.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/char/hpet.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

diff -puN drivers/char/hpet.c~hpet-fix-acpi-memory-range-length-handling drivers/char/hpet.c
--- 25/drivers/char/hpet.c~hpet-fix-acpi-memory-range-length-handling	Tue Feb  7 15:47:01 2006
+++ 25-akpm/drivers/char/hpet.c	Tue Feb  7 15:47:01 2006
@@ -925,11 +925,8 @@ static acpi_status hpet_resources(struct
 	status = acpi_resource_to_address64(res, &addr);
 
 	if (ACPI_SUCCESS(status)) {
-		unsigned long size;
-
-		size = addr.maximum - addr.minimum + 1;
 		hdp->hd_phys_address = addr.minimum;
-		hdp->hd_address = ioremap(addr.minimum, size);
+		hdp->hd_address = ioremap(addr.minimum, addr.address_length);
 
 		if (hpet_is_known(hdp)) {
 			printk(KERN_DEBUG "%s: 0x%lx is busy\n",
_


(It's hard for me to judge when people don't describe what the impact of
the problem is, so thanks for the poke).

