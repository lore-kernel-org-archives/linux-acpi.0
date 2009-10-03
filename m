From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: High power consumption after suspend/resume cycle
Date: Sat, 3 Oct 2009 11:58:58 -0400
Message-ID: <cb0375e10910030858i63051557j5fad3312d3bd3a4c@mail.gmail.com>
References: <cb0375e10910021044n182d696dy8fd566925e46b134@mail.gmail.com>
	 <cb0375e10910021229x7924ec56o61627ec0f625a70c@mail.gmail.com>
	 <200910022337.42283.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:52834 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbZJCQHV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Oct 2009 12:07:21 -0400
In-Reply-To: <200910022337.42283.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, Oct 2, 2009 at 5:37 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday 02 October 2009, Andrew Lutomirski wrote:
>> [Adding cc's to linux-pm and linux-acpi and ]
>>
>> On Fri, Oct 2, 2009 at 1:44 PM, Andrew Lutomirski <luto@mit.edu> wro=
te:
>> > Hi all-
>> >
>> > I'm running a git kernel that's slightly newer than 2.6.32-rc1.
>> >
>> > First, thanks for all the great work everywhere on laptop power
>> > consumption -- on my Lenovo X200s, it looks like Linux is getting
>> > close to Windows (Windows wins by about 0.7W, except that its powe=
r
>> > usage frequently spikes since Windows apparently still doesn't kno=
w
>> > how to sit still and do nothing, whereas Linux's seems more stable=
=2E),
>> > even running KDE with compositing enabled and
>> > while connected to wifi, at least after some tweaking.
>>
>> [fixed irrelevant typo above, too.]
>>
>> >
>> > There's a catch, though: after a suspend/resume cycle, power
>> > consumption goes up by over well over a watt. =A0(On a system that=
 draws
>> > about 7 watts before suspending, that's a big deal.) =A0I've tried
>> > turning off X, suspending with 'echo mem > /sys/power/state' to av=
oid
>> > any distro scripts running, and manually restoring SATA power savi=
ng
>> > settings, but it still happens. =A0I even tried unbinding e1000e a=
nd
>> > both USB drivers, unloading the i2400 (wimax) driver, iwlagn, and
>> > iwlcore, and it still happens. =A0This is 100% reproducible, and I=
'd be
>> > happy to test things.
>> >
>> > This could be a BIOS bug I suppose (although I'm running the lates=
t
>> > BIOS), but Windows 7 does not have this problem at all.
>> >
>> > Any ideas about what to try or what subsystem to blame?
>
> It's quite hard to say. =A0Most likely one of devices is put into the=
 full power
> state during resume and not put back into the low power state it was =
in before.
>
> That may be a result of the PCI core handling of resume, which puts a=
ll devices
> into D0 in order to restore their standard config registers and doesn=
't put
> them into low power states afterwards.

I don't think that's the problem at all -- I diffed the output of
lspci -vvvvxxxx before and after suspend and none of the differences
looked interesting.  Everything was in D0 both before and after.  One
of the EHCI devices had PME asserted after resume, but clearing that
with setpci made no difference.

I did some more experiments that make it look like it's a bug in i915.
 I'll email the maintainers.

>
> If that's really the case, PCI run-time PM should help here once impl=
emented,
> although that's going to take some time to achieve.

I'm looking forward to another little bit of power savings there, too :=
)

Thanks,
Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
