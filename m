From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [Swsusp-devel] cpu temp probs?
Date: Tue, 18 May 2004 02:06:03 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040518000603.GA28576@hell.org.pl>
References: <40A8D431.9090506@ecn.purdue.edu> <1084824054.23442.6.camel@localhost> <40A9272D.7040405@ecn.purdue.edu> <20040517211849.GB24480@hell.org.pl> <40A937F4.8090601@ecn.purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40A937F4.8090601-UGcGKVkOO5s4WbhGE/lxQQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Christopher N. Deckard" <cnd-UGcGKVkOO5s4WbhGE/lxQQ@public.gmane.org>
Cc: Jon Olson <morph-XAiDara3MvRg9hUCZPvPmw@public.gmane.org>, Software Suspend Mailing List <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Christopher N. Deckard:
> >>I don't close the screen while suspending.  I have been waiting for 
> >>a complete power off just to make sure it's doing it's thing...
> >What does /proc/acpi/processor/*/* say before and after suspend (cat it
> >several times at least)?
> After a normal boot, I seem to stay mostly in C2, but every now and 
> then I see it jump to C1.  Jumps back to C2 almost immediately. 
> After a suspend and resume I stay in C1.

That's odd. Are you sure it's not due to a run-away process or kernel
thread such as keventd? If it's not, could you try reloading the processor
module, or possibly unloading it before suspend and loading back after?
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
