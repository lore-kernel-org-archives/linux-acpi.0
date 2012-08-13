From: Athlion <athlion@gmail.com>
Subject: Re: Kernel stops at "PM: Preparing system for mem sleep", never makes
 it to "Freezing user space processes ... "
Date: Mon, 13 Aug 2012 10:27:30 +0300
Message-ID: <CACfp431tm0KK380uxaamnGy_riRuU6EHeHLDFDWeoyQgfdXuzA@mail.gmail.com>
References: <CACfp4335KJQ8Zjj0TJNj65Va9K-t_iEHLEGEi8QuWyQj5dVT0g@mail.gmail.com>
 <CACfp433X1KwvDu+5ytVVOk6K4pc2vzKxMgEZaCsNwLz0o+Mj9Q@mail.gmail.com>
 <CACfp431Zj33YtSZJ5rDHACOuHRePKHX7CPYZRCdDxLS27sC=pg@mail.gmail.com>
 <201208122303.53318.rjw@sisk.pl> <CACfp431yG1_WzdAQFL2aB52Trw68a-HTCe0q8izcomj5B9i0ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63842 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab2HMH1v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Aug 2012 03:27:51 -0400
In-Reply-To: <CACfp431yG1_WzdAQFL2aB52Trw68a-HTCe0q8izcomj5B9i0ZA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

And this is the dmesg with pci=nocrs acpi_osi=Linux

https://dl.dropbox.com/u/63420/dmesg2.txt

On Mon, Aug 13, 2012 at 10:13 AM, Athlion <athlion@gmail.com> wrote:
> Thanks,
>
> Here is my dmesg from a clean boot:
>
> https://dl.dropbox.com/u/63420/dmesg.txt
>
> Now that I scanned it more thoroughly I found these:
>
> [    0.363136] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
> and
> [    0.387856] PCI: Using host bridge windows from ACPI; if necessary,
> use "pci=nocrs" and report a bug
>
> my /proc/cmdline is:
> BOOT_IMAGE=/boot/vmlinuz-linux
> root=UUID=44cf687d-4827-4765-8758-98d44a745d07 ro quiet
> resume=/dev/sda2
>
> maybe they indicate a lurking problem?
>
> (in parallel, I will try booting with pci=nocrs and report back)
>
> And there are other people having this issue, some from way back, as
> can be seen here
> https://bbs.archlinux.org/viewtopic.php?id=144381
> (Don't be fooled by the linux 3.4.x reference in the title, it happens
> with older kernels, too)
>
> Some of them have found the "solution" to be "never close the lid" but
> this is unacceptable, for me.
>
> Again, thanks!
>
> On Mon, Aug 13, 2012 at 12:03 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> On Sunday, August 12, 2012, Athlion wrote:
>>> On Sun, Aug 12, 2012 at 2:01 PM, Athlion <athlion@gmail.com> wrote:
>>> > On Sun, Aug 12, 2012 at 1:08 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>> >> This seems to be the last kernel message you've got.
>>> >>
>>> >> It looks like there's a problem with a power management notifier within
>>> >> the kernel.  Perhaps a race condition, since it is not reproducible 100%
>>> >> of the time.
>>> >>
>>> >> Does it happen if you don't use the lid to trigger suspend?
>>> >>
>>> >> Rafael
>>> >
>>> > No, it does not.
>>> >
>>> > If I don't use the lid, the suspend succeeds 100% of the time (at
>>> > least, I have achieved over 4 days of uptime by using the
>>> > logout/suspend button of xfce, I never could stand not closing the lid
>>> > for more...)
>>> >
>>> > What I don't know exactly is how to begin tracking this problem down.
>>>
>>> Furthermore, the suspend actually *happens* if I initiate a shutdown
>>> or reboot procedure, right after the point where the system says
>>> killing all processes. On resume, the shutdown/reboot resumes
>>> normally.
>>
>> There seems to be an input event handling race condition with system suspend
>> on your machine.  I wonder if it's related to the specific system configuration,
>> though, because no one else has reported anything like this before.
>>
>> I'm not sure what to do to debug this further at the moment.
>>
>> Please attach dmesg output from a clean boot.
>>
>> Thanks,
>> Rafael
