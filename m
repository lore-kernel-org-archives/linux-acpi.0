From: Ville =?iso-8859-1?Q?P=E4tsi?= <drc-gbHDUNYU5Z63CdJRPK1N2g@public.gmane.org>
Subject: Re: Critical temperature even when idle with 2.6.7+patch, works fine in 2.4.26
Date: Thu, 8 Jul 2004 10:13:16 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040708071316.GB2455@torni>
References: <20040702094846.GB2141@torni> <20040702122725.GD16229@rap.rap.dk> <200407021848.46872.kernelpenguin@hot.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200407021848.46872.kernelpenguin-S7FoVGKkKTI@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Elver Loho <kernelpenguin-S7FoVGKkKTI@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Keld =?iso-8859-1?Q?J=F8rn?= Simonsen <keld-6PR53cSIHaE@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> : I have the same problem on an Acer Travelmate 233 XC (same model).
> : The system gets really heated under kernel 2.6.7, while under 2.6.3 it
> : runs much cooler. Also I see from metering power consumption that
> : it seems like the CPU does not do idle looping. It does not reach 80
> : degrees, but something like 65 degrees is common, while on 2.6.3 the
> : system stays about 48 degrees. I run X on the system, but the system is
> : quite idle.
> Similar problem here. 1.3ghz Celeron M. Anyone found the source of the problem 
> yet?

I opened a bug for this. http://bugzilla.kernel.org/show_bug.cgi?id=3008
In there is atleast a workaround that works for me.



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
