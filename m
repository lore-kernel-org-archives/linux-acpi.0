From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [PATCH] acpi4asus update
Date: Tue, 23 Mar 2004 13:27:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040323122735.GA18934@hell.org.pl>
References: <20040323000143.GA13711@hell.org.pl> <20040323094627.GA3413@fuchi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040323094627.GA3413-5sK/Rx+du8M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Sebastian Henschel:
> since i am currently working on a M6800N...
> seems to work, although i do not see any difference to the unsupported
> default values before, perhaps brightness. :)
> what still does not work is the the display switch. when i cat
> /proc/acpi/asus/disp i get random values like:
> -583194208
> -583193696
> -1007965376
> -588481760
> 
> the key strokes on Fn+F8 are recognized by acpid.

Hmm, reading the value should not be supported currently and it seems I
have neglected something (looks like reading an uninitialized value here).
I'll take a look at this in a couple of hours.

OTOH, echoing a value (see the current acpi4asus README) to asus/disp
should switch the displays -- at least I was told it worked on M3700N, and
M6800N is similar. Anyway, if it doesn't, there's not really much more
(than what's already in the README) I can do. A word from someone at ASUS
could really help, but you surely know how it looks in the reality...
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
