From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [Linux-nvdimm] [PATCH 03/21] nd_acpi: initial core implementation
 and nfit skeleton
Date: Tue, 28 Apr 2015 12:21:22 -0700
Message-ID: <CAPcyv4gLmXGEWHTOf1mZicWDoeV6os04Nq46e0pCAKNBRja96w@mail.gmail.com>
References: <20150418013256.25237.96403.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150418013530.25237.28383.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150428125305.GB30852@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38387 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030869AbbD1TVX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2015 15:21:23 -0400
Received: by wiun10 with SMTP id n10so41029561wiu.1
        for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2015 12:21:22 -0700 (PDT)
In-Reply-To: <20150428125305.GB30852@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvdimm <linux-nvdimm@ml01.01.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Apr 28, 2015 at 5:53 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Apr 17, 2015 at 09:35:30PM -0400, Dan Williams wrote:
>> new file mode 100644
>> index 000000000000..5fa74f124b3e
>> --- /dev/null
>> +++ b/drivers/block/nd/Kconfig
>> @@ -0,0 +1,44 @@
>> +config ND_ARCH_HAS_IOREMAP_CACHE
>> +     depends on (X86 || IA64 || ARM || ARM64 || SH || XTENSA)
>> +     def_bool y
>
> As mentioned before please either define this symbol in each
> arch Kconfig, or just ensure every architecture proides a stub.
>
> But more importantly it doesn't seem like you're actually using
> ioremap_cache anywhere.  Allowing a cached ioremap would be a very
> worthwile addition to the pmem drivers once we have the proper
> memcpy functions making it safe, and is one of the high priority
> todo items for the pmem driver.
>
>> +
>> +menuconfig NFIT_DEVICES
>> +     bool "NVDIMM (NFIT) Support"
>
> Please just call all the symbolc and file names nvdimm instead of nfit
> or nd to make eryones life simpler for the generic code.  Just use the
> EFI/ACPI terminology in those parts that actually parse those tables.

Done in v2.
