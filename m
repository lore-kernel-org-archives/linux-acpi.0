From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [BISECTED 3.16-rc REGREGRESSION] backlight control stopped working
Date: Tue, 15 Jul 2014 12:59:12 +0200
Message-ID: <53C50980.8000300@redhat.com>
References: <87pph8kse7.fsf@nemi.mork.no>	<53C3D7C3.7090505@redhat.com> <CA+55aFxYYKApOC+1TQkoxSzi-zTSB8OmkU=ypvNb_Gc2+K6Hmw@mail.gmail.com> <53C4D17E.60206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32463 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758038AbaGOK70 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jul 2014 06:59:26 -0400
In-Reply-To: <53C4D17E.60206@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Hi,

> On 07/14/2014 06:24 PM, Linus Torvalds wrote:
> Hans, seriously. You have the wrong mental model. Fix it.

> On 07/15/2014 Bj=C3=B8rn Mork wrote:
> I find your attitude extremely arrogant.  If you want to run a
> non-exotic setup then you should definitely not consider Linux for yo=
ur
> desktop system...

After stepping away from the keyboard and thinking about this for
a while I looked in the mirror and I saw someone who liked like
one of those developers who keeps taking away features to streamline
the user experience, and who does not care about your use-case because
it is not mainstream.

I've butted head with those kind of developers several times and
I really don't want to become like one of them. So you two are
right, and I apologize for my behavior.

So now lets go and fix this in way so that we can both have our
cake and eat it :)

On 07/15/2014 09:00 AM, Hans de Goede wrote:

<snip>

> I see that further down the thread you've send a patch to fix
> this by waiting sometime for userspace to react and if it does
> not then do the change in the kernel as it used to be.
>=20
> FWIW I don't think this is a good idea. This is inherently racy, so
> we will still sometimes see the backlight taking 2 steps leading to
> hard to debug problems.
>=20
> It has made me think about doing something to keep both setups
> like Bj=C3=B8rn's working, and get rid of the 2 steps problem. I thin=
k
> adding an auto setting for brightness_switch_enabled and making that
> the default is a good idea. But instead of using a timeout, I suggest
> to make -1 / auto behave the same as 1 / on until userspace sets the
> brightness. Once userspace has written to the brightness attribute
> we start interpreting auto as 0 / off.

Thinking more about this I can still think of several use cases which
will break with this change. So I believe that Linus' suggestion for
fixing this is probably the best solution and we will just have to
live with the race (if we hit the race we will behave as before and
take 2 steps).

After testing several laptops I've found one which exhibits the
2 step problem. For the record to reproduce this you need a laptop
with non intel gfx, as the xf86-video-intel driver caches the backlight
setting, and thus userspace does not see the kernel made changes
when it applies its own changes, so the backlight still gets stepped
twice, but the second step (done by userspace) just repeats the change
already done by the kernel.

Testing Linus' patch on that laptop unfortunately shows that it
does not fix the problem (while setting brightness_switch_enabled=3D0
does). I've already tried raising the delay to 250ms to no avail,
so I'm going to need to do some debugging on this. Besides that
the patch should be modified to not use globals as theoretically
there can be more then 1 acpi backlight device. Assuming I can get
the patch working (it should work in theory), I'll send a fixed
and cleaned-up version to Rafael for 3.17 .

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
