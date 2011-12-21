From: joeyli <jlee@suse.com>
Subject: Re: Fwd: [Bugreport] Screen backllight issues on FirePro M5950 (HP
 EliteBook 8560w)
Date: Wed, 21 Dec 2011 12:55:08 +0800
Message-ID: <1324443308.10394.456.camel@linux-s257.site>
References: <CAEPe-G+b9U-vdDmU29=GjyABab=5-MzWm4U6pBj1upRgLjH1OQ@mail.gmail.com>
	 <CAGB3EUR750VpHdvrZ25mn9bcS-4ZT+BSJ_zD4-sRncyYNT=0Zg@mail.gmail.com>
	 <1323442460.20114.95.camel@linux-s257.site>
	 <CAEPe-G+iooX_BOD=5m1nMgn+t63XGsLR+4JCfvHKOyTx98qydg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAEPe-G+iooX_BOD=5m1nMgn+t63XGsLR+4JCfvHKOyTx98qydg@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Artur Flinta <aflinta@gmail.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

=E6=96=BC =E5=85=AD=EF=BC=8C2011-12-10 =E6=96=BC 11:54 +0100=EF=BC=8CAr=
tur Flinta =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi Joey!
>=20
> On Fri, Dec 9, 2011 at 3:54 PM, joeyli <jlee@suse.com> wrote:
> >
> > You can try to put kernel parameter:
> >
> >        acpi_osi=3D"!Windows 2009"
> >
> > to /boot/grub/menu.lst, then reboot look at maybe better.
>=20
> No change for me :(
>=20
> > And,
> > could you please kindly share DSDT and dmidecode to me?
> > Plesae login by root then:
> >        % acpidump > acpidump.dat
> >        % dmidecode > dmidecode.log
>=20
> Sure, in attachment.
>=20
> Regards
> Artur
>=20
>=20

Just checked your DSDT, didn't see _BCM implementation on this machines=
,
and also didn't see useful _Q event function.

Could you please help to enable acpi debug log?
	acpi.debug_level=3D0x2 acpi.debug_layer=3D0xFFFFFFFF

Please attached dmesg and messages log that cover system boot and
pressed brightness key a couple of times.

And,=20
Please also monitor does there have any value of gpe was increased when
you press brightness keys:

watch -n 1 cat /sys/firmware/acpi/interrupts/gpe[012][0123456789ABCDEF]

Please tell me which gpe's value increased if you found.


Thanks a lot!
Joey Lee
