From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: PCI not restored correctly after suspend to ram
Date: 19 Mar 2004 13:10:56 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079719856.7278.30.camel@dhcppc4>
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
...
> I can get most devices devies to work by setting the pci registers with=
 setpci=20
> after resume. I use the attached fixpci.sh script to do so. I can get m=
y=20
> soundcard, the ethernet card(02:02.0) and the wireless(02:04.0) to work=
. I=20
> have not tested firewire(02:07.0). The secound Cardbus bride(02:06.1) s=
eems=20
> to have more problems, it's not even listed correctly.
> The file "lspci_after_suspend_fix" contains the output of lspci -vvx af=
ter=20
> running fixpci.sh
>=20
> Restoring the pci registers is a workaround, but I'd like the kernel to=
 handle=20
> this so I don't have to unload and reload all modules, especially the=20
> soundcard driver.
>=20
> It this a acpi bug, a bug in the pci driver or a bug in the drivers for=
 the=20
> devices?

Stefan,
Bruno is correct, the PCI config space should be saved and restored by
the driver's suspend and resume routines.  suspend/resume routines
typically do other hardware dependent stuff, but your debugging suggests
that at least for some of these devices, simply saving and restoring pci
config space (pci_save_state()/pci_restore_state()) may be sufficient.

Time to take a look at the drivers for those devices...

cheers,
-Len




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
