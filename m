From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI] Dell i8k was: Re: [2.5.50, ACPI] link error
Date: Wed, 11 Dec 2002 08:40:05 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B993@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: 'Andrew McGregor' <andrew-Rd3uoDiDeHXJKwlM9GxbOw@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, 'Ducrot Bruno' <poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


The problem is related to this message:

    ACPI-0189: *** Warning: Buffer created with zero length in AML

I have a patch for the oops caused by this, but there may be an additional
underlying problem where the AML is causing a zero length buffer to be
created.

Bob


-----Original Message-----
From: Andrew McGregor [mailto:andrew-Rd3uoDiDeHXJKwlM9GxbOw@public.gmane.org] 
Sent: Tuesday, December 10, 2002 7:45 PM
To: Pavel Machek; Alan Cox
Cc: Grover, Andrew; 'Ducrot Bruno'; Ducrot Bruno; Patrick Mochel; Linux
Kernel Mailing List; ACPI mailing list
Subject: Re: [ACPI] Dell i8k was: Re: [2.5.50, ACPI] link error

Hmm, when I boot 2.5.51 w/ACPI on it with a battery installed, it panics. 
By booting without and then inserting the battery, I got the attached oops. 
See also the messages in the dmesg output.

Andrew

--On Wednesday, December 11, 2002 09:50:48 +1300 Andrew McGregor 
<andrew-Rd3uoDiDeHXJKwlM9GxbOw@public.gmane.org> wrote:

> I strongly suspect that s4bios will work on this machine, but swsusp
> won't. Why?  It's a Dell Inspiron 8000 with an NVidia Geforce2go, and
> until NVidia put pm support in their driver, it's game over for Linux.
> Except that the BIOS knows how to suspend it, so some kernel/driver
> combinations work with APM.  I suspect any Geforce2go Dell is the same.
>
> Andrew
>
> --On Tuesday, December 10, 2002 21:40:31 +0100 Pavel Machek
> <pavel-AlSwsSmVLrQ@public.gmane.org> wrote:
>
>> Hi!
>>
>>> > I concur with your pros and cons. This makes me think that if S4BIOS
>>> > support ever gets added, it should get added to 2.4 only.
>>
>> And S4BIOS will never get added to 2.4 since it needs driver model
>> :-(.
>>
>>> That assumes no box exists where S4bios works an S4 doesnt (eg due to
>>> bad tables or "knowing" what other-os does)
>>
>> We have full control over S4 (== swsusp), so we can fix that in most
>> cases.
>>
>> S4BIOS is still little friendlier to the user -- no need to set up
>> swap partition and command line parameter, can't go wrong if you boot
>> without resume=, etc.
>> 								Pavel
>>
>> --
>> Casualities in World Trade Center: ~3k dead inside the building,
>> cryptography in U.S.A. and free speech in Czech Republic.
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>> in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
