From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI on Toshiba Satellite 3000-601
Date: Mon, 6 Jan 2003 14:46:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030106134627.GC18725@poup.poupinou.org>
References: <8358.1041290606@www43.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8358.1041290606-2fnMVCGmqB9mcu3hnIyYJQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nikolaus Filus <NFilus-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi, Nikolaus (sorry for the long time response, I was on vacation).

On Tue, Dec 31, 2002 at 12:23:26AM +0100, Nikolaus Filus wrote:
> Hi,
>     
> few days ago I updated my kernel to 2.4.20 and acpi 20021212 along with
> Bruno's fixed dsdt (tosh3k-601.v5). It's success is different, as there are
> positive and negative changes. Here's an overview:
> 
> + ac_adapter/ACAD/state                 OK
> + battery/BAT[12]/state                 OK
> + embedded_controller/EC0/info          OK
> + processor/CPU0/*                      P0, P1, C1      OK
> + events for button/{lid,power}/        works for the first time

Ah?  It work now?  Good.

> + thermal_zone/THM0/temperature         works (others not supported)

Yes, sorry.  The thermal zone I wrotten is really basic.  It has only a
critical trip and give current temperature.  No passive nor active policy
is written at this time (the passive one should be added since it is
'easy'.  I got some trouble with the active one).

> + sleep                                 S0 S1 S3 S4 S5
> 
> S1, S5 works as expected, but S3 and S4 do exactly nothing - no debug msg.

S2, S3 and S4 is not supported at that time in 2.4 series.

> 
> - booting without mem=240M results in AE_NO_MEMORY (512 avail.)
> - booting with    mem=240M results in broken pcmcia (kernel)
> - closing the lid results in a lot of debug msg to console (temp gets high)
> 
> Dec 28 21:52:40 mobile kernel: [ACPI Debug] String: =====GPE_L1D=====
> Dec 28 21:52:40 mobile kernel: exregion-0146 [2361] Ex_system_memory_space:
> Could not map memory at 000000000FEFFEAD, size 90
> Dec 28 21:52:40 mobile kernel: evregion-0323: *** Error: Handler for
> [System_memory] returned AE_NO_MEMORY
> Dec 28 21:52:40 mobile kernel:  psparse-1103: *** Error: Method execution
> failed+[\_SB_.PCI0.LPCB.PHSS] (Node c15b3808), AE_NO_MEMORY
> Dec 28 21:52:40 mobile kernel:  psparse-1103: *** Error: Method execution
> failed+[\_GPE._L1D] (Node c1593848), AE_NO_MEMORY
> Dec 28 21:52:40 mobile kernel:    evgpe-0572: *** Error: AE_NO_MEMORY while
> evaluating method [_L1D] for GPE[1D]
> 

Yes, I know.  there is a problem for now if the amount of ram is
not the same as the amount of the 'initial' laptop (grumble, I should
write it in the README in my ftp site, sorry).
I need to get your own AML in order to correct that.
Could you please provide me it via pmtools for example?
Thanks in advance.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
