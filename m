From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: latest acpi-patch on vanilla 2.4.25
Date: 27 Mar 2004 00:28:36 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080365315.16211.74.camel@dhcppc4>
References: <20040326131004.GG17527@informatik.uni-freiburg.de>
	 <1080326120.757.227.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1080326120.757.227.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Niko Ehrenfeuchter <ehrenfeu-jNDFPZUTrfROceuj71AUlABBhMqQ4zRThC4ANOJQIlc@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I've replaced the 2.4.25 ACPI patches on kernel.org
and the 2.4.25 ACPI trees on bkbits.net

Thanks Niko and others for pointing out that my 2.4.25 ACPI
patch didn't apply cleanly to a fresh kernel.org 2.4.25 tree.
The reason was because I'd apparently leaked some 2.4.26 back
into my 2.5.25 tree and so the patch was effectively based on
too-new a tree.

Let me know if you see any future problems.

thanks,
-Len

ps. I've deleted the 2.4.24 trees (where do you think I got
the new 2.4.25 trees so quickly;-) and will no longer
issue new patches against 2.4.24.  So we're down to

2.4.22 (mainly for backporting to old distro releases)
2.4.25 (latest released 2.4)
2.4.26 (in development 2.4)

2.6.4 (latest released 2.6)
2.6.5 (in development 2.6)





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
