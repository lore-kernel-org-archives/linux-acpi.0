From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Cardbus + ACPI weirdness on a Compaq laptop
Date: Wed, 21 Apr 2004 17:14:39 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040421151439.GD7389@dominikbrodowski.de>
References: <864qrem0mm.fsf@mobile.repose.cx> <86y8oph3pw.fsf@mobile.repose.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <86y8oph3pw.fsf-oYM03kX4ec6+8CgqdUn7AQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Damien Elmes <damien-voeRRA98qc6eZLLa646FqQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Apr 21, 2004 at 10:15:23PM +0900, Damien Elmes wrote:
> The actual events seem strange (to me at least, an ACPI newbie) - I
> imagine "PWRB" is the power button and "PCIB" is the PCI bus? Both
> events are generated about 350 times a second:

These names are not standardized, IIRC, but most likely they mean PCI Bus
and PoWeR Button in your case.

> 22:12:53 Execute Method: [\_GPE._L0B] (Node c12c5208)
> 22:12:53   evmisc-0135 [442] ev_queue_notify_reques: Dispatching Notify(2) on node c12d4528
> 22:12:53   evmisc-0139 [442] ev_queue_notify_reques: Notify value: Device Wake
> 22:12:53   evmisc-0200 [442] ev_queue_notify_reques: No notify handler for [PCIB] node c12d4528
> 22:12:53   evmisc-0135 [442] ev_queue_notify_reques: Dispatching Notify(2) on node c12d8528
> 22:12:53   evmisc-0139 [442] ev_queue_notify_reques: Notify value: Device Wake
> 22:12:53   evmisc-0200 [442] ev_queue_notify_reques: No notify handler for [PWRB] node c12d8528
> 22:12:53 acpi_bus-0494 [435] acpi_bus_notify       : Received DEVICE WAKE notification for device [PCIB]
> 22:12:53 acpi_bus-0494 [435] acpi_bus_notify       : Received DEVICE WAKE notification for device [PWRB]
> 22:12:53 Execute Method: [\_GPE._L0B] (Node c12c5208)
> 22:12:53   evmisc-0135 [442] ev_queue_notify_reques: Dispatching Notify(2) on node c12d4528
> 22:12:53   evmisc-0139 [442] ev_queue_notify_reques: Notify value: Device Wake
> 22:12:53   evmisc-0200 [442] ev_queue_notify_reques: No notify handler for [PCIB] node c12d4528
> 22:12:53   evmisc-0135 [442] ev_queue_notify_reques: Dispatching Notify(2) on node c12d8528
> 22:12:53   evmisc-0139 [442] ev_queue_notify_reques: Notify value: Device Wake
> 22:12:53   evmisc-0200 [442] ev_queue_notify_reques: No notify handler for [PWRB] node c12d8528
> 22:12:53 acpi_bus-0494 [435] acpi_bus_notify       : Received DEVICE WAKE notification for device [PCIB]
> 22:12:53 acpi_bus-0494 [435] acpi_bus_notify       : Received DEVICE WAKE notification for device [PWRB]

Try passing acpi_leave_gpes_disabled to the kernel command line.

The handling of Wake GPEs has been a cause of trouble in the past few weeks,
but soon the ACPI Core Architecture will handle GPEs better.

	Dominik

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAho/fZ8MDCHJbN8YRAgrJAJ4kL6uJsqHFsP235WaQfGd2W4BfRQCfYDdk
bOIkGkHhYCp+CoPB/c5mlb0=
=MQw4
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
