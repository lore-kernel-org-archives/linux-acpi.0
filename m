From: Feng Tang <feng.tang@intel.com>
Subject: Re: next: sfi build fails when !CONFIG_ACPI
Date: Thu, 23 Jul 2009 18:15:25 +0800
Message-ID: <20090723181525.475692d3@feng-desktop>
References: <a4423d670907160148n66760052wbef60e4a2c3c7941@mail.gmail.com>
	<alpine.LFD.2.00.0907162145140.3531@sony-vgn-z540>
	<a4423d670907170657o2c68c479j9b4810af5adad29f@mail.gmail.com>
	<a4423d670907230143l78f324dewefa4cb8990ef4266@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23796 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbZGWKQY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jul 2009 06:16:24 -0400
In-Reply-To: <a4423d670907230143l78f324dewefa4cb8990ef4266@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-next <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 23 Jul 2009 16:43:30 +0800
Alexander Beregalov <a.beregalov@gmail.com> wrote:

> 2009/7/17 Alexander Beregalov <a.beregalov@gmail.com>:
> > 2009/7/17 Len Brown <lenb@kernel.org>:
> >>> drivers/sfi/sfi_core.c: In function 'sfi_init':
> >>> drivers/sfi/sfi_core.c:346: error: 'acpi_disabled' undeclared
> >>> (first use in this function)
> >>> drivers/sfi/sfi_core.c:346: error: (Each undeclared identifier is
> >>> reported only once
> >>> drivers/sfi/sfi_core.c:346: error: for each function it appears
> >>> in.)
> >>>
> >>>
> >>> $ grep ACPI .config
> >>> # Power management and ACPI options
> >>
> >> It builds for me.
> >> Please send me the complete failing .config
> >
> > Attached (x86_64)
> 
> Still fails for me in the same way,
> X86_64
> next-20090723

sorry for the late response, please try the following patch:

diff --git a/drivers/sfi/sfi_core.c b/drivers/sfi/sfi_core.c
index 62e2f98..fa66824 100644
--- a/drivers/sfi/sfi_core.c
+++ b/drivers/sfi/sfi_core.c
@@ -361,9 +361,6 @@ static __init int sfi_find_syst(void)
 
 void __init sfi_init(void)
 {
-	if (!acpi_disabled)
-		disable_sfi();
-
 	if (sfi_disabled)
 		return;
 
Thanks,
Feng
