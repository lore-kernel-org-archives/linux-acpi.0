From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH] trival: fix acpi_hest_firmware_first_pci() caused oops
Date: Wed, 5 May 2010 09:39:23 +0800
Message-ID: <20100505013923.GA30454@sli10-desk.sh.intel.com>
References: <1270696575-3385-1-git-send-email-shaohua.li@intel.com>
 <alpine.LFD.2.00.1004201100220.2402@sony>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32788 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760343Ab0EEBji (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 May 2010 21:39:38 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1004201100220.2402@sony>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Apr 20, 2010 at 11:01:21PM +0800, Len Brown wrote:
Hmm, the mail is sent at Apr 20, I received it at Apr 29 :(

> wouldn't it be better for acpi_get_table()
> to return failure for acpi=off?
but acpi_disabled is a linux variable while acpi_get_table is ACPICA code.

Thanks,
Shaohua

> 
> On Thu, 8 Apr 2010, Shaohua Li wrote:
> 
> > acpi_hest_firmware_first_pci() could be called when acpi is disabled
> > and cause system oops.
> > 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > ---
> >  drivers/acpi/hest.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/acpi/hest.c b/drivers/acpi/hest.c
> > index 4bb18c9..1c527a1 100644
> > --- a/drivers/acpi/hest.c
> > +++ b/drivers/acpi/hest.c
> > @@ -123,6 +123,10 @@ int acpi_hest_firmware_first_pci(struct pci_dev *pci)
> >  {
> >  	acpi_status status = AE_NOT_FOUND;
> >  	struct acpi_table_header *hest = NULL;
> > +
> > +	if (acpi_disabled)
> > +		return 0;
> > +
> >  	status = acpi_get_table(ACPI_SIG_HEST, 1, &hest);
> >  
> >  	if (ACPI_SUCCESS(status)) {
> > -- 
> > 1.6.3.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
