From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [PATCH][RFC] Add C3 support to P4-M / ICH-M chipsets
Date: Mon, 24 May 2004 12:59:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040524105938.GA21559@hell.org.pl>
References: <20040518211431.GA17545@hell.org.pl> <1085110450.12353.553.camel@dhcppc4> <20040521180155.GP29214@poupinou.org> <20040521194205.GA25863@hell.org.pl> <20040524101130.GB4387@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040524101130.GB4387-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thus wrote Bruno Ducrot:
> Sound like you are correct.  For the patch itself though, there is at
> least those troubles:
> - There is systems where you really don't support bus master
> arbitration.
> - you assume that DIS_ARB is at PMBASE + 0x20, which is true only
> for a subset of chipsets.  Actually, there are more for which it's at
> 0x22 I believe (and this is not an offset relative to PMBASE).

Yes, that's why I stated that the patch is for ICH3-M, and possibly other
ICH-M chipsets in the original mail. I don't know a thing on how C3 is done
on other processors and chipsets. I'm willing to learn and implement that
(hence my questions about a more general solution for chipset-specific
stuff) provided there are potential users. So far, nobody except you and
Len has answered. I might try rephrasing the original mail and post it to
lkml now that I'm fairly certain the patch doesn't cause any corruption on
my system though.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
