From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: PCI not restored correctly after suspend to ram
Date: 19 Mar 2004 14:25:57 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079724357.7278.72.camel@dhcppc4>
References: <200403180935.09436.stefan.doesinger@gym-leoben.asn-graz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200403180935.09436.stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: stefan.doesinger-dYJrdcitkgg0+Ua9VpOLR6Q1ief8SNuKXqFh9Ls21Oc@public.gmane.org
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-03-18 at 03:35, Stefan D=F6singer wrote:
> Hello list,
> I have the following problems with suspend to ram on my Acer Travelmate=
 803
> (Centrino) notebook:
> With the patch for radeon_driver.c(Xfree v. 4.4) I can suspend and resu=
me my=20
> notebook. After resume, the settings of most pci devices are not restor=
ed=20
> correctly and the devices do not work. See the attached lspci_before_su=
spend=20
> and lspci_after_suspend files for details.
> Devices not working are:
> *Soundcard(00:1f.5)
> *All devices on bus 02
> *The modem, but there's only a non-GPL driver available.
>=20
> I can get most devices devies to work by setting the pci registers with=
 setpci=20
> after resume. I use the attached fixpci.sh script to do so. I can get m=
y=20
> soundcard, the ethernet card(02:02.0) and the wireless(02:04.0) to work.

02:04.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini
PCI Adapter (rev 04)

What wireless driver are you using?

The latest version of ipw2100 from http://ipw2100.sf.net saves and
restores pci config space across suspend, so this shouldn't be
necessary. (indeed, that is about all it does, so it needs some work)

Though when I disable that function and S3 suspend/resume my Toshiba,
the only thing that changes in the ipw2100's config space is the
interrupt line goes from 0b to ff.  Curious that your interrupt line
goes from 0a to 00, and that you have other changes too, including the
5th byte which goes from 16 to 00 -- which disables mastering -- surely
a deal killer.

#wireless lan
DEV=3D02:04.0
echo "Configuring $DEV"
$SETPCI -s $DEV  04.w=3D0x0116
$SETPCI -s $DEV  0c.w=3D0x4008
$SETPCI -s $DEV  10.w=3D0x6000
$SETPCI -s $DEV  12.w=3D0xd020
$SETPCI -s $DEV  3c.w=3D0x010a


> I use kernel 2.6.4 and xfree 4.4. I need X to soft-boot the VGA BIOS.
> I use the pci=3Dnobios kernel options, pci=3Dbios does not help here an=
d it causes=20
> crashes on boot under certain conditions




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
