From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: acpi-20040311-2.4.25 errors on apply
Date: Sat, 27 Mar 2004 04:35:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040327033552.GX19001@poupinou.org>
References: <20040327031249.3c30100c.acpi@thermoman.de> <20040327023226.GW19001@poupinou.org> <20040327041603.6852787d.acpi@thermoman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040327041603.6852787d.acpi-X2Xph2rMQzhn68oJJulU0Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marcel Meckel <acpi-X2Xph2rMQzhn68oJJulU0Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Mar 27, 2004 at 04:16:03AM +0100, Marcel Meckel wrote:
> > > 2.4.25/acpi-20040311-2.4.25.diff.gz
> > > 
> > > results in more than 20 errors when trying to apply to a vanilla
> > > 2.4.25 kernel - don't you test your patches?
> > 
> > Releases are based mainly on latest kernel sources.  Sometimes, it
> > may happens that the patch do not apply cleany on older kernel.
> 
> Latest stable 2.4 Kernel is 2.4.25 and latest ACPI patches
> for 2.4.25 don't apply (acpi-20040326-2.4.25.diff.gz too).

I'm talking about latest *sources*, not lastest *stable* release.

> When you now argue that patches for "older" Kernels like 2.4.25 won't
> apply cleanly - why you release them? It's kind of useless to release
> a patch for kernel 2.6.4 labeled as 'patch-for-2.4.25'. The result is
> the same - it doesn't apply.

I don't release them.  It's up to Len which have to maintain the 2.6
*and* the 2.4 acpi subsystem.  He is making a lot of efforts to maintain
at least two tree (the one to be submitted to kernels maintainers, the
one to be tested by developers) and that make up to 4 tree actually to
maintain.

I do not appreciate personnaly people that come suddenly on a
*developper* list and claims that we do not test stuff that anyway will
go to the bk tree for each kernel maintainers.

> When you already work on patches for "older" kernels they _should_
> (my point of view) atleast apply cleanly on vanilla kernels.

Then if something do not apply ok, please be more polite before sending
comments, thanks.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
