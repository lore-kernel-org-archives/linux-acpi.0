From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: b44 suspend/resume (Re: PCI not restored correctly after suspend to ram)
Date: Sun, 21 Mar 2004 20:13:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403212013.49973.stefandoesinger@gmx.at>
References: <200403180935.09436.stefan.doesinger@gym-leoben.asn-graz.ac.at> <1079728500.7277.140.camel@dhcppc4>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1079728500.7277.140.camel-D2Zvc0uNKG8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Freitag, 19. M=E4rz 2004 21:35 schrieben Sie:
> #broadcom ethernet controller
> DEV=3D02:02.0
> echo "Configuring $DEV"
> $SETPCI -s $DEV =A004.w=3D0x0106
> $SETPCI -s $DEV =A008.w=3D0x0810
> $SETPCI -s $DEV =A00c.w=3D0x4000
> $SETPCI -s $DEV =A010.w=3D0x4000
> $SETPCI -s $DEV =A012.w=3D0xd020
>
> I think this is the b44. Looking at b44_suspend/b44_resume, I don't see
> any calls to pci_save_state()/pci_restore_state() that I would expect,
> so it comes back after resume with bus mastering disabled etc.

I looked at the code, and there are no pci_save_state()/pci_restore_state()=
=2E I=20
added them, but I think I did something wrong, the behaviour didn't change.=
=20
With pci_write_config_dword(...) and the values I change in my fixpci.sh th=
e=20
device comes back correctly:
static int b44_resume(struct pci_dev *pdev)
{
	struct net_device *dev =3D pci_get_drvdata(pdev);
	struct b44 *bp =3D dev->priv;

	pci_set_power_state(pdev,0);
	pci_enable_device(pdev);
=09
	/*Restore pci. Acer tm 803 specific*/
=09
	pci_write_config_word(pdev, 0x04, 0x0106);
	pci_write_config_word(pdev, 0x08, 0x0810);
	pci_write_config_word(pdev, 0x0c, 0x4000);
	pci_write_config_word(pdev, 0x10, 0x4000);
	pci_write_config_word(pdev, 0x12, 0xd020);

	if (!netif_running(dev))
		return 0;
=2E....

I will try to add a more general patch again as soon as I have time to do s=
o.

Cheers,
Stefan


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
