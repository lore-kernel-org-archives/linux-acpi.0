From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Battery Status on Acer Extensa 4101
Date: Wed, 23 Mar 2005 17:50:37 +0100
Message-ID: <20050323165037.GN2298@poupinou.org>
References: <200503221114.22874.phil_wo@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <200503221114.22874.phil_wo-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Philipp Wollermann <phil_wo-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 22, 2005 at 11:14:19AM +0100, Philipp Wollermann wrote:
> Hello again,
>=20
> well - no one replied to my last mail, so I'll post again with the curr=
ent=20
> status. :-) The ACPI errors on boot continue to appear, however the onl=
y=20
> thing which isn't working is to get the status of the battery. I can se=
e it=20
> in /proc/acpi/battery/BAT1/state but it says:
>=20
> # cat /proc/acpi/battery/BAT1/state
> present:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0yes
> ERROR: Unable to read battery status
>=20
> I tried to use the sbs-cm patches but they don't apply to my DSDT (actu=
ally,=20
> the DSDT doesn't even compile with the IASL without any patches. :-(). =
I then=20
> tried to use the program smartbatt which only needs a small kernel patc=
h=20
> (acpi-ec-2.6.10.diff which applies cleanly to my 2.6.11.3) and then tri=
es to=20
> access the battery using i2c. However there are no i2c busses detected!
>=20
> bash-2.05b# ./smartbattery
> Error: No i2c-bus specified!
> Syntax: smartbatt I2CBUS
> Error: No I2C busses found!
> Be sure you have done 'modprobe i2c-dev'
> and also modprobed your i2c bus drivers

It wont work: there isn't a smartbattery susbsystem declared in that DSDT

> I did load the modules of course. Does anyone have an idea how I could =
get the=20
> state of my battery?

That DSDT is buggy for sure, but Im not sure its the original one.

I cant debug anyway.  I need a full acpidump (there are SSDT) and I got o=
nly
a decompiled DSDT from your previous mail.


wget ftp://ftp.kernel.org//pub/linux/kernel/people/lenb/acpi/utils/pmtool=
s-20031210.tar.bz2
tar xjvfp pmtools-20031210.tar.bz2
cd pmtools-20031210/acpidmp
make
sudo ./acpidmp > acpidmp.out
bzip2 acpidmp.out=20

Then mail me the acpidmp.out.bz2

Cheers,

--=20
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Regi=
ster
by 3/29 & save $300 http://ads.osdn.com/?ad_id=3D6883&alloc_id=3D15149&op=
=3Dclick
