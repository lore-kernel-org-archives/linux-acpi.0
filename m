From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: [PATCH] Ignore ACPI video devices that aren't present in hardware
Date: Tue, 22 Jan 2008 13:11:52 +0100
Message-ID: <4795DD88.6040808@gmail.com>
References: <1197032113.28990.155.camel@queen.suse.de>	 <20071207225025.GA2055@srcf.ucam.org>	 <1197290906.28990.329.camel@queen.suse.de>	 <20080117031154.GA26703@srcf.ucam.org>	 <20080117033936.GB26703@srcf.ucam.org>	 <1200567431.23376.459.camel@queen.suse.de>	 <20080117120237.GA31912@srcf.ucam.org> <1200991973.7424.38.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:3388 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbYAVKMN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2008 05:12:13 -0500
Received: by mu-out-0910.google.com with SMTP id i10so7492499mue.5
        for <linux-acpi@vger.kernel.org>; Tue, 22 Jan 2008 02:12:11 -0800 (PST)
In-Reply-To: <1200991973.7424.38.camel@acpi-sony.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>

Zhang Rui pisze:
> On Thu, 2008-01-17 at 20:02 +0800, Matthew Garrett wrote:
>> On Thu, Jan 17, 2008 at 11:57:11AM +0100, Thomas Renninger wrote:
>>
>>> Does it make sense to add this as a separate function, searching for
>> a
>>> physical PCI device for an ACPI device may pop up more often in the
>>> future? This is a kind of _STA (present or not) function for PCI
>> ACPI
>>> devices then.
>> No, I don't think this can be done generically - _ADR for a SATA
>> device
>> has a format that looks similar to the one for PCI devices, for
>> instance. I think you need to have knowledge of the specific device
>> type.
>>
>>> This has been tested on a Dell 610 only then?
>>> This sounds like an older machine, I wonder whether the video driver
>> is
>>> useful on this one at all and whether Windows had to check whether
>> the
>>> devices are present also...
>> Also on an HP 2510p. I suspect that the Windows behaviour is to leave
>> this up to the graphics driver rather than handling it in the core.
>> Toshiba seem to have implemented the complete spec for some time, but
>> several other vendors only implemented the section for display output
>> switching and obtaining the EDID.
>>
>>> Please tell me if you have tested more machines, I try to give it a
>> test
>>> on a Toshiba, Lenovo and whatever I find with a Vista capable BIOS
>> (IMO
>>> this should be the most important criterion for finding the devices,
>> I
>>> doubt older Windows Versions made much use of ACPI graphics devices)
>> as
>>> soon as I find some time...
>> Yes, I've tested it on some other machines - the HP is the only one
>> I've
>> tested with a designed for Vista badge, but it should be correct in
>> these cases as well.
>>
> I've tested it on a T61 and it works.
> I asked Julian to test it on a Toshiba Satellite A100-87.
> Please refer to http://bugzilla.kernel.org/show_bug.cgi?id=9614
> 
> Thanks,
> Rui
> 
I tested the patch and it works for me. Some more details in the bug. 
Thank you very much for fixing that.

Regards,
Julian
