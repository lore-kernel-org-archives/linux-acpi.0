From: Mattia Dongili <malattia@linux.it>
Subject: Re: [Regression] sony-laptop breaks resume from S2RAM (was: Re:
	[linux-pm] Resume after suspend-to-ram broken for Vaio SR19VN in
	30rc2)
Date: Thu, 23 Apr 2009 21:50:25 +0900
Message-ID: <20090423125025.GA6195@kamineko.org>
References: <31c940650904201152y5f440237rb9c49f1aedfef5a6@mail.gmail.com> <200904212050.25531.rjw@sisk.pl> <31c940650904220555v1c1a6046ifa40b9c81b390731@mail.gmail.com> <200904222202.24271.rjw@sisk.pl> <31c940650904221335v21fbffc2y2e9598b564d65659@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:34560
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264AbZDWMuX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 08:50:23 -0400
Content-Disposition: inline
In-Reply-To: <31c940650904221335v21fbffc2y2e9598b564d65659@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fanderay <fanderay4@googlemail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Almer S. Tigelaar" <almer@gnome.org>

On Wed, Apr 22, 2009 at 09:35:13PM +0100, fanderay wrote:
> On Wed, Apr 22, 2009 at 9:02 PM, Rafael J. Wysocki <rjw@sisk.pl> wrot=
e:
> >> Hi Rafael,
> >>
> >> I found the problem: it's the Sony laptop driver. =A0With
> >> CONFIG_SONY_LAPTOP=3Dy, the hard freeze on resume occurs. =A0Witho=
ut this

what happens if you configure it as a module instead?

> >> driver in the kernel, resume after s2ram -f -p appears to work
> >> correctly.
> >
> > It seems to be an ACPI problem, then. =A0Added some CCs.
>=20
> Thanks, I raised bug <http://bugzilla.kernel.org/show_bug.cgi?id=3D13=
148>.

I'll try to reproduce it.

Almer,
you have an SR too, do you see the same problem as fanderay?

Thanks
--=20
mattia
:wq!
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
