From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Relaxed AML parsing
Date: Fri, 28 Feb 2003 14:30:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030228133015.GD13404@poup.poupinou.org>
References: <Pine.LNX.4.53.0302280059170.1511@hase.a11.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0302280059170.1511-2YYGTGuGu5644ywRPIzf9A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bernhard Kaindl <bernhard.kaindl-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Rick Richardson <rickr-EySxSuIQeMUAvxtiuMwx3w@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 28, 2003 at 02:24:04AM +0100, Bernhard Kaindl wrote:
> Hi,
>    As far as I see the Linux ACPI code has problems with many
> systems which seem to be caused by the ASL compiler tolerating
> field access within the region size, rounded up to a multiple
> of the access byte width.
> 
> In such cases, the current ACPI code fails with an AE_AML_REGION_LIMIT
> error because it does not tolerate the errors the compiler allows.
> 
> I've found Rick Richardsons great relaxed AML parsing patch which
> makes the parser compatible to the compiler, as far as I understood:
> 
> http://home.mn.rr.com/richardsons/toshiba-1115-s103/relaxed-aml.patch
> 
> I think it's only nuts and bolts if the Linux AML parser tolerates
> the same errors which the ASL compiler tolerates.
> 
> I'm new to ACPI, so I would like to ask you if you agree with the above
> and if you think that the relaxed AML parsing should be be included and
> enabled in the acpi patches.

One of the main problem with Rick's patch is that it is too tolerate.  The
same code is shared with other checks so that it may be now possible
to corrupt some buffers especially in case of bug in ACPI-CA.


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
