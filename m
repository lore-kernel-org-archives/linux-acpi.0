From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: Linux 3.11-rc2 (acpi backlight, revert)
Date: Thu, 25 Jul 2013 16:46:25 +0200
Message-ID: <20130725144625.GO5939@phenom.ffwll.local>
References: <CA+55aFy330bSRjK5HT1n0wXioPykL3RquHXyBPjm5GpTz_Y=DQ@mail.gmail.com>
 <CA+55aFyrMRDD8qe9DYXixaSLJXEURMYYku1azABA72m71_X+cA@mail.gmail.com>
 <9012759.Alzqtdvh5b@vostro.rjw.lan>
 <2218913.HKGjJcYT1G@vostro.rjw.lan>
 <1374763397.5374.30.camel@fourier>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:61084 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976Ab3GYOq3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jul 2013 10:46:29 -0400
Received: by mail-ee0-f43.google.com with SMTP id l10so988059eei.30
        for <linux-acpi@vger.kernel.org>; Thu, 25 Jul 2013 07:46:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1374763397.5374.30.camel@fourier>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kamal Mostafa <kamal@canonical.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, James Hogan <james@albanarts.com>, Aaron Lu <aaron.lu@intel.com>, Kalle Valo <kvalo@adurom.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Steven Newbury <steve@snewbury.org.uk>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, =?iso-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, Martin Steigerwald <Martin@lichtvoll.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>, Jani Nikula <jani.nikula@linux.intel.com>

On Thu, Jul 25, 2013 at 07:43:17AM -0700, Kamal Mostafa wrote:
> On Thu, 2013-07-25 at 15:00 +0200, Rafael J. Wysocki wrote:
> > On Monday, July 22, 2013 09:54:21 PM Rafael J. Wysocki wrote:
> > > On Monday, July 22, 2013 11:11:54 AM Linus Torvalds wrote:
> > > > On Mon, Jul 22, 2013 at 6:02 AM, Rafael J. Wysocki <rjw@sisk.pl=
> wrote:
> > > > >
> > > > > Linus, do you want me to send a pull request reverting 8c5bd7=
a and efaa14c?
> > > >=20
> > > > Yes, but let's wait a while. Not because I think we'll fix the =
problem
> > > > (hey, miracles might happen), but because I think it would be u=
seful
> > > > to couple the reverts with information about the particular mac=
hines
> > > > that broke (and the people who reported it). So that when we
> > > > inevitably try again, we can perhaps get some testing effort wi=
th
> > > > those machines/people.
> > > >=20
> > > > It doesn't seem to be a show-stopped for a large number of peop=
le, so
> > > > there's no huge hurry. I'd suggest doing the revert just in tim=
e for
> > > > rc3, but waiting until then to gather info about people who see
> > > > breakage.
> > > >=20
> > > > Sound like a plan?
> > >=20
> > > Yes, it does.
> >=20
> > OK, time to revert I guess.
> >=20
> > James, Kamal, Steven, J=F6rg, Martin, Kalle, please check if the ap=
ppended patch
> > fixes the backlight for you.
>=20
> Yes, this revert patch does re-enable backlight control for the affec=
ted
> Dell XPS13 models.

Are these the same models that neeed the special quirk to not write
PCH_PWM_ENABLE? Or do they need both?
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
