From: Andre Hedrick <andre-QA/0nRrxPJrNLxjTenLetw@public.gmane.org>
Subject: Re: S3 Resume working, but IDE disk hung
Date: Mon, 7 Oct 2002 20:57:00 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.10.10210072045080.31069-100000@master.linux-ide.org>
References: <20021006205358.GA387@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021006205358.GA387-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, "Faraoni, Michael" <Michael.Faraoni-YwRvm6FT6jBDPfheJLI6IQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 6 Oct 2002, Pavel Machek wrote:

> Hi!
> 
> [Note, you should look at the patch "to prevent data corruption". It
> could do the trick. At least it should be good as a base.
> 
> > Prior to suspend one needs to :
> > 
> > 	block all new coming requests.
> > 	flush cache and wait for return.
> > 	disable DMA, and switch to PIO 0.
> 
> Why would you want to switch off DMA and go PIO 0?

Because it is a known state when we drop out of the driver.
99% of the failures of ACPI (please read the fine print, where it requires
discrete access to "task file registers") is not knowing where or what
stated the device and driver is set in.

The reality is it does not matter if it is in PIO 0 to the hardware, but
setting the values in the kernel so it knows what to do is critical.

> As long as DMA is not happening (that is not disabled, we just don't
> ask drive to do it), you should be fine.
                       ^^^^^^^^^^^^^^^^^^

Should does not cut it, period.
Either you are or are not correct.
Guessing in the middle is unacceptable to me.
Call me Andre "The Anal Retentive Dude Wielding a SPEC" Hedrick, but
building from the top down is how and why the driver got in the mess it
is/was today.

> > Resume requires calling :
> > 
> > 	"do_reset()"
> > 	for (;;)
> > 		if ((check_power()) == active)
> > 			break;
> > 	"piix_config_drive_xfer_rate()" 
> > 	unblock request pathway.
> 
> You don't need to block/unblock request pathways. kernel/suspend.c
> takes care of that.

Really, try sending a command to a drive when it is not ready.  Try send
it to after a sleep, and watch it eat the command and hang the bus.

It really seems like you can not or will not listen to real-documented
logical concerns.  So please do as you wish and push it through, it does
not bother me.  It will give me another chance to blast Linus and deflect
it to you at the next Summit when people start badgering me again over the
order of operations for suspend.  Sheesh, even Andy Grover at the 2.5
summit in San Jose admitted I was correct in the model.

I am now out of the issue directly, please send to Alan Cox, and I will
address is concerns about the issues.

Cheers,

Andre Hedrick
LAD Storage Consulting Group



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
