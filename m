From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: VMware and ACPI
Date: Tue, 23 Sep 2003 08:05:02 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030923060501.GB11372@openzaurus.ucw.cz>
References: <20030919203214.GA579@elf.ucw.cz> <m28yoglhra.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m28yoglhra.fsf-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

>  >> There were some discussions and it seemed that ACPI idling the
>  >> processor while VMware really wanted to use it was the cuplrit. Any
>  >> resulting changes?
>  >>
>  >> I'm running 2.4.22-pre10 now and my WindowsXP inside VMware runs
>  >> horribly slow. It gets considerably better if I leave an USB device
>  >> plugged in (which causes ACPI to use C2 only and never go into C3),
>  >> but it still isn't full speed.
> 
>  Pavel> What about something like
> 
>  Pavel> nice -n 19 while1
> 
> "something like" this doesn't do the job nearly as well, because:
> 
>   1) performance is better than with an otherwise idle machine, but
>      not as good as with the C-state handling turned off
> 
>   2) it eats more power, keeping the cpu in C1 is not the same as
>      keeping it busy
> 
> Please, can we have the patch (attached here again, for everyone's
> convenience) applied? It doesn't do anything harmful to people that do

Looks sane to me. Possible refinement would be saying
"max Cx state you are allowed to use"; one some
machines C3 is usable but is marked bad by bios, it
could be reenabled by this.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
