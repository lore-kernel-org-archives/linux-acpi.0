From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Thinkpad docking station
Date: Mon, 8 Mar 2004 10:04:21 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD803300B58@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: josh-RX4kr3I2FRNAfugRpC6u6w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
Current ACPI doesn't support docking station. The implementation is
ongoing.=20

Thanks,
David
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Josh Litherland
> Sent: Sunday, March 07, 2004 11:49 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] Thinkpad docking station
>=20
> I have a docking station for my Thinkpad X31.  It seems to be treated
in
> Windows as an ACPI hotplug PCI device, and doesn't require any special
> (i.e. IBM specific) drivers as far as I can tell.  The short version
of
> my question is, to what extent should I expect this to be supported
> right now ?
>=20
> Here are some details:
>=20
> The IBM p/n is 02k8660, there's a picture and some nontechnical specs
> here:
>=20
> http://www.thehistoryofcomputers.com/items/3461667855.html
>=20
> When I boot with the device in, my lspci shows the following
additional
> devices:
>=20
> 02:03.0 PCI bridge: Texas Instruments PCI2032 PCI Docking Bridge
>=20
> (The bridge itself)
>=20
> 09:00.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev
03)
>=20
> (Part of the 4-port NIC I have in the PCI slot)
>=20
> 09:01.0 IDE interface: CMD Technology Inc PCI0648 (rev 01)
> 09:02.0 CardBus bridge: Texas Instruments PCI1420
> 09:02.1 CardBus bridge: Texas Instruments PCI1420
>=20
> (Other components that are within the dock)
>=20
> 0a:04.0 Ethernet controller: Digital Equipment Corporation DECchip
> 21142/43 (rev 41)
> 0a:05.0 Ethernet controller: Digital Equipment Corporation DECchip
> 21142/43 (rev 41)
> 0a:06.0 Ethernet controller: Digital Equipment Corporation DECchip
> 21142/43 (rev 41)
> 0a:07.0 Ethernet controller: Digital Equipment Corporation DECchip
> 21142/43 (rev 41)
>=20
> (The 4 ethernet chips on the PCI card)
>=20
> The device has a software-controlled lock that seizes the laptop as
soon
> as it powers up.  In windows, when I press the unlock button, it
churns
> for a few seconds shutting down devices, and then unlocks.  The button
> does this (with appropriate debugging knobs turned on):
>=20
> Execute Method: [\_SB_.PCI0.LPC_.EC__._Q50] (Node dfdf7ce8)
>   evmisc-0121 [403930] ev_queue_notify_reques: Dispatching Notify(3)
on
> node c15e17e8
>   evmisc-0141 [403930] ev_queue_notify_reques: Unknown Notify Value: 3
>   evmisc-0199 [403930] ev_queue_notify_reques: No notify handler for
> [GDCK] node c15e17e8
> acpi_bus-0498 [403922] acpi_bus_notify       : Received EJECT REQUEST
> notification for device [GDCK]
>=20
> So, the long version of my question is, to what extent should I expect
> to be able to hot-plug and unplug this dock, and what further
> information is needed to debug it ?
>=20
> Running Linux 2.6.4-rc1.
>=20
> Thanks !
>=20
> --
> Josh Litherland (josh-RX4kr3I2FRNAfugRpC6u6w@public.gmane.org)


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
