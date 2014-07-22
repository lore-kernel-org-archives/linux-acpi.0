From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] acpi-video: Fix backlight taking 2 steps on a brightness keypress
Date: Wed, 23 Jul 2014 01:38:32 +0200
Message-ID: <175769835.6gE1cX8s5M@vostro.rjw.lan>
References: <1405686771-15483-1-git-send-email-hdegoede@redhat.com> <871ttdlavc.fsf@nemi.mork.no> <53CE7EFF.9060903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58773 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757184AbaGVXUJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jul 2014 19:20:09 -0400
In-Reply-To: <53CE7EFF.9060903@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org

On Tuesday, July 22, 2014 05:10:55 PM Hans de Goede wrote:
> Hi,
>=20
> On 07/22/2014 04:35 PM, Bj=C3=B8rn Mork wrote:
> > Hans de Goede <hdegoede@redhat.com> writes:
> >
> >> Hi All,
> >>
> >> Here is v2 of my cleaned up version of Linus' patch to fix this. N=
ew this
> >> version is that the module option is left as a boolean, and the ke=
ypresses
> >> handling simply always gets delayed 100 ms.
> >>
> >> Bj=C3=B8rn, can you please re-test to make sure I've not accidenta=
lly broken
> >> anything ? Note this still applies on top of the revert.
> >
> > Still works fine for me.  Sorry about the testing delay.
>=20
> np. thanks for testing.

I've queued up this patch for 3.17, thanks!

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
