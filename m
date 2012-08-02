From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v2 1/2] ACPI: Replace acpi_get_table_with_size() with
 acpi_get_table()
Date: Thu, 2 Aug 2012 13:10:21 +0800
Message-ID: <20120802131021.7ee648e5@feng-i7>
References: <1343803064-5389-1-git-send-email-feng.tang@intel.com>
	<501998BB.8060507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:5274 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716Ab2HBFPd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Aug 2012 01:15:33 -0400
In-Reply-To: <501998BB.8060507@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Don Dutile <ddutile@redhat.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, yinghai@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, robert.moore@intel.com, agordeev@redhat.com, suresh.b.siddha@intel.com

On Wed, 1 Aug 2012 16:59:39 -0400
Don Dutile <ddutile@redhat.com> wrote:

> On 08/01/2012 02:37 AM, Feng Tang wrote:
> > This is a preparation for removing the acpi_get_table_with_size(), as this
> > function could be well covered by acpi_get_table(), and there is no need
> > to have both of them to exist.
> >
> > v2: As reminded by Yinghai, apply the replacment to
> > drivers/iommu/amd_iommu_init.c which is a new user of the
> > acpi_get_table_with_size().
> >
> > Signed-off-by: Feng Tang<feng.tang@intel.com>
> > ---
> >   arch/x86/kernel/apic/es7000_32.c |    7 +++----
> >   drivers/acpi/tables.c            |   21 +++++++++------------
> >   drivers/iommu/amd_iommu_init.c   |   10 ++++------
> >   drivers/iommu/dmar.c             |   14 +++++++-------
> >   4 files changed, 23 insertions(+), 29 deletions(-)
> >
> > diff --git a/arch/x86/kernel/apic/es7000_32.c
> > b/arch/x86/kernel/apic/es7000_32.c index 0874799..ae30b39 100644
> > --- a/arch/x86/kernel/apic/es7000_32.c
> > +++ b/arch/x86/kernel/apic/es7000_32.c
> > @@ -242,19 +242,18 @@ static int __init find_unisys_acpi_oem_table(unsigned
> > long *oem_addr) {
> >   	struct acpi_table_header *header = NULL;
> >   	struct es7000_oem_table *table;
> > -	acpi_size tbl_size;
> >   	acpi_status ret;
> >   	int i = 0;
> >
> >   struct acpi_table_header * __initdata dmar_tbl;
> > -static acpi_size dmar_tbl_size;
> >
> >   static void __init dmar_register_drhd_unit(struct dmar_drhd_unit *drhd)
> >   {
> > @@ -285,10 +284,8 @@ static int __init dmar_table_detect(void)
> >   	acpi_status status = AE_OK;
> >
> >   	/* if we could find DMAR table, then there are DMAR devices */
> > -	status = acpi_get_table_with_size(ACPI_SIG_DMAR, 0,
> > -				(struct acpi_table_header **)&dmar_tbl,
> > -				&dmar_tbl_size);
> > -
> > +	status = acpi_get_table(ACPI_SIG_DMAR, 0,
> > +				(struct acpi_table_header **)&dmar_tbl);
> why is this cast needed if dmar_tbl is defined as struct acpi_table_header * ?

Good catch, this is from the original code and I didn't notice that when making
patch, will send a fix for it.

Thanks,
Feng



