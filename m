From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] fix for 2.4.21-pre2 and acpi-20021212
Date: Mon, 6 Jan 2003 18:52:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030106175205.GC374@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A847137F23@orsmsx401.jf.intel.com> <4.3.2.7.2.20030103222354.00ae1aa0@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20030103222354.00ae1aa0-KvFWrsCPMkLbFfAX06+HdQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Margit Schubert-While <margitsw-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 03, 2003 at 10:42:52PM +0100, Margit Schubert-While wrote:
> At 11:58 03.01.03 -0800, you wrote:
> >> From: Jörg Prante [mailto:joergprante-UIqTAjE4tzc5WgrkcBd8vg@public.gmane.org]
> >> this patch is needed for acpi-20021212 with 2.4.21-pre2 on a
> >> Pentium 4 with
> >> ACPI IO-APIC. The dynamic MP busses and IRQ_SOURCES in
> >> 2.4.21-pre2 introduced
> >> a conflict that will rise NULL pointer dereferences when
> >> combined with the
> >> ACPI patch. I don't have the hardware to test it, but Margit
> >> Schubert-While
> >> reported a successful boot.
> >>
> >> http://infolinux.de/jp/087_acpi-mpparse-fix
> >
> >Excellent! Thanks, applied.
> >
> >Regards -- Andy
> 
> Hi Andy,
>         Now that I have done my good deed for the day(s) ,
>         perhaps you can answer this.  :-)
>         M/B is a D845PESVL with latest BIOS.
>         Nothing shows up in "fan" and "thermal_zone".
>         Looking on the Intel site, however shows a Windows
>         tool for getting this info. Hmmm.
>         A quick squint at the DSDT shows some suspicious
>         "if windows" tests. Hmmm.
>         Is the ACPI table only releasing this info for Windows ?
>         I really would like to know how my P4 is cooking :-)
> 
>         Margit
> 

I guess an EC SMB driver that (still) need to be written for Linux.
That should be for the lm-sensors team, I think.

The only trouble I think is to know where is the (first) EC adress for
that stuff, perhaps in the registry?

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
