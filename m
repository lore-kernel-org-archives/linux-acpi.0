From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Fwd: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume on Centrino notebook (contains agp, lapic, swsusp)]
Date: Wed, 11 Feb 2004 18:58:42 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040211175842.GO13262@poupinou.org>
References: <3ACA40606221794F80A5670F0AF15F8401CBB68D@PDSMSX403.ccr.corp.intel.com> <m3smhhakb3.fsf@reason.gnu-hamburg> <20040211123601.GN13262@poupinou.org> <m3smhhycwz.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m3smhhycwz.fsf-glUV91rXKAHWIjgkaejU9x2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 11, 2004 at 02:16:12PM +0100, Georg C. F. Greve wrote:
>  || On Wed, 11 Feb 2004 13:36:01 +0100
>  || Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote: 
> 
>  >> and so the machine crashes hard & instantly, followed by reboot.
> 
>  bd> That sound like a memory fault in a SMI handler, imho.
> 
> Furher info: when the same kernel is booted with "nolapic" and FN+F8
> is pressed, display switching occurs, but the top of the screen is
> screwed -- and seems to show parts from the framebuffer console.
> 
> When using the i810switch tool, switching the crt on/off works fine,
> while LCD cannot be switched at all with that tool...
> 
> If anyone has concrete suggestions where to look or what to try, let
> me know...
> 

Perhaps wait for the little ACPI video driver I am currently polishing a
little ?

I think it should be OK tomorrow, but I have not tested it throughfully
though.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
