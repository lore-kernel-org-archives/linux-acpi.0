From: "Arch. Giovanni Andrea Lucaferri" <lucaferri-npIeQ/MgtcxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: acpi poweroff linux problem
Date: Mon, 19 Jul 2004 22:10:40 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40FC2AC0.1000507@makines.com>
References: <40F38865.1050007@makines.com> <Pine.LNX.4.60.0407131226310.2017@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0407131226310.2017-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi hartwig,
no, they don't work.
I think that it can be something in the acpi modules.
Some months ago there was an acpi source package
on intel site. From this package I've built
modules named different from the tipical one,
but now this package is not downloadable anymore.
This apci has worked perfectly but unfortunately
I don't have it anymore.
Somebody remember/have this package?
Thaks hartwig.


hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org ha scritto:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Salut Giovanni,
> On Tue, 13 Jul 2004, Arch. Giovanni Andrea Lucaferri wrote:
> 
>> I have slackware 9.1, kernel 2.4.20 patched with latest acpi .diff
>> on acer laptop travelmate632
>> Everything works but not poweroff.
>> The system close all service and daemon but acipd goes in sleep mode, 
>> not in poweroff.
>> The configuration is the original of the distibution.
> 
> there are two things you may try:
>  1. If your system does not use the local APIC you might build a kernel
>   without "Local APIC support on uniprocessors" CONFIG_X86_UP_APIC
>  2. do not use the rtc-module "Enhanced Real Time Clock Support", but if
>   you need the generic RTC CONFIG_GEN_RTC instead.
> And please report back, if one of this things solves your problem.
> 
> Cheers
>   hartwig felger
> 
> Hartwig Felger informatics
> 
> - -- 1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
> Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
> For the pulic keys, please visit my page.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
> 
> iD8DBQFA87lP9bBoTzOf1pMRAlnFAKDJr0F6LXP/Cd+k/ui7c49szZshigCeO9Rt
> 5Vf5vtKrt1XpVZBIuQFcsPo=
> =9eLx
> -----END PGP SIGNATURE-----
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 - digital 
> self defense, top technical experts, no vendor pitches, unmatched 
> networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
