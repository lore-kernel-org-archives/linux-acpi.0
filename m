From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [BISECTED 3.16-rc REGREGRESSION] backlight control stopped working
Date: Tue, 15 Jul 2014 09:00:14 +0200
Message-ID: <53C4D17E.60206@redhat.com>
References: <87pph8kse7.fsf@nemi.mork.no>	<53C3D7C3.7090505@redhat.com> <CA+55aFxYYKApOC+1TQkoxSzi-zTSB8OmkU=ypvNb_Gc2+K6Hmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47539 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757819AbaGOHA2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jul 2014 03:00:28 -0400
In-Reply-To: <CA+55aFxYYKApOC+1TQkoxSzi-zTSB8OmkU=ypvNb_Gc2+K6Hmw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Hi,

On 07/14/2014 06:24 PM, Linus Torvalds wrote:
> On Mon, Jul 14, 2014 at 6:14 AM, Hans de Goede <hdegoede@redhat.com> =
wrote:
>>
>> This *not* a regression, it is an intended behavior change [..]
>=20
> That counts as a regression.
>=20
> If things used to work, and they don't work, it's a regression. If
> it's intentional, that just makes it worse.

The problem is that our previous default behavior turns out to be
wrong for many users.

So as answered later in the thread Bj=C3=B8rn is using a custom setup w=
ith
acpid and WindowMaker. So in order to keep his exotic (and very simple
to fix) setup working we are keeping thing broken on what are probably
a 100 thousand Linux installs or more.

>=20
>> Yes this may break existing configurations for some users, most like=
ly
>> users running some custom setup, who thus should be able to fix thin=
gs
>> by adding one more customization to there setup.
>=20
> .. and apparently this whole paragraph is completely bogus. It *does*
> break things, and for normal people.

It breaks things on exotic setups, running a non standard desktop
environment or no desktop environment at all. Note that this is
about laptops most people will be using one of gnome / kde / unity /
xfce on a desktop, and for all of these the old default behavior is
bad.

> That's what the bug report is all about. So don't waffle about it.
>=20
> Bj=C3=B8rn, what's your setup?
> Is this perhaps solvable some other way?

I see that further down the thread you've send a patch to fix
this by waiting sometime for userspace to react and if it does
not then do the change in the kernel as it used to be.

=46WIW I don't think this is a good idea. This is inherently racy, so
we will still sometimes see the backlight taking 2 steps leading to
hard to debug problems.

It has made me think about doing something to keep both setups
like Bj=C3=B8rn's working, and get rid of the 2 steps problem. I think
adding an auto setting for brightness_switch_enabled and making that
the default is a good idea. But instead of using a timeout, I suggest
to make -1 / auto behave the same as 1 / on until userspace sets the
brightness. Once userspace has written to the brightness attribute
we start interpreting auto as 0 / off.

Rafael would you be willing to take a patch doing this ?

>> TL;DR: This change really is for the better and is here to stay.
>=20
> Wrong. We don't break existing setups, and your attitude needs fixing=
=2E
>=20
> Rafael, please get it reverted, or I will have to revert it. We have
> *long* had a rule that we don't break things "in order to improve
> things for others", and quite frankly, power management and ACPI in
> particular was exactly *why* that rule was introduced, because the
> whole "one step back, two steps forward" model does not work.
>=20
> The problem needs to be solved some other way, and developers need to
> f*cking stop with the "we can break peoples setups" mentality./
>=20
> Hans, seriously. You have the wrong mental model. Fix it.

Linus, normally I agree 101% with your no regressions policy. but I'm
also a big fan of the it just works philosophy. The problem here is
that when this switch got introduced a long time ago it got (in hindsig=
ht)
the wrong default. In order to make things just work it needs to get
fixed, but maybe we can come up with a solution to both have our cake
and eat it.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
