From: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Subject: Re: kernel 2.4.20: 3 bugs in: i387.c; make xconfig; acpi
Date: Wed, 11 Jun 2003 10:01:48 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0306110957380.1653-100000@home.transmeta.com>
References: <3EE35F48.56A00972@vavra.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3EE35F48.56A00972-ewvLLG/tgEk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Petr Vavra <petr-ewvLLG/tgEk@public.gmane.org>
Cc: gareth-jCdQPDEk3idBDgjK7y7TUQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mec-WqBc5aa1uDFeoWH0uzbU5w@public.gmane.org, bug-gnu-utils-n5io46ZZ9gDezta1RN11IA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Sun, 8 Jun 2003, Petr Vavra wrote:
>
> kernel 2.4.20
> I am using linux based on Redhat 5.2, with upgrades and updates from source code libraries:
> gcc version pgcc-2.91.60 19981201 (egcs-1.1.1 release)
> tcsh-6.07.09-1
> make version 3.76.1

Whee. You'll need to update your binutils too, since the kernel does 
expect a compiler suite slightly more recent than the French revolution ;)

I also suspect we require make 3.78 these days, which may explain some of 
your other build problems.

See "Documentation/Changes" for suggested tool versions.

			Linus



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
