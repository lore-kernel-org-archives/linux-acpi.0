From: Damien Sandras <dsandras-AvcYnRpcIedBDgjK7y7TUQ@public.gmane.org>
Subject: Re: If your ACPI-enabled machine does clean shutdown
	randomly...
Date: Fri, 28 Nov 2003 17:02:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1070035371.1055.13.camel@golgoth01>
References: <20031128145249.GA563@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031128145249.GA563-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Le ven 28/11/2003 =E0 15:52, Pavel Machek a =E9crit :
> ...then you probably need this one. (One notebook I have here
> certainly needs it).
>=20
> It seems that acpi likes to report completely bogus value from time to
> time...
>=20

The problem with that patch is that it is filling the logs, but it is
certainly better than shutting the machine down without warning. I had
that problem and it took me a few minutes to figure out that it was
ACPI.

However, I didn't have that problem with kernel 2.6.0 test 9, it
appeared with 2.6.0 test 10 and test 11. I have mailed the list to see
if there was no patch I could reverse to determine where the problem
was, but I got no reaction, so I guess I will have to live with it ;)


> 								Pavel
>=20
> --- clean/drivers/acpi/thermal.c	2003-07-27 22:31:09.000000000 +0200
> +++ linux/drivers/acpi/thermal.c	2003-11-25 22:27:11.000000000 +0100
> @@ -456,6 +459,10 @@
>  	if (!tz || !tz->trips.critical.flags.valid)
>  		return_VALUE(-EINVAL);
> =20
> +	if (KELVIN_TO_CELSIUS(tz->temperature) >=3D 200) {
> +		printk(KERN_ALERT "Are you running CPU or nuclear power plant? ACPI =
claims CPU temp is %d C. Ignoring.\n", KELVIN_TO_CELSIUS(tz->temperature)=
);
> +		return_VALUE(0);
> +	}
>  	if (tz->temperature >=3D tz->trips.critical.temperature) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Critical trip point\n"));
>  		tz->trips.critical.flags.enabled =3D 1;
> @@ -467,6 +474,7 @@
>  	if (result)
>  		return_VALUE(result);
> =20
> +	printk(KERN_EMERG "Critical temperature reached (%d C), shutting down=
.\n", tz->temperature);
>  	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz->tri=
ps.critical.flags.enabled);
> =20
>  	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);
--=20
Damien Sandras <dsandras-AvcYnRpcIedBDgjK7y7TUQ@public.gmane.org>



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
