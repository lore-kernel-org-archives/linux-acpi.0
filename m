From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [Linux-nvdimm] [PATCH v2 05/20] libnd, nd_acpi: dimm/memory-devices
Date: Fri, 1 May 2015 11:22:21 -0700
Message-ID: <CAPcyv4hUeWzBgOv4q7UHN1+nDVGV2QzNg0dojZvs04YObok3SQ@mail.gmail.com>
References: <20150428181203.35812.60474.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150428182439.35812.81191.stgit@dwillia2-desk3.amr.corp.intel.com>
	<1430502493.23761.145.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33392 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbbEASWW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 May 2015 14:22:22 -0400
Received: by wief7 with SMTP id f7so36488817wie.0
        for <linux-acpi@vger.kernel.org>; Fri, 01 May 2015 11:22:21 -0700 (PDT)
In-Reply-To: <1430502493.23761.145.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Neil Brown <neilb@suse.de>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Fri, May 1, 2015 at 10:48 AM, Toshi Kani <toshi.kani@hp.com> wrote:
> On Tue, 2015-04-28 at 14:24 -0400, Dan Williams wrote:
>> Register the memory devices described in the nfit as libnd 'dimm'
>> devices on an nd bus.  The kernel assigned device id for dimms is
>> dynamic.  If userspace needs a more static identifier it should consult
>> a provider-specific attribute.  In the case where NFIT is the provider,
>> the 'nmemX/nfit/handle' or 'nmemX/nfit/serial' attributes may be used
>> for this purpose.
>  :
>> +
>> +static int nd_acpi_register_dimms(struct acpi_nfit_desc *acpi_desc)
>> +{
>> +     struct nfit_mem *nfit_mem;
>> +
>> +     list_for_each_entry(nfit_mem, &acpi_desc->dimms, list) {
>> +             struct nd_dimm *nd_dimm;
>> +             unsigned long flags = 0;
>> +             u32 nfit_handle;
>> +
>> +             nfit_handle = __to_nfit_memdev(nfit_mem)->nfit_handle;
>> +             nd_dimm = nd_acpi_dimm_by_handle(acpi_desc, nfit_handle);
>> +             if (nd_dimm) {
>> +                     /*
>> +                      * If for some reason we find multiple DCRs the
>> +                      * first one wins
>> +                      */
>> +                     dev_err(acpi_desc->dev, "duplicate DCR detected: %s\n",
>> +                                     nd_dimm_name(nd_dimm));
>> +                     continue;
>> +             }
>> +
>> +             if (nfit_mem->bdw && nfit_mem->memdev_pmem)
>> +                     flags |= NDD_ALIASING;
>
> Does this check work for a NVDIMM card which has multiple pmem regions
> with label info, but does not have any bdw region configured?

If you have multiple pmem regions then you don't have aliasing and
don't need a label.  You'll get an nd_namespace_io per region.

> The code assumes that namespace_pmem (NDD_ALIASING) and namespace_blk
> have label info.  There may be an NVDIMM card with a single blk region
> without label info.

I'd really like to suggest that labels are only for resolving aliasing
and that if you have a BLK-only NVDIMM you'll get an automatic
namespace created the same as a PMEM-only.  Partitioning is always
there to provide sub-divisions of a namespace.  The only reason to
support multiple BLK-namespaces per-region is to give each a different
sector size.  I may eventually need to relent on this position, but
I'd really like to understand the use case for requiring labels when
aliasing is not present as it seems like a waste to me.

> Instead of using the namespace types to assume the label info, how about
> adding a flag to indicate the presence of the label info?  This avoids
> the separation of namespace_io and namespace_pmem for the same pmem
> driver.

To what benefit?
