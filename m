From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 1/3] x86/boot: add acpi rsdp address to setup_header
Date: Fri, 8 Dec 2017 09:36:46 +0100
Message-ID: <81777128-a277-c47b-2570-a330b2f6c50d@suse.com>
References: <20171207122821.30158-1-jgross@suse.com>
 <20171207122821.30158-2-jgross@suse.com>
 <20171208071653.mzyf3ct6n6h2x37r@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750944AbdLHIgt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Dec 2017 03:36:49 -0500
In-Reply-To: <20171208071653.mzyf3ct6n6h2x37r@gmail.com>
Content-Language: de-DE
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org

On 08/12/17 08:16, Ingo Molnar wrote:
> 
> * Juergen Gross <jgross@suse.com> wrote:
> 
>> Xen PVH guests receive the address of the RSDP table from Xen. In order
>> to support booting a Xen PVH guest via grub2 using the standard x86
>> boot entry we need a way fro grub2 to pass the RSDP address to the
>> kernel.
>>
>> For this purpose expand the struct setup_header to hold the physical
>> address of the RSDP address. Being zero means it isn't specified and
>> has to be located the legacy way (searching through low memory or
>> EBDA).
> 
> s/fro
>  /for
> 
> pedantry:
> 
> s/grub2
>  /Grub2

Okay.

> 
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
>> ---
>>  Documentation/x86/boot.txt            | 19 +++++++++++++++++++
>>  arch/x86/boot/header.S                |  6 +++++-
>>  arch/x86/include/uapi/asm/bootparam.h |  1 +
>>  3 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
>> index 5e9b826b5f62..a33c224797e4 100644
>> --- a/Documentation/x86/boot.txt
>> +++ b/Documentation/x86/boot.txt
>> @@ -61,6 +61,13 @@ Protocol 2.12:	(Kernel 3.8) Added the xloadflags field and extension fields
>>  	 	to struct boot_params for loading bzImage and ramdisk
>>  		above 4G in 64bit.
>>  
>> +Protocol 2.13:	(Kernel 3.14) Support 32- and 64-bit flags being set in
>> +		xloadflags to support booting a 64 bit kernel from 32 bit
>> +		EFI
> 
> The changelog should I think declare that we add documentation for the 2.13 
> protocol iteration as well.
> 
> Also, please use a consistent spelling of '32-bit' and '64-bit' in the same 
> sentence!

Okay.

> 
>> +Field name:	acpi_rsdp_addr
>> +Type:		write
>> +Offset/size:	0x268/8
>> +Protocol:	2.14+
>> +
>> +  This field can be set by the boot loader to tell the kernel the
>> +  physical address of the ACPI RSDP table.
>> +
>> +  A value of 0 indicates the kernel should fall back to the standard
>> +  methods to locate the RSDP (search in EBDA/low memory).
> 
> That's not the only method used: the ACPI RSDP address can also be discovered via 
> efi.rsdp20 and efi.rsdp, both of which appear to be 32-bit values.

Sure, but this is valid for booting via EFI only.

> 
>>  **** THE IMAGE CHECKSUM
>>  
>> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
>> index 850b8762e889..e7184127f309 100644
>> --- a/arch/x86/boot/header.S
>> +++ b/arch/x86/boot/header.S
>> @@ -300,7 +300,7 @@ _start:
>>  	# Part 2 of the header, from the old setup.S
>>  
>>  		.ascii	"HdrS"		# header signature
>> -		.word	0x020d		# header version number (>= 0x0105)
>> +		.word	0x020e		# header version number (>= 0x0105)
>>  					# or else old loadlin-1.5 will fail)
>>  		.globl realmode_swtch
>>  realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
>> @@ -558,6 +558,10 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
>>  init_size:		.long INIT_SIZE		# kernel initialization size
>>  handover_offset:	.long 0			# Filled in by build.c
>>  
>> +acpi_rsdp_addr:		.quad 0			# 64-bit physical pointer to
>> +						# ACPI RSDP table, added with
>> +						# version 2.14
> 
> s/pointer to ACPI RSDP table
>  /pointer to the ACPI RSDP table

Okay.

> 
> Also, a more fundamental question: why doesn't Xen use EFI to hand over hardware 
> configuration details?

I think Jan has answered this question quite well.


Juergen
