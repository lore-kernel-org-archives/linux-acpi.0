From: Marcel Meckel <acpi-X2Xph2rMQzhn68oJJulU0Q@public.gmane.org>
Subject: Re: acpi-20040311-2.4.25 errors on apply
Date: Sat, 27 Mar 2004 04:16:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040327041603.6852787d.acpi@thermoman.de>
References: <20040327031249.3c30100c.acpi@thermoman.de>
	<20040327023226.GW19001@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040327023226.GW19001-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > 2.4.25/acpi-20040311-2.4.25.diff.gz
> > 
> > results in more than 20 errors when trying to apply to a vanilla
> > 2.4.25 kernel - don't you test your patches?
> 
> Releases are based mainly on latest kernel sources.  Sometimes, it
> may happens that the patch do not apply cleany on older kernel.

Latest stable 2.4 Kernel is 2.4.25 and latest ACPI patches
for 2.4.25 don't apply (acpi-20040326-2.4.25.diff.gz too).

When you now argue that patches for "older" Kernels like 2.4.25 won't
apply cleanly - why you release them? It's kind of useless to release
a patch for kernel 2.6.4 labeled as 'patch-for-2.4.25'. The result is
the same - it doesn't apply.

When you already work on patches for "older" kernels they _should_
(my point of view) atleast apply cleanly on vanilla kernels.

I would appreciate it if we could discuss this.

Marcel.

(cc's not required anymore since SF only accepts mail from subscribed
senders)

-- 
http://debian.thermoman.de/


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
