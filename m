From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: ACPI source patches updated (20021101)
Date: Fri, 8 Nov 2002 10:59:40 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021108095940.GA3102@elf.ucw.cz>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B8BE@orsmsx107.jf.intel.com> <m21y6286dh.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m21y6286dh.fsf-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >>>>> "Robert" == Robert Moore writes:
>  Robert> We have discovered a possible situation where an Acquire() with
>  Robert> an infinite wait (0xFFFF) could in fact timeout without
>  Robert> obtaining the mutex.  This may be the root of the problem you
>  Robert> are seeing.
> 
>  Robert> Andy is preparing a patch.  
> 
> Great!
> 
> On a related note, I'm seeing situations where ACPI starts to eat my CPU
> time. It has to be related to the mutex issue -- but perhaps should be
> fixed independently.
> 
> In most cases I see a kacpidpc thread that eats CPU, but sometimes the
> machine slows down _A LOT_ (windows being redrawn slowly, etc), even
> when kacpidpc is not visibly running. In my case, it's always related to
> fans -- whenever ACPI tries to manage them, I run into problems and
> eventually have to reboot.

Maybe thermal throttling is going on? Or machine overheats and bios
slows down to save it.
								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
