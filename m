From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [PATCH] acpi_leave_sleep_state (was: [PATCH] Re: [BUG] acpi_hw_[enable|disable]_non_wakeup_gpe_block)
Date: Tue, 17 Feb 2004 01:11:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040217001126.GB11190@hell.org.pl>
References: <200402142317.41033.a.malysh@centrium.de> <20040215200724.GN13262@poupinou.org> <200402152200.08010.a.malysh@centrium.de> <200402152312.53837.a.malysh@centrium.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200402152312.53837.a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alexander Malysh <a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thus wrote Alexander Malysh:
> Hi again,
> 
> what are you think about attached patch?
> 
> Note: at least on my laptop gpes must be enabled before '_WAK' method 
> execution, otherwise after '_WAK' was executed interrupts are enabled and gpe 
> register were restored with wrong values...
> 
> @Karol: can you please get this patch a try?

It does help, ACPI interrupts are fine after resume. Overall it works the 
same as the one for bug#1409, but the approach is better.

Len, please apply, possibly even for 2.6.3?

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
