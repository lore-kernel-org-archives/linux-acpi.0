From: Keld =?iso-8859-1?Q?J=F8rn?= Simonsen <keld-6PR53cSIHaE@public.gmane.org>
Subject: Re: turning off individual devices
Date: Sun, 7 Mar 2004 10:06:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040307090622.GA14593@rap.rap.dk>
References: <20040305222117.GA20865@rap.rap.dk> <Law11-OE414phnpK9h70002b8bd@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Law11-OE414phnpK9h70002b8bd-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dino Klein <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: Keld =?iso-8859-1?Q?J=F8rn?= Simonsen <keld-6PR53cSIHaE@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 05, 2004 at 11:21:37PM -0500, Dino Klein wrote:
> check kernel/Documentation/power/devices.txt
> the value there indicates in which state to put the device after the dr=
iver detaches from it.

Yes, I did read that document before posting. That document says that:
A value of 4 indicates that the device should be shutdown, so
->shutdown() will be called for that device.

But it does not seem to have an effect.
And I do not seem to have a driver running for that device.

But does that matter whether the device is in use or not?
Or should there be an error message if the device is in use?

> ----- Original Message -----=20
> From: "Keld J=F8rn Simonsen" <keld-6PR53cSIHaE@public.gmane.org>
> To: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Sent: Friday, March 05, 2004 5:21 PM
> Subject: [ACPI] turning off individual devices
>=20
>=20
> > I try to turn off individual devices by saying
> >
> >    echo -n 4 >  /sys/devices/pci0000:00/0000:00:1f.6/detach_state
> >
> > But it seems that nothing happens. Am I missing something?
> > Kernel 2.6.3
> >
> > Keld


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
