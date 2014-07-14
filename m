From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [BISECTED 3.16-rc REGREGRESSION] backlight control stopped working
Date: Mon, 14 Jul 2014 15:27:50 +0200
Message-ID: <87egxoysrt.fsf@nemi.mork.no>
References: <87pph8kse7.fsf@nemi.mork.no> <53C3D7C3.7090505@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:47889 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755278AbaGNN3J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jul 2014 09:29:09 -0400
In-Reply-To: <53C3D7C3.7090505@redhat.com> (Hans de Goede's message of "Mon,
	14 Jul 2014 15:14:43 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Hans de Goede <hdegoede@redhat.com> writes:

> Hi,
>
> On 07/14/2014 02:59 PM, Bj=C3=B8rn Mork wrote:
>> Yes, I actually bisected this just to get
>>=20
>> 886129a8eebebec260165741fe31421482371006 is the first bad commit
>> commit 886129a8eebebec260165741fe31421482371006
>> Author: Hans de Goede <hdegoede@redhat.com>
>> Date:   Tue May 6 14:46:23 2014 +0200
>>=20
>>     ACPI / video: change acpi-video brightness_switch_enabled defaul=
t to 0
>>    =20
>>     acpi-video is unique in that it not only generates brightness up=
/down
>>     keypresses, but also (sometimes) actively changes the brightness=
 itself.
>>    =20
>>     This presents an inconsistent kernel interface to userspace, bas=
ically there
>>     are 2 different scenarios, depending on the laptop model:
>>    =20
>>      1) On some laptops a brightness up/down keypress means: show a =
brightness osd
>>      with the current brightness, iow it is a brightness has changed=
 notification.
>>    =20
>>      2) Where as on (a lot of) other laptops it means a brightness u=
p/down key was
>>      pressed, deal with it.
>>    =20
>>     Most of the desktop environments interpret any press as in scena=
rio 2, and
>>     change the brightness up / down as a response to the key events,=
 causing it
>>     to be changed twice, once by acpi-video and once by the DE.
>>    =20
>>     With the new default for video.use_native_backlight we will be m=
oving even
>>     more laptops over to behaving as in scenario 2. Making the remai=
ning laptops
>>     even more of a weird exception. Also note that it is hard to det=
ect scenario
>>     1 properly in userspace, and AFAIK none of the DE-s deals with i=
t.
>>    =20
>>     Therefor this commit changes the default of brightness_switch_en=
abled to 0
>>     making its behavior consistent with all the other backlight driv=
ers.
>>    =20
>>     Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>     Reviewed-by: Aaron Lu <aaron.lu@intel.com>
>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>=20
>> :040000 040000 5bbac8c4f3e9fd5421daf84289004c32c3217f2a 82c99a358bda=
6360f845b6063182d3e707ff90f0 M      Documentation
>> :040000 040000 81ed56a41130bbbea980620114ff11e3bb23ee63 a9870ba1d046=
bde69796060304c78dfbb1d00a1f M      drivers
>>=20
>>=20
>>=20
>> The fact that this seems to be an *intentional* breakage does not he=
lp a
>> lot.  Yes, I understand that you believe the choice of default was
>> incorrect for some reason.  You might even be right about that.  But
>> that is still not a valid reason to break existing configurations fo=
r
>> end users!  Please do not do that.
>
> This *not* a regression, it is an intended behavior change

On my laptop it changed the behaviour from working to non-working, whic=
h
is a regression whether it was intended or not.

> which can be
> flipped back to its old behavior with a single cmdline argument (add
> video.brightness_switch_enabled=3D1 to the kernel commandline).

Yes, sure.

But we do not require users to add command line settings to keep
existing behaviour.

=46or the record, AFAICS, you could achive *your* wanted effect by addi=
ng
video.brightness_switch_enabled=3D0 to the kernel commandline.

> Yes this may break existing configurations for some users, most likel=
y
> users running some custom setup, who thus should be able to fix thing=
s
> by adding one more customization to there setup.


You can drop the "may".  I have already told you that it broke my
configuration, haven't I?

> OTOH this will also unbreak a lot of existing setups, likely an amoun=
t
> of setups which is at least one order of magnitude bigger then the
> amount it will break.

If so, then would adding video.brightness_switch_enabled=3D0 to the ker=
nel
commandline on those systems.  Which would have the nice effect that it
wouldn't break anything.

But whavever.  Since when was it OK to intentionally break existing
setups for *any* reason?

> Most users will be running a desktop environment which will react
> to the keypresses (which are always generated in cases where
> brightness_switch_enabled does anything) by changing the brightness
> a second time. This happens at least in gnome, kde, xfce, unity and
> probably in a few smaller desktop environments as configured ootb too=
=2E

Now I believe we are moving out on the prairie here.  I am concerned
about the *kernel*, not desktop environments.


> If you've a backlight control which only has 8 steps taking 2 steps
> at a time is a bug issue, see e.g. :
>
> https://bugs.launchpad.net/gnome-settings-daemon/+bug/527157
> http://askubuntu.com/questions/173921/why-does-my-thinkpad-brightness=
-control-skip-steps
>
> TL;DR: This change really is for the better and is here to stay.
>
>> Note that NO USER cares about "some laptops" or "other laptops".  Th=
ey
>> care about their own systems, which either
>>  a) depend on the old default and therefore breaks with your change,=
 or
>>  b) have a user modified setting and therefore are unaffected by you=
r
>>     change
>
> This is not how it works, sometimes we *must* look at the bigger pict=
ure,
> e.g. when the Linux kernel first started advertising to acpi that it
> was "Windows 2012" (aka win8), this causes some breakage, still we we=
nt
> ahead with the change, because in the end we must advertise "Windows =
2012"
> support to be able to get support for certain features from the firmw=
are.

Please explain the bigger picture then.  From what I can see, you have
not made a single attempt on explaining why the broken systems cannot b=
e
fixed be fixed by adding video.brightness_switch_enabled=3D0 to the ker=
nel
commandline.





Bj=C3=B8rn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
