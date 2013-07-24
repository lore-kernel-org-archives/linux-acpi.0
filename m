From: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Subject: Re: Linux 3.11-rc2 (acpi backlight)
Date: Wed, 24 Jul 2013 11:19:10 +0400
Message-ID: <1374650350.1824.2.camel@ThinkPad-X230.localdomain>
References: <CA+55aFy330bSRjK5HT1n0wXioPykL3RquHXyBPjm5GpTz_Y=DQ@mail.gmail.com>
	 <9012759.Alzqtdvh5b@vostro.rjw.lan> <1374605189.31029.25.camel@fourier>
	 <1657635.t6GA9ja9Ss@vostro.rjw.lan>
	 <CAAG0J98G64DGvtA3HtY7B2-rvOordrzam+jjy=kjgLTW0WPgew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:64375 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab3GXHTQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jul 2013 03:19:16 -0400
In-Reply-To: <CAAG0J98G64DGvtA3HtY7B2-rvOordrzam+jjy=kjgLTW0WPgew@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Hogan <james@albanarts.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Kamal Mostafa <kamal@canonical.com>, Steven Newbury <steve@snewbury.org.uk>, Martin Steigerwald <Martin@lichtvoll.de>, =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lwe@gmail.com>

On Wed, 2013-07-24 at 07:49 +0100, James Hogan wrote:
> On 24 July 2013 01:05, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > I'd like to collect some information on the systems having problems=
 with those
> > two commits (to see if they are similar somehow).
> >
> > It seems that one common symptom is that brightness cannot be contr=
olled
> > through function keys.  Is that correct for all of you?  If so, did=
 you try
> > any other way to control brightness, like a GUI-based?
>=20
> For me both the Fn keys and the gui slider (kde) now control
> /sys/class/backlight/intel_backlight/brightness (which has no effect)=
=2E
> Previously they both controlled the acpi one (that on -rc2 doesn't
> exist).
I think this problem in i915 drivers.
Rafael, Mathew, Aaron, fix me please
>=20
> >
> > Also, can you all please send me (a) the output of dmidecode and (b=
) the
> > contents of /proc/cpuinfo from your systems?
>=20
> attached


--=20
Igor Gnatenko
=46edora release 19 (Schr=C3=B6dinger=E2=80=99s Cat)
Linux 3.9.9-302.fc19.x86_64

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
