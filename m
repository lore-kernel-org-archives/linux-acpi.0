From: joeyli <jlee@suse.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Wed, 21 Dec 2011 10:16:50 +0800
Message-ID: <1324433810.10394.402.camel@linux-s257.site>
References: <3123346.jTQFjj4kVk@pali-elitebook>
	 <1324223229.10394.39.camel@linux-s257.site>
	 <1324368819.10394.335.camel@linux-s257.site>
	 <1700296.GfeBjppFVA@pali-elitebook>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1700296.GfeBjppFVA@pali-elitebook>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

=E6=96=BC =E4=BA=8C=EF=BC=8C2011-12-20 =E6=96=BC 14:20 +0100=EF=BC=8CPa=
li Roh=C3=A1r =E6=8F=90=E5=88=B0=EF=BC=9A
> On Tuesday 20 December 2011 16:13:39 joeyli wrote:
> > > > >=20
> > > > > adding any acpi_osi values did not changed anything (also tri=
ed
> > > > > other osi strings from decompiled DSDT table). Brightness
> > > > > problem is in both BIOS and UEFI boot mode.
> > > > >=20
> > > > > I attached acpidump and dmidecode output from bios and uefi m=
ode
> > > > > too.
> > > >=20
> > > > Did you find way how to control display brightness?
> > >=20
> > > I am really sorry for I am sticking on another tough issue.
> > > I will look at your DSDT tomorrow.
> > >=20
> > >=20
> > > Thanks
> > > Joey Lee
> >=20
> > I just look at the DSDT of HP EliteBook, this machine check _OS nam=
e
> > string, it's essentially obsolete.
> >=20
> > Please add the following kernel parameter to /boot/grub/menu.lst:
> > 	acpi_os_name=3D"Windows 2009"
> >=20
> > Let's by-pass the _OS name check first, hope it fix this issue.
> >=20
> >=20
> > Thanks
> > Joey Lee
>=20
> Hello,
>=20
> I tried to add one of these acpi_os_name into grub kernel command lin=
e:
>=20
> acpi_os_name=3D"Windows 2009"
> acpi_os_name=3D"Windows 2006"
> acpi_os_name=3D"Windows 2001"
> acpi_os_name=3D"Windows 2001 SP1"
> acpi_os_name=3D"Windows 2001 SP2"
>=20
> but brightness control (via /sys/class/backlight/acpi_video0/brightne=
ss) did=20
> not worked.
>=20
> --=20
> Pali Roh=C3=A1r
> pali.rohar@gmail.com

In DSDT, check the following 3 OS name strings, just need feed a string
not in list could be by-pass _OS check:

    Name (OSID, Package (0x03)
    {
        "Microsoft Windows",
        "Microsoft WindowsME: Millennium Edition",
        "Microsoft Windows NT"                  /* match with Linux ker=
nel's _OS name default define */
    })

Unfortunately, just by-pass _OS check cann't fix your problem. I need
spend time to dig more detail in your DSDT.
Could you please attached your whole dmesg log that cover system boot
and press brightness control key a couple of times?


Thanks a lot!
Joey Lee
