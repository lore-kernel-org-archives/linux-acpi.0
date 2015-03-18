From: Be <be.0@gmx.com>
Subject: Re: Backlight control broken on Lenovo Ideapad Z570
Date: Wed, 18 Mar 2015 16:40:37 -0500
Message-ID: <5509F0D5.4090308@gmx.com>
References: <550979A6.20306@redhat.com> <1426714264.2313054.242229237.35BDA633@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.gmx.com ([74.208.4.200]:55147 "EHLO mout.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933273AbbCRVkl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Mar 2015 17:40:41 -0400
In-Reply-To: <1426714264.2313054.242229237.35BDA633@webmail.messagingengine.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stepan Bujnak <stepanbujnak@fastmail.com>, Hans de Goede <hdegoede@redhat.com>, Stepan Bujnak <stepanbujnak@fastmail.fm>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

intel_backlight works as expected for me running
kernel-3.18.8-201.fc21.x86_64 with ideapad_backlight blacklisted.

On 03/18/2015 04:31 PM, Stepan Bujnak wrote:
> Hi, unfortunately I moved to San Francisco and left my old laptop at
> home, so I cannot debug the issue anymore. As far as I remember
> correctly, the problem was that I only had the intel_backlight interface
> which did not work as expected (value always on top, the buttons did not
> work, neither did writing the value manually). Once I blacklisted the
> intel_backlight using the patch I submitted I was able to get the
> backlight working.
>
> However, I'm reading that you've got fix for the problem and my patch
> conflicts with it? If this is the case, please replace my code with your
> fix, and once I get back home (April 28th) we can continue debugging the
> issue using my laptop.
>
> Best wishes,
> Stepan
>
> On Wed, Mar 18, 2015, at 06:12 AM, Hans de Goede wrote:
>> Hi Stepan,
>>
>> I'm mailing you because you are the author of:
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a11d342f
>>
>> I've been debugging the same problem together with a Fedora user:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1187004
>>
>> And for him your fix does not work, before your fix landed we already
>> came to the conclusion that to fix this we need to disable both the
>> acpi_video backlight interface as well as the ideapad-laptop interface.
>>
>> Your patch only disables the acpi_video backlight interface (and as
>> a side effect actually enables the ideapad-laptop interface).
>>
>> I assume that you've a working backlight setup on your Lenovo Ideapad
>> Z570,
>> can you please do:
>>
>> ls /sys/class/backlight
>>
>> And let us know which interfaces show up there. Either you do have a
>> working
>> ideapad_laptop interface, or you only get intel_backlight and for some
>> reason
>> ideapad_laptop is not loading on your system (not enabled in your kernel
>> config,
>> or blacklisted?).
>>
>> If you only have intel_backlight then that explains why things are not
>> working
>> for Be (the author of the Fedora bugreport), if you do have an
>> ideapad_laptop
>> interface and that does work for you, then it seems that not all
>> Lenovo Ideapad Z570-s are created equal. In that case can you please
>> blacklist
>> the ideapad-laptop module, reboot and see if things still work for you
>> when
>> using intel_backlight to control the backlight? Once we've a confirmation
>> that either you are already using intel_backlight, or that
>> intel_backlight also
>> works on your Ideapad, then I'll write a patch to replace yours which
>> leaves
>> only intel_backlight even if the ideapad-laptop driver gets loaded.
>>
>> Thanks & Regards,
>>
>> Hans

