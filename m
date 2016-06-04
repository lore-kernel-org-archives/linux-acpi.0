From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] libnvdimm, nfit: treat volatile virtual CD region as
 read-only pmem
Date: Sat, 4 Jun 2016 19:01:56 +0800
Message-ID: <20160604110156.GA4558@linux-rxt1.site>
References: <1464938015-5489-1-git-send-email-jlee@suse.com>
 <CAPcyv4iLb9qzXZTLL5z-RH_CRObnRfzx=vGTvVvieJUEwNvtRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:32971 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbcFDLCk (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
	Sat, 4 Jun 2016 07:02:40 -0400
Content-Disposition: inline
In-Reply-To: <CAPcyv4iLb9qzXZTLL5z-RH_CRObnRfzx=vGTvVvieJUEwNvtRw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gary Lin <GLin@suse.com>

Hi Dan, 

Thanks for your review.

On Fri, Jun 03, 2016 at 12:27:34PM -0700, Dan Williams wrote:
> On Fri, Jun 3, 2016 at 12:13 AM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > This patch adds codes to treat a volatile virtual CD region as a
> > read-only pmem region, then read-only /dev/pmem* device can be mounted
> > with iso9660.
> >
> > It's useful to work with the httpboot in EFI firmware to pull a remote
> > ISO file to the local memory region for booting and installation.
> >
> > Wiki page of UEFI HTTPBoot with OVMF:
> >         https://en.opensuse.org/UEFI_HTTPBoot_with_OVMF
> >
> > Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
> > Cc: Gary Lin <GLin@suse.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > ---
> >  drivers/acpi/nfit.c          |  8 +++++++-
> >  drivers/nvdimm/region_devs.c | 26 +++++++++++++++++++++++++-
> >  include/linux/libnvdimm.h    |  2 ++
> >  3 files changed, 34 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> > index 2215fc8..b100a17 100644
> > --- a/drivers/acpi/nfit.c
> > +++ b/drivers/acpi/nfit.c
> > @@ -1949,6 +1949,7 @@ static int acpi_nfit_init_mapping(struct acpi_nfit_desc *acpi_desc,
> >         switch (nfit_spa_type(spa)) {
> >         case NFIT_SPA_PM:
> >         case NFIT_SPA_VOLATILE:
> > +       case NFIT_SPA_VCD:
> >                 nd_mapping->start = memdev->address;
> >                 nd_mapping->size = memdev->region_size;
> >                 break;
> 
> Why do we need to distinguish NFIT_SPA_VOLATILE vs NFIT_SPA_VCD, i.e.
> what happens if something writes to a VCD device?

Actually I didn't try to write SPA-VCD device before. Every time I mount it
that the system responses read-only:

# mount /dev/pmem0 /mnt/
mount: /dev/pmem0 is write-protected, mounting read-only

If it can be written, then I think there have no difference between
NFIT_SPA_VOLATILE with NFIT_SPA_VCD region.

I implemented this patch to treat VCD region as read-only pmem because the
pmem region generates /dev/pmem* device that it can be mounted.

Maybe I missed. Does NFIT_SPA_VOLATILE region also generate a device in /dev
that it can be mounted with filesystem? Then I think treat the VCD region as
a read-only VOLATILE region that's also a solution.


Thanks a lot!
Joey Lee
