From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 09/21] libnd, nd_pmem: add libnd support to the pmem driver
Date: Sat, 23 May 2015 09:59:28 -0700
Message-ID: <CAA9_cmc7O+uCViX9-NUZ_cVsV6KbCPs+4JkgyVD8XAFJXX80Qg@mail.gmail.com>
References: <20150520205536.32249.89779.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150520205700.32249.9798.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150523143935.GA23903@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33830 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757957AbbEWQ73 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 May 2015 12:59:29 -0400
In-Reply-To: <20150523143935.GA23903@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Neil Brown <neilb@suse.de>, linux-nvdimm@ml01.01.org, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Jens Axboe <axboe@fb.com>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>

On Sat, May 23, 2015 at 7:39 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, May 20, 2015 at 04:57:00PM -0400, Dan Williams wrote:
>> nd_pmem attaches to persistent memory regions and namespaces emitted by
>> the libnd subsystem, and, same as the original pmem driver, presents the
>> system-physical-address range as a block device.
>>
>> The existing e820-type-12 to pmem setup is converted to a full libnd bus
>> that emits an nd_namespace_io device.
>
> This looks completely bonkers.  If you want to pretend the legacy
> e820 NVDIMMs fit into your new world do that directly in
> arch/x86/kernel/pmem.c instead of splitting it over two files.

I was looking to preserve the ability to keep libnd as a module, but
it doesn't really matter given the small number of systems that will
end up caring about X86_PMEM_LEGACY in the near term.  I'll skip the
platform device infrastructure and just register the pmem regions
directly from arch/x86/kernel/pmem.c.
