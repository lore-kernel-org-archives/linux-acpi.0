From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/4] Support persistent memory as reserved type in e820/EFI
Date: Wed, 9 Mar 2016 11:30:04 -0800
Message-ID: <CAPcyv4jxyDSQNC6wQDCOH3OLa-gUdeiOpKo1Pq88Av1joZqUtw@mail.gmail.com>
References: <1457552817-13938-1-git-send-email-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34736 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933634AbcCITaF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Mar 2016 14:30:05 -0500
Received: by mail-ob0-f174.google.com with SMTP id ts10so57659010obc.1
        for <linux-acpi@vger.kernel.org>; Wed, 09 Mar 2016 11:30:05 -0800 (PST)
In-Reply-To: <1457552817-13938-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Mar 9, 2016 at 11:46 AM, Toshi Kani <toshi.kani@hpe.com> wrote:
> ACPI 6 defines persistent memory (PMEM) ranges in multiple
> firmware interfaces, e820, EFI, and ACPI NFIT table.  This EFI
> change, however, leads to hit a bug in the grub bootloader, which
> treats EFI_PERSISTENT_MEMORY type as regular memory and corrupts
> stored user data [1].
>
> Therefore, BIOS may set generic reserved type in e820 and EFI
> to cover PMEM ranges.  The kernel can initialize PMEM ranges
> from ACPI NFIT table alone.
>
> This scheme cause a problem in the iomem table, though.  On x86,
> for instance, e820_reserve_resources() initializes top-level entries
> (iomem_resource.child) from the e820 table at early boot-time.
> This creates "reserved" entry for a PMEM range, which does not allow
> region_intersects() to check with PMEM type.
>
> This patch-set adds remove_resource(), exports insert/remove_resource(),
> and changes the NFIT driver to insert a PMEM entry to the iomem table.
>
> [1] https://lists.gnu.org/archive/html/grub-devel/2015-11/msg00209.html
>
> - Patch 1 fixes __request_region() to handle inheritance of attribute
>   properly.  This patch is independent from this series.
> - Patch 2 adds remove_resource() interface.
> - Patch 3 exports insert_resource() and remove_resource().
> - Patch 4 changes the ACPI nfit driver to call insert_resource() to
>   insert a PMEM range from NFIT.
>
> ---
> v3:
>  - Drop devm_insert/remove_resource(), and export insert/remove_resource().
>    (Linus Torvalds)
>
> v2:
>  - Change the NFIT driver to call insert_resource() to insert a PMEM entry
>    when necessary. (Dan Williams)
>  - The NFIT driver still needs to allow unloading. (Dan Williams)
>
> ---
> This patch-set is based on the tip tree, which has the following patchset.
> https://lkml.org/lkml/2016/1/26/886
>
> ---
> Toshi Kani (4):
>  1/4 resource: Change __request_region to inherit from immediate parent
>  2/4 resource: Add remove_resource interface
>  3/4 resource: Export insert_resource and remove_resource
>  4/4 ACPI: Change NFIT driver to insert new resource
>
> ---
>  drivers/acpi/nfit.c    | 48 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioport.h |  1 +
>  kernel/resource.c      | 60 +++++++++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 101 insertions(+), 8 deletions(-)

Hi Toshi, this looks good to me and passes my testing.

I'll give it until the end of the day if there is any more feedback
and otherwise merge it into the pending libnvdimm updates for 4.6.
