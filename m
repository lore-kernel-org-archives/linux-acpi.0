From: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Re: Problem with acpi_power_off
Date: Fri, 25 Jun 2004 23:17:36 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.60.0406252308590.5636@frog.athome>
References: <000001c45ace$1c7a33b0$c301a8c0@M20001>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <000001c45ace$1c7a33b0$c301a8c0-hFB0+YgzIhE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Charles E. Kendricks, Jr." <ckendricks-rGvcZsxnnNR8Odgaehf8fA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Charles,
On Fri, 25 Jun 2004, Charles E. Kendricks, Jr. wrote:

> Gentlemen, thank you for the tip, but I already pass "noapic" to my boot
> command in grub (my system clock was originally running at 2X normal
> speed)....shouldn't that take care of the CONFIG_X86_UP_APIC module in
> the kernel, and if so, is there not another argument that I can pass to
> the boot command in grub to take care of the Enhanced Real Time Clock??
> I'm not looking forward to having to rebuild the kernel on 16 linux
> boxes :^(
Ok. the boot-parameter is nolapic. But I do not know, if this is realy 
the same, as not having it compiled in...
With the clock, it depends if you have the rtc compiled as a module, or 
build in the kernel itself. If you enabled the support /proc/config.gz, 
you may want to have a look, if it is built in, or as module, or not at 
all...
If it is included as a module, you may want, to move the rtc.ko to a 
different place, where the modprobe will not find it.

Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFA3JZ+9bBoTzOf1pMRAkrhAKDKbUp/BcOc+/bSjw4gtyuXAV7oAwCg4/aV
7dbHGb7fLd9DGOXd3y8yQFU=
=ifod
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
