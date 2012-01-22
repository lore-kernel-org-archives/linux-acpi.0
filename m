From: joeyli <jlee@suse.com>
Subject: Re: Fwd: [Bugreport] Screen backllight issues on FirePro M5950 (HP
 EliteBook 8560w)
Date: Sun, 22 Jan 2012 09:45:27 +0800
Message-ID: <1327196727.15960.118.camel@linux-s257.site>
References: <CAEPe-G+b9U-vdDmU29=GjyABab=5-MzWm4U6pBj1upRgLjH1OQ@mail.gmail.com>
	 <CAGB3EUR750VpHdvrZ25mn9bcS-4ZT+BSJ_zD4-sRncyYNT=0Zg@mail.gmail.com>
	 <1323442460.20114.95.camel@linux-s257.site>
	 <CAEPe-G+iooX_BOD=5m1nMgn+t63XGsLR+4JCfvHKOyTx98qydg@mail.gmail.com>
	 <1324443308.10394.456.camel@linux-s257.site>
	 <CAEPe-GLzak+SG3-H4Sw8KsQmpsh-v0UJWfHQb7hXoycO0GoWTA@mail.gmail.com>
	 <1327030553.15960.92.camel@linux-s257.site>
	 <CAEPe-G+H6CDDzg9-fXZK4MJbKw_-MJFSMheCL9=yN4Gt=fmaTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAEPe-G+H6CDDzg9-fXZK4MJbKw_-MJFSMheCL9=yN4Gt=fmaTQ@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Artur Flinta <aflinta@gmail.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

=E6=96=BC =E4=BA=94=EF=BC=8C2012-01-20 =E6=96=BC 22:38 +0100=EF=BC=8CAr=
tur Flinta =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi Joey!
>=20
> On Fri, Jan 20, 2012 at 4:35 AM, joeyli <jlee@suse.com> wrote:
> > Sorry for I am late to reply you.
>=20
> No problem :)
>=20
> > Looks like the acpi debug level not enough, please kindly change ac=
pi
> > debug parameter to:
> >        acpi.debug_level=3D0xF acpi.debug_layer=3D0xFFFFFFFF log_buf=
_len=3D5M
> >
> > And, please remember press brightness function key a couple of time=
s
> > before you dump the dmesg and messages log.
>=20
> Cause the brightness function key does not emit acpi/wmi event I'll
> skip this step.
>=20

OK

> > Please help to check the raw scan code from the function key:
> >
> >        + please add kernel parameter atkbd.softraw=3D0 to /boot/gru=
b/menu.list
> >        + please switch to console 1, then run:
> >                showkey -s
> >
> > Press backlight function key and look at maybe have scan code captu=
re by showkey.
>=20
> Brightness increase: 0xe0 0x54 0xe0 0xd4
> Brightness decrease: 0xe0 0x4c 0xe0 0xcc
>=20
> Regards
> Artur
>=20

#define KEY_BRIGHTNESSDOWN      224
#define KEY_BRIGHTNESSUP        225

Suggest you can try to run the following command before run X-windows:

setkeycodes e054 224
setkeycodes e04c 225

If it works, then we can add the above rules to udev keymaps.


Thanks a lot!
Joey Lee
