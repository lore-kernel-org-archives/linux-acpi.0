From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] acpiphp: Match the variable types for ia64
Date: Fri, 12 Sep 2008 12:12:42 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308584E454A@orsmsx503.amr.corp.intel.com>
References: <200510232100.j9NL0MWA030225@shell0.pdx.osdl.net>
 <20080910002011.GF2772@parisc-linux.org>
 <20080910074940.GA12737@ldl.fc.hp.com>
 <200809101103.55222.jbarnes@virtuousgeek.org>
 <B57D568CB82B0C4B897F9CD9862DE8B733A328DF9E@GVW1097EXB.americas.hpqcorp.net>
 <20080911104345.GL2772@parisc-linux.org>
 <B57D568CB82B0C4B897F9CD9862DE8B733A328E8E0@GVW1097EXB.americas.hpqcorp.net>
 <20080912183213.GH10844@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20080912183213.GH10844@parisc-linux.org>
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>, "Chen, Justin" <justin.chen@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, "Chiang, Alexander" <achiang@hp.com>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>
List-Id: linux-acpi@vger.kernel.org

>acpi_status
>acpi_evaluate_integer(acpi_handle handle,
>                      acpi_string pathname,
>                      struct acpi_object_list *arguments, unsigned long

This is not an ACPICA interface, it is local to Linux (drivers/acpi/utils.c)

It should be a pointer to a 64-bit number always. acpi_integer * works well.

Bob

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Matthew Wilcox
>Sent: Friday, September 12, 2008 11:32 AM
>To: Chen, Justin
>Cc: Jesse Barnes; Chiang, Alexander; Accardi, Kristen C; linux-
>pci@vger.kernel.org; linux-acpi@vger.kernel.org; Brown, Len
>Subject: Re: [PATCH] acpiphp: Match the variable types for ia64
>
>On Fri, Sep 12, 2008 at 05:03:50PM +0000, Chen, Justin wrote:
>> >>                 slot->device = device;
>> >> -               slot->sun = sun;
>> >> +               slot->sun = (u64) sun;
>> >
>> >No ... the right thing to do here is make the local variable
>> >'sun' a u64.  adr ought to be a u32, not an unsigned long.
>>
>> If I understand your concern right, you want to change the local
>> variable 'sun' in the routine register_slot() in the file acpiphp_glue.c
>> from unsigned long to u64.  If that's the case, it will introduce the
>> other issue that since the 'sun' is passed as the argument 4 of the
>> routine acpi_evaluate_integer() and it is taking the unsigned long,
>> what's the point to define 'sun' in u64?
>
>Ooh, I think you've found a bug in the ACPI-CA.
>
>Consider this:
>
>/*
> * Acpi integer width. In ACPI version 1, integers are 32 bits.  In ACPI
> * version 2, integers are 64 bits. Note that this pertains to the ACPI
>integer
> * type only, not other integers used in the implementation of the ACPI CA
> * subsystem.
> */
>typedef unsigned long long acpi_integer;
>
>and compare and contrast it with this:
>
>acpi_status
>acpi_evaluate_integer(acpi_handle handle,
>                      acpi_string pathname,
>                      struct acpi_object_list *arguments, unsigned long
>*data);
>
>I would argue 'data' should be an 'acpi_integer *', not an 'unsigned long
>*'
>Len?
>
>--
>Matthew Wilcox                          Intel Open Source Technology Centre
>"Bill, look, we understand that you're interested in selling us this
>operating system, but compare it to ours.  We can't possibly take such
>a retrograde step."
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
