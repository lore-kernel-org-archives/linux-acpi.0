From: Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>
Subject: Re: s4bios: does anyone use it?
Date: Tue, 08 Mar 2005 10:42:23 +0100
Message-ID: <422D737F.2020807@suse.de>
References: <16A54BF5D6E14E4D916CE26C9AD305750155EBB0@pdsmsx402.ccr.corp.intel.com> <20050308091856.GB16436@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050308091856.GB16436-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Pavel Machek wrote:
> Hi!
>=20
>> >Okay, so we had 2 users in past but have 0 users now? :-).
>> I wonder how could anyone use S4BIOS in 2.6.11. S4 and S4b all came in=
to
>> 'enter_state'. and in acpi_sleep_init:
>>=20
>> 		if (i =3D=3D ACPI_STATE_S4) {
>> 			if (acpi_gbl_FACS->S4bios_f) {
>> 				sleep_states[i] =3D 1;
>> 				printk(" S4bios");
>> 				acpi_pm_ops.pm_disk_mode =3D
>> PM_DISK_FIRMWARE;
>> 			}
>> 			if (sleep_states[i])
>> 				acpi_pm_ops.pm_disk_mode =3D
>> PM_DISK_PLATFORM;
>> 		}
>> That means we actually can't set PM_DISK_FIRMWARE (always set
>> PM_DISK_PLATFORM). Is this intended? If no, .pm_disk_mode should be a
>> mask.
>=20
> pm_disk_mode is settable using /sys/power/disk, no?

No, it isn't. That was my original point: you can write "firmware" into
it, but it has no effect. This probably was a side-effect of the "make
firmware mode not default" patch from a year ago.
But the real question is: what is firmware mode good for today? Is there
a single machine where firmware mode once worked, but swsusp does not
work today?

> Anyway, what about this, then?
>=20
> --- clean/Documentation/feature-removal-schedule.txt	2005-01-22 21:24:5=
0.000000000 +0100
> +++ linux/Documentation/feature-removal-schedule.txt	2005-03-08 10:18:0=
5.000000000 +0100

Fine with me. I think it cannot work since ~one year (when we changed
the default from "firmware if available" to "shutdown always", the code
piece cited above) and nobody complained until now, so it won't be
missed IMO.
--=20
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX N=FCrnberg.

"Any ideas, John?"
"Well, surrounding them's out."


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
