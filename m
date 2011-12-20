From: joeyli <jlee@suse.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Tue, 20 Dec 2011 16:13:39 +0800
Message-ID: <1324368819.10394.335.camel@linux-s257.site>
References: <3123346.jTQFjj4kVk@pali-elitebook>
	 <1323442149.20114.93.camel@linux-s257.site>
	 <3404497.1txogKB5v8@pali-elitebook>  <6900186.lBeFrD3GRB@pali-elitebook>
	 <1324223229.10394.39.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1324223229.10394.39.camel@linux-s257.site>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

=E6=96=BC =E6=97=A5=EF=BC=8C2011-12-18 =E6=96=BC 23:47 +0800=EF=BC=8Cjo=
eyli =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi Pali,=20
>=20
> =E6=96=BC =E6=97=A5=EF=BC=8C2011-12-18 =E6=96=BC 11:59 +0100=EF=BC=8C=
Pali Roh=C3=A1r =E6=8F=90=E5=88=B0=EF=BC=9A
> > On Friday 09 December 2011 16:46:29 Pali Roh=C3=A1r wrote:
> > > On Friday 09 December 2011 22:49:09 joeyli wrote:
> > > > Hi Pali,
> > > >=20
> > > > =E6=96=BC =E4=BA=94=EF=BC=8C2011-12-09 =E6=96=BC 22:36 +0800=EF=
=BC=8CLi Joey =E6=8F=90=E5=88=B0=EF=BC=9A
> > > >=20
> > > > > ---------- Forwarded message ----------
> > > > > From: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > > > > Date: 2011/7/15
> > > > > Subject: Brightness on HP EliteBook 8460p
> > > > > To: linux-acpi@vger.kernel.org
> > > > >=20
> > > > >=20
> > > > > Hello,
> > > > >=20
> > > > > on my HP EliteBook 8460p is not possible to set display brigh=
tness
> > > > > when ACPI
> > > > > is enabled in kernel. Entries in sysfs is properly created wi=
thout
> > > > > errors. But
> > > > > when I try write any value
> > > > > to /sys/class/backlight/acpi_video0/brightness
> > > > > nothing happened (and no error is in dmesg). When I press Fn =
key for
> > > > > chaining
> > > > > display brightness kernel send correct key event (tested with=
 xev)
> > > > > but
> > > > > nothing
> > > > > happened too.
> > > > >=20
> > > > > When I disabled ACPI (acpi=3Doff in kernel command line) all =
=46n keys
> > > > > are
> > > > > broken
> > > > > and not working (no events in xev). But brightness keys worki=
ng (I
> > > > > think on HW
> > > > > level, because xev does not see it) - increase and decrease d=
isplay
> > > > > brightness.
> > > > >=20
> > > > > So what can I do with my notebook? I think that there is erro=
r/bug
> > > > > in
> > > > > BIOS or
> > > > > ACPI because with disabled ACPI brightness working. But with
> > > > > disabled
> > > > > ACPI is
> > > > > notebook unuseable (no battery info, no Fn keys, no WIFI rfki=
ll,
> > > > > ...).
> > > > > Can
> > > > > somebody help me with this problem?
> > > > >=20
> > > > > --
> > > > > Pali Roh=C3=A1r
> > > > > pali.rohar@gmail.com
> > > >=20
> > > > You can try to put kernel parameter:
> > > > 	acpi_osi=3D"!Windows 2009"
> > > >=20
> > > > to /boot/grub/menu.lst, then reboot look at maybe better.
> > > >=20
> > > > And,
> > > > could you please kindly share DSDT and dmidecode to me?
> > > >=20
> > > > Plesae login by root then:
> > > > 	% acpidump > acpidump.dat
> > > > 	% dmidecode > dmidecode.log
> > > >=20
> > > > Thanks a lot!
> > > > Joey Lee
> > >=20
> > > Hello,
> > >=20
> > > adding any acpi_osi values did not changed anything (also tried o=
ther osi
> > > strings from decompiled DSDT table). Brightness problem is in bot=
h BIOS and
> > > UEFI boot mode.
> > >=20
> > > I attached acpidump and dmidecode output from bios and uefi mode =
too.
> >=20
> > Did you find way how to control display brightness?
> >=20
> > --=20
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com
>=20
> I am really sorry for I am sticking on another tough issue.
> I will look at your DSDT tomorrow.
>=20
>=20
> Thanks
> Joey Lee
>=20

I just look at the DSDT of HP EliteBook, this machine check _OS name
string, it's essentially obsolete.

Please add the following kernel parameter to /boot/grub/menu.lst:
	acpi_os_name=3D"Windows 2009"

Let's by-pass the _OS name check first, hope it fix this issue.


Thanks
Joey Lee
