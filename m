From: Andrew Morton <akpm@osdl.org>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Tue, 26 Sep 2006 22:14:00 -0700
Message-ID: <20060926221400.5da1b796.akpm@osdl.org>
References: <20060926135659.GA3685@jnb.gelma.net>
	<45195583.4090500@popies.net>
	<200609262056.32052.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:17055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965332AbWI0FOX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Sep 2006 01:14:23 -0400
In-Reply-To: <200609262056.32052.ismail@pardus.org.tr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ismail Donmez <ismail@pardus.org.tr>
Cc: Stelian Pop <stelian@popies.net>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Tue, 26 Sep 2006 20:56:31 +0300
Ismail Donmez <ismail@pardus.org.tr> wrote:

> 26 Eyl 2006 Sal 19:29 tarihinde =C5=9Funlar=C4=B1 yazm=C4=B1=C5=9Ft=C4=
=B1n=C4=B1z:
> > Andrea Gelmini a =C3=A9crit :
> > > Hi,
> > > 	I've got a Sony Vaio VGN-SZ1VP (dmidecode[1] and lspci[2]).
> > > 	Using default kernel (linux-image-2.6.15-27-686) of Ubuntu
> > > 	Dapper I've got /proc/acpi/sony/brightness and it works well
> > > 	(yes, Ubuntu drivers/char/sonypi.c is patched).
> > > 	With any other newer vanilla kernel, 2.6.15/16/17/18, /proc/acpi=
/sony
> > > 	doesn't appear, and it's impossibile to set brigthness, of
> > > 	course. Same thing with Ubuntu kernel package
> > > 	(linux-image-2.6.17-9-386).
> > > 	I tried to port Ubuntu sonypi.c patches to 2.6.18, but it doesn'=
t
> > > 	work (I mean, it compiles clean, it "modprobes"[3] clean, but no
> > > 	/proc/acpi/sony/ directory).
> >
> > /proc/acpi/sony comes from the sony_acpi driver, not sonypi.
> >
> > You should get the latest sony_acpi driver, preferably from the -mm=
 tree
> > which hosts the most up to date version.
>=20
> Will sony_acpi ever make it to the mainline? Its very useful for new =
Vaio=20
> models.
>=20

I'm inclined to slip it in, but Len has good-sounding reasons for not
merging this sort of driver, and I always forget what they are?

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
