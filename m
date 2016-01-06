From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH] ACPI/APEI: correct/extend pgprot_t retrieval to
 map GHES memory
Date: Wed, 06 Jan 2016 01:43:25 -0700
Message-ID: <568CE1BD02000078000C3CCE@prv-mh.provo.novell.com>
References: <56797F6502000078000C2525@suse.com>
 <20151229122836.GA2328@codeblueprint.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from prv-mh.provo.novell.com ([137.65.248.74]:59040 "EHLO
	prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbcAFIn3 convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:6:1>);
	Wed, 6 Jan 2016 03:43:29 -0500
In-Reply-To: <20151229122836.GA2328@codeblueprint.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Fleming <mfleming@suse.com>
Cc: Borislav Petkov <bp@alien8.de>, zjzhang@codeaurora.org, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

>>> On 29.12.15 at 13:28, <mfleming@suse.com> wrote:
> On Tue, 22 Dec, at 03:50:45PM, Jan Beulich wrote:
>> Commit 8ece249a81 ("acpi/apei: Use appropriate pgprot_t to map GHES
>> memory") adjusted ghes_ioremap_pfn_irq() but left ghes_ioremap_pfn_nmi()
>> alone, and while doing the adjustment it introduced an at least latent
>> truncation issue on ix86 (using "unsigned long" for a physical address).
>  
> Good catch, but I don't think this is the correct fix. 'paddr' should
> be u64 because that's the data type used in ghes_copy_tofrom_phys(),
> and because the value is read from ACPI. The firmware dictates the
> data types.

Making paddr u64 won't be of any use when phys_addr_t is only
32 bits, since passing the value to arch_apei_get_mem_attribute()
and ioremap_page_range() would still cause truncation.

>> --- 4.4-rc6/drivers/acpi/apei/ghes.c
>> +++ 4.4-rc6-ACPI-GHES-ioremap/drivers/acpi/apei/ghes.c
>> @@ -147,17 +147,23 @@ static void ghes_ioremap_exit(void)
>>  static void __iomem *ghes_ioremap_pfn_nmi(u64 pfn)
>>  {
>>  	unsigned long vaddr;
>> +	phys_addr_t paddr;
>> +	pgprot_t prot;
>>  
>>  	vaddr = (unsigned long)GHES_IOREMAP_NMI_PAGE(ghes_ioremap_area->addr);
>> -	ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
>> -			   pfn << PAGE_SHIFT, PAGE_KERNEL);
>> +
>> +	paddr = pfn << PAGE_SHIFT;
>> +	prot = arch_apei_get_mem_attribute(paddr);
>> +
>> +	ioremap_page_range(vaddr, vaddr + PAGE_SIZE, paddr, prot);
>>  
>>  	return (void __iomem *)vaddr;
>>  }
>   
> Did you test this change? I didn't suggest fixing this function up
> originally because it isn't used on arm64.

Do you see anything wrong here? I can't see the change do
anything that could break things. And the function - used there
or not - is being compiled for ARM64, and even from an
abstract perspective it seems wrong to use
arch_apei_get_mem_attribute() in its non-NMI counterpart but
not here.

Jan

