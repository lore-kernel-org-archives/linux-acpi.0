From: "Alan Jenkins" <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Subject: Re: Bugs on aspire one A150
Date: Fri, 14 Nov 2008 19:59:25 +0000
Message-ID: <61b223ba0811141159k179558d0i60cebf373baa9fb8@mail.gmail.com>
References: <491506DB.1070000@gmail.com> <49157E97.60503@tuffmail.co.uk>
	 <491DCC21.6060705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <491DCC21.6060705-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 11/14/08, Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Alan Jenkins wrote:
>> Maxim Levitsky wrote:
>>> I have just bought an Aspire one A150, XP version,
>>> as it was the only available here, and installed ubuntu on it.
>>>
>>> Bugs I discovered so far:
>>>
>>>
>>> ** 1 - embedded controler works in polling mode, due to this:
>>>
>>> [    0.708571] ACPI: EC: non-query interrupt received, switching to
>>> interrupt mode
>>> [    1.224043] ACPI: EC: missing confirmations, switch off interrupt
>>> mode.
>>>
>>>
>>> Maybe this is the reason for the fact that gnome power manager freezes
>>> when I unplug
>>> the AC, and freezes often when I try to see battery status.
>>>
>>>
>>> (Note: same is seen on my acer aspire 5720)
>>
>> That sounds like a known issue.  It has been resolved by "ACPI: EC: revert
>> msleep patch".  Happily Len submitted it for mainline this week.  You will
>> also find it if you try the acpi-test git tree.  We're all hoping 2.6.28
>> will be much improved in terms of reliable operation of different ECs :).
>>
>>> ** 2 - wireless: not to mention the fact that ath5k wasn't installed by
>>> default in ubuntu...
>>> wireless more or less works, but kernel log is full of backtraces.
>>
>> Well, that doesn't tell us much.  Did they still happen after upgrading to
>> 2.6.28-rc3?  Can we see them?
>>
>>> Was able to connect to my WPA2 access point.
>>> Sometimes wireless fails completely, especially after suspend to ram.
>>> Advanced features like monitor/injection work, but when I changed the
>>> card's
>>> mac address it stopped working.
>>> I also noticed that if I then start airodump, then wireless works with
>>> new mac.
>>>
>>>
>>>
>>> ** 3 - internal mic doesn't work.
>>> tried model=acer, model=auto.
>>> Overall it seems that alsa misprograms O/B realteck
>>> codec.
>>> I talk about this later.
>>> Have same issue on my acer 5720
>>>
>>>
>>>
>>> ** 4 - wireless led doesn't work.
>>> ath5k devs, can you fix this?
>>>
>>>
>>> ** 5 - coretemp doesn't show cpu temperature,
>>> I have seen somewhere that atom support same thermal diode as core2
>>> and only patch to detect it is needed.
>>> Please include such path in 2.6.28 if exists.
> Patch for that does exits, but doesn't apply to latest git,
> I will apply in manually.
> This should go to .28 I think, this is trivial thing.
>
>
>>>
>>>
>>> ** 6 - both card readers are missing from lspci, is this normal?
>>
>> A similar bug has been reported as a regression:
>>
>> <http://bugzilla.kernel.org/show_bug.cgi?id=11828>
>>
>> so one assumes that it worked on the machines with linux pre-installed.
>> Hopefully without requiring any hacks.
>>
>> It seems that for now a workaround may be to pass the option
>> debug_quirks=1 to the sdhci module...
>>
>> <http://marc.info/?l=linux-kernel&m=122509648027303&w=2>
>>
>> ...or that it may help if you insert an SD card before booting.
>>
>> Apparently the reporter also investigated pcie hotplug.  Probably the BIOS
>> doesn't provide the normal support.  You can try "modprobe pciehp
>> pciehp_force=1", maybe it helps the kernel discover the devices.  It
>> worked for something else on my EeePC.  But then it will reportedly
>> disappear the ethernet controller.
>>
>> However, at the moment pciehp can cause delays of 10s of seconds during
>> resume.
> Got, a SD card, and with help of pciehp it works almost perfectly in both
> slots.
> Almost, due to the fact that R/O switch is ignored.
> (Just as I expected, a s/w switch, couldn't they think more, and include a
> hardware switch?)
> On my main acer R/O switch works.
>
> However I have to use pciehp_force=1, I understand that probably acpi tables
> are broken,
> but could you add a workaround (dmi quirk?)
>
> Also, there is a acpiphp driver, which doesn't work here.
> pciehp is supposed to support so called native mode, don't yet know what it
> is,
> but here it still uses acpi.

Matthew Garret tells me the Aspire One should be handled by acpiphp
patches he posted on the linux acpi mailing list recently.

-- 
A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
>> A: Top-posting.
>>> Q: What is the most annoying thing in e-mail?
