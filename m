From: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Problem with acpi_power_off
Date: Fri, 25 Jun 2004 13:01:42 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.60.0406251252280.1488@frog.athome>
References: <40DB37BD.3050904@accelerated.org>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40DB37BD.3050904-rGvcZsxnnNR8Odgaehf8fA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Charles Kendricks <ckendricks-rGvcZsxnnNR8Odgaehf8fA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Charles,

On Thu, 24 Jun 2004, Charles Kendricks wrote:
> I am in charge of several linux 2.6.4 systems with Dragon P4I875P 
> motherboards.  I am relatively new to acpi so my question might seem a little 
> elementary, but I can't seem to get my systems to power off consistently when 
> I issue an init 0.  It seems that all of them will power down sometimes, and 
> at other times the same systems won't power down.  Once powered down I have 
> no problem (at least not yet anyway) waking the systems back up.  What can be 
> causing this inconsistent behavior?????
there are two things you may try:
  1. If your system does not use the local APIC you might build a kernel
   without "Local APIC support on uniprocessors" CONFIG_X86_UP_APIC
  2. do not use the rtc-module "Enhanced Real Time Clock Support", but if
   you need the generic RTC CONFIG_GEN_RTC instead.
And please report back, if one of this things solves your problem.

Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFA3AYa9bBoTzOf1pMRAnEWAJ4sjOVDLtXlmeTBBxRAqb3yIIZITgCg407t
HXSTsVfSijTz1Am7RG+Gabs=
=Ui5K
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
