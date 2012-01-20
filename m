From: joeyli <jlee@suse.com>
Subject: Re: Fwd: [Bugreport] Screen backllight issues on FirePro M5950 (HP
 EliteBook 8560w)
Date: Fri, 20 Jan 2012 11:35:53 +0800
Message-ID: <1327030553.15960.92.camel@linux-s257.site>
References: <CAEPe-G+b9U-vdDmU29=GjyABab=5-MzWm4U6pBj1upRgLjH1OQ@mail.gmail.com>
	 <CAGB3EUR750VpHdvrZ25mn9bcS-4ZT+BSJ_zD4-sRncyYNT=0Zg@mail.gmail.com>
	 <1323442460.20114.95.camel@linux-s257.site>
	 <CAEPe-G+iooX_BOD=5m1nMgn+t63XGsLR+4JCfvHKOyTx98qydg@mail.gmail.com>
	 <1324443308.10394.456.camel@linux-s257.site>
	 <CAEPe-GLzak+SG3-H4Sw8KsQmpsh-v0UJWfHQb7hXoycO0GoWTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAEPe-GLzak+SG3-H4Sw8KsQmpsh-v0UJWfHQb7hXoycO0GoWTA@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Artur Flinta <aflinta@gmail.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Artur,=20

Sorry for I am late to reply you.

=E6=96=BC =E4=B8=89=EF=BC=8C2011-12-21 =E6=96=BC 10:42 +0100=EF=BC=8CAr=
tur Flinta =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi Joey!
>=20
> On Wed, Dec 21, 2011 at 5:55 AM, joeyli <jlee@suse.com> wrote:
> > Could you please help to enable acpi debug log?
> >        acpi.debug_level=3D0x2 acpi.debug_layer=3D0xFFFFFFFF
> >
> > Please attached dmesg and messages log that cover system boot and
> > pressed brightness key a couple of times.
>=20
> Added debug parameters, restarted, after GNOME loaded pressed dozen o=
f
> times brightness shortcuts... logs in attachment.
>=20

Looks like the acpi debug level not enough, please kindly change acpi
debug parameter to:
	acpi.debug_level=3D0xF acpi.debug_layer=3D0xFFFFFFFF log_buf_len=3D5M

And, please remember press brightness function key a couple of times
before you dump the dmesg and messages log.

> > And,
> > Please also monitor does there have any value of gpe was increased =
when
> > you press brightness keys:
> >
> > watch -n 1 cat /sys/firmware/acpi/interrupts/gpe[012][0123456789ABC=
DEF]
> >
> > Please tell me which gpe's value increased if you found.
>=20
> Unfortunately none of values have changed (almost all stated 0, one 5=
04).
>=20

hmm..... that mean the brightness function key does not emit acpi/wmi
event.

Please help to check the raw scan code from the function key:

	+ please add kernel parameter atkbd.softraw=3D0 to /boot/grub/menu.lis=
t
	+ please switch to console 1, then run:=20
		showkey -s

Press backlight function key and look at maybe have scan code capture b=
y showkey.=20


Thanks a lot!
Joey lee
