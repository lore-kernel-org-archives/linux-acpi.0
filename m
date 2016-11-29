From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] ACPI: Document _OSI and _REV for Linux BIOS writers
Date: Tue, 29 Nov 2016 13:07:55 -0500
Message-ID: <CAJvTdK=P6BHoDgtuF1co7iT-f23Edm7C00aZT3QF=tgQ3fM3ng@mail.gmail.com>
References: <d122d41c1cc7230ae5283caf2a4c18fd4d0cd93e.1479792558.git.len.brown@intel.com>
 <20161122100258.GA1552@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36024 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752106AbcK2SH5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Nov 2016 13:07:57 -0500
In-Reply-To: <20161122100258.GA1552@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Tue, Nov 22, 2016 at 5:02 AM, Lukas Wunner <lukas@wunner.de> wrote:
> On Tue, Nov 22, 2016 at 12:29:46AM -0500, Len Brown wrote:
>> +On a platform tasked with running multiple versions of Windows,
>> +the BIOS could use _OS to enable/disable devices that and OS
>                                                            ^
>                                                            delete

Here I was trying to describe that the BIOS may enable or disable
devices and quirks based on the OS.  Yes, there are examples
of disabling in addition to enabling -- as sometimes there is a device
that may appear as different specific flavors of device based on the OS.
Are you  pointing out that I should use the word "or" instead of a '/'?

>> +_OSI("Darwin")
>> +--------------
>> +
>> +No description of _OSI would be complete without mentioning _OSI("Darwin").
>> +This string is mis-used by Apple on Mac platforms, just as Linux
>> +mis-used _OSI("Linux").
>> +
>> +Linux did not originally return TRUE to _OSI("Darwin"),
>> +on the assumption that on Apple hardware, Linux was
>> +probably best pretending to be Windows,
>> +rather than pretending to be OSX.
>> +
>> +But _OSI("Darwin") was required to make Thunderbolt work,
>> +and so Linux changed to enable it by default.  Making matters worse,
>> +that change did not include the ability to disable _OSI("Darwin")
>> +on the cmdline with acpi_OSI=!Darwin, and so the resulting
>> +regressions had no workaround.
>> +
>> +The cmdline has since been fixed to enable !Darwin.
>> +Today "Darwin" enables Thunderbolt, but significantly
>> +hurts battery life, and so the default for _OSI("Darwin")
>> +is still under debate.
>
> So first of all, I'm currently upstreaming a series which enables
> runtime PM for Thunderbolt on Macs.  Two series with prep work went
> into 4.9 and 4.10.  The final bits are slated for 4.11.
>
> IOW the whole "answering affirmative to Darwin hurts battery life"
> argument will be nonsensical and moot from 4.11 onwards.
>
> Link to the series:
> https://github.com/l1k/linux/commits/thunderbolt_runpm_v3
>
> All patches up to 3890c45 ("mfd: intel-lpss: Avoid resuming
> runtime-suspended lpss unnecessarily") are either already in
> mainline or queued up for it.

I'm delighted to learn this is in progress, as I'm sure,
is the entire community of users running Linux on Mac.

>
> Second, your description is incorrect in that Thunderbolt is only
> powered down in the non-Darwin case on Macs introduced before 2015.
> That's because they didn't support Thunderbolt on Windows (with
> BootCamp) on the older machines, so they powered the controller down
> and made it invisible to the OS.
>
> However on Macs introduced 2015+, they now seem to support Thunderbolt
> on Windows.  They seem to switch the controller between SMM-managed
> versus OS-managed mode based on the _OSI string.  In any case they no
> longer just power it down.
>
>
> Third, Apple uses _OSI("Darwin") not just for Thunderbolt, so the
> above description is incomplete.  They use it *generally* to
> distinguish between macOS versus Windows code paths in AML.
> (These are the only two OSes they care about.)
>
> E.g. on the 12" MacBook, which doesn't even have Thunderbolt, the
> _PS0 and _PS3 methods become no-ops in the non-Darwin case.
>
> Usually Apple only supports a subset of the hardware on Windows,
> so we have to pretend being Darwin to be afforded full access to
> the machine.
>
> One noteworthy issue with _OSI("Darwin") is that we have to respond
> negatively to all other vendor strings once it's encountered.
> See here for details:  http://mjg59.dreamwidth.org/29954.html
>

Great feedback!
Yes, I did a somewhat superficial job on the Darwin section.
I'll re-write it, incorporating your feedback, and send out an updated patch.

thanks,
Len Brown, Intel Open Source Technology Center
