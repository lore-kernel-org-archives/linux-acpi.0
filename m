From: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: acpi poweroff linux problem
Date: Tue, 13 Jul 2004 12:28:19 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.60.0407131226310.2017@frog.athome>
References: <40F38865.1050007@makines.com>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40F38865.1050007-npIeQ/MgtcxBDgjK7y7TUQ@public.gmane.org>
Content-ID: <Pine.LNX.4.60.0407131227491.2017-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Arch. Giovanni Andrea Lucaferri" <lucaferri-npIeQ/MgtcxBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Giovanni,
On Tue, 13 Jul 2004, Arch. Giovanni Andrea Lucaferri wrote:
> I have slackware 9.1, kernel 2.4.20 patched with latest acpi .diff
> on acer laptop travelmate632
> Everything works but not poweroff.
> The system close all service and daemon but acipd goes in sleep mode, not in 
> poweroff.
> The configuration is the original of the distibution.
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

iD8DBQFA87lP9bBoTzOf1pMRAlnFAKDJr0F6LXP/Cd+k/ui7c49szZshigCeO9Rt
5Vf5vtKrt1XpVZBIuQFcsPo=
=9eLx
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
