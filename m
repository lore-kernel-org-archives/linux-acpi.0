From: Ti Leggett <leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org>
Subject: Re: Various Lockups with IBM T30
Date: 04 Oct 2002 12:20:21 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1033752021.1579.6.camel@scraz.mcs.anl.gov>
References: <1033750314.1578.4.camel@scraz.mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1033750314.1578.4.camel-tIO8fc+LZfeHIU8xwMp6mvIbXMQ5te18@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I forgot to mention that passing "pci=noacpi" has no effect on the
outcome.

On Fri, 2002-10-04 at 11:51, Ti Leggett wrote:
> I'm still trying to get my IBM T30 to even boot with ACPI enabled. I've
> managed to output my console over serial so I can capture the output and
> here's what happens.
> 
> 2.4.20-pre8 (with 20021002 patch):
>   - hangs trying to initialize NET4
> 2.4.20-pre8-ac3 (no acpi patch applied)
>   - Oopses at some point during init but spews out a bunch of ACPI
> errors before
> 2.5.40 (with 20021002 patch):
>   - Oopses right after ACPI Power Resource
> 
> I'm attaching the ouputs of each of these logs. I've also managed to
> dump my DSDT so if that's needed (because I really don't know what to do
> with it) I'll send it as well.
> 
> -- 
> Ti Leggett <leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org>
-- 
Ti Leggett <leggett-zhzY/AYb9nBYTrM/R70HSA@public.gmane.org>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
