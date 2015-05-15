From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [Linux-nvdimm] [PATCH v2 03/20] nd_acpi, nfit-test: manufactured
 NFITs for interface development
Date: Fri, 15 May 2015 13:50:35 -0700
Message-ID: <CAPcyv4ipwNdHy=qAS+EeuQaUDVnVe3aOab+CGO9ojrb-hZvkXg@mail.gmail.com>
References: <20150428181203.35812.60474.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150428182428.35812.95800.stgit@dwillia2-desk3.amr.corp.intel.com>
	<x49pp61wptt.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <x49pp61wptt.fsf@segfault.boston.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-nvdimm <linux-nvdimm@ml01.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, May 15, 2015 at 1:25 PM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
>
>> +config NFIT_TEST
>> +     tristate "NFIT TEST: Manufactured NFIT for interface testing"
>> +     depends on DMA_CMA
>> +     depends on LIBND=m
>> +     depends on ND_ACPI
>> +     depends on m
>> +     help
>> +       For development purposes register a manufactured
>> +       NFIT table to verify the resulting device model topology.
>> +       Note, this module arranges for ioremap_cache() to be
>> +       overridden locally to allow simulation of system-memory as an
>> +       io-memory-resource.
>> +
>> +       Note, this test expects to be able to find at least 256MB of
>> +       CMA space (CONFIG_CMA_SIZE_MBYTES, cma=) or it will fail to
>> +       load.
>> +
>> +       Say N unless you are doing development of the 'nd' subsystem.
>> +
>
> Too many TLAs.  I'm guessing CMA means Conventional Memory Area to you.
> To me it means contiguous memory allocator.

I means Contiguous Memory Allocator to me too.

> Anyway, please define
> acronyms when you use them, especially in help text.  The help text also
> doesn't really explain where it will find this memory.  Would it be
> possible to provide more direction there?

I didn't think I needed to define CMA in the context of Kconfig, but
I'll replace it with CONFIG_DMA_CMA to be more clear.

> I don't have any useful commentary on the patch itself.  I do wonder if
> you shouldn't move this to the end, as it's hardly an integral part of
> the patch set.

True.  The patches are currently in "development order" in that I
created the test infrastructure before the rest of the implementation.
But, I agree it makes sense to move this to the end for the next
posting.
