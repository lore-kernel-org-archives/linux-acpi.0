From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI and VIA C3
Date: Mon, 28 Jun 2004 14:03:04 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040628120304.GC5614@poupinou.org>
References: <40DF395C.5010700@antar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40DF395C.5010700-KBAKnD37014@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ludwig Meyerhoff <ludwig-KBAKnD37014@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jun 27, 2004 at 11:17:16PM +0200, Ludwig Meyerhoff wrote:
> Hallo!
> 
> I have a VIA C3 (Ezra) processor. It is very nice for "normal"
> applications, as it takes only a few watt.
> 
> I have a problem with the ACPI support of the kernel ...
> While 2.4.20 recognizes the processor to support C1 and C2 states, the
> 2.4.26 does not, as the 2.6.6 does not also.


I need to look a little bit in a full acpi dump.
Could you please do something like that :

wget ftp://ftp.kernel.org//pub/linux/kernel/people/lenb/acpi/utils/pmtools-20031210.tar.bz2
tar xjvfp pmtools-20031210.tar.bz2
cd pmtools-20031210/acpidmp
make
sudo ./acpidmp > acpidmp.out
bzip2 acpidmp.out 

Then mail me the acpidmp.out.bz2

> AFAIK the ACPI support has been rewritten for the 2.6 kernel and
> backported to 2.4 in 2.4.23 or something ...
> 
> Now: does anyone know how I can achieve full ACPI support for my
> processor in a more recent kernel than 2.4.20? In special I would like
> to use frequency scaling/throttling, as most of the time my small
> computer does nothing.

For this, you may want to try cpufreq and the longhaul driver.
You should try that on 2.6.7 kernel at least because the cpufreq longhaul
driver for the 2.4 is not updated, and there were a very recent change
to the longhaul stuff IIRC.

> I already tried the epia1 patch on the 2.6.6 kernel and the acpi patch
> on 2.6.7 kernel, both without a satisfying result ...

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
