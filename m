From: Josh Litherland <josh-RX4kr3I2FRNAfugRpC6u6w@public.gmane.org>
Subject: Thinkpad docking station
Date: Sun, 07 Mar 2004 10:48:30 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078674510.4349.15.camel@JubJub>
Reply-To: josh-RX4kr3I2FRNAfugRpC6u6w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UeVKHBKpLc1lKUzo0+Lv"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-UeVKHBKpLc1lKUzo0+Lv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I have a docking station for my Thinkpad X31.  It seems to be treated in
Windows as an ACPI hotplug PCI device, and doesn't require any special
(i.e. IBM specific) drivers as far as I can tell.  The short version of
my question is, to what extent should I expect this to be supported
right now ?

Here are some details:

The IBM p/n is 02k8660, there's a picture and some nontechnical specs
here:

http://www.thehistoryofcomputers.com/items/3461667855.html

When I boot with the device in, my lspci shows the following additional
devices:

02:03.0 PCI bridge: Texas Instruments PCI2032 PCI Docking Bridge

(The bridge itself)

09:00.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)

(Part of the 4-port NIC I have in the PCI slot)

09:01.0 IDE interface: CMD Technology Inc PCI0648 (rev 01)
09:02.0 CardBus bridge: Texas Instruments PCI1420
09:02.1 CardBus bridge: Texas Instruments PCI1420

(Other components that are within the dock)

0a:04.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
0a:05.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
0a:06.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
0a:07.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)

(The 4 ethernet chips on the PCI card)

The device has a software-controlled lock that seizes the laptop as soon
as it powers up.  In windows, when I press the unlock button, it churns
for a few seconds shutting down devices, and then unlocks.  The button
does this (with appropriate debugging knobs turned on):

Execute Method: [\_SB_.PCI0.LPC_.EC__._Q50] (Node dfdf7ce8)
  evmisc-0121 [403930] ev_queue_notify_reques: Dispatching Notify(3) on
node c15e17e8
  evmisc-0141 [403930] ev_queue_notify_reques: Unknown Notify Value: 3=20
  evmisc-0199 [403930] ev_queue_notify_reques: No notify handler for
[GDCK] node c15e17e8
acpi_bus-0498 [403922] acpi_bus_notify       : Received EJECT REQUEST
notification for device [GDCK]

So, the long version of my question is, to what extent should I expect
to be able to hot-plug and unplug this dock, and what further
information is needed to debug it ?

Running Linux 2.6.4-rc1.

Thanks !

--=20
Josh Litherland (josh-RX4kr3I2FRNAfugRpC6u6w@public.gmane.org)

--=-UeVKHBKpLc1lKUzo0+Lv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAS0ROBrTD/Ik9kigRAupLAJ0XIBCWjA3lcRXdmbe3wCRHTqo2CQCaA20M
FzNtlB8euBvHLgpfbECgAkU=
=UNJX
-----END PGP SIGNATURE-----

--=-UeVKHBKpLc1lKUzo0+Lv--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
