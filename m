From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 Resume working, but IDE disk hung
Date: Sun, 6 Oct 2002 22:53:58 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021006205358.GA387@elf.ucw.cz>
References: <1033746424.32384.41.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.10.10210042302000.10557-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10210042302000.10557-100000-eTnbHd5RJ1QZiu+GbOt07GD2FQJk+8+b@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Andre Hedrick <andre-QA/0nRrxPJrNLxjTenLetw@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, "Faraoni, Michael" <Michael.Faraoni-YwRvm6FT6jBDPfheJLI6IQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

[Note, you should look at the patch "to prevent data corruption". It
could do the trick. At least it should be good as a base.

> Prior to suspend one needs to :
> 
> 	block all new coming requests.
> 	flush cache and wait for return.
> 	disable DMA, and switch to PIO 0.

Why would you want to switch off DMA and go PIO 0?

As long as DMA is not happening (that is not disabled, we just don't
ask drive to do it), you should be fine.

> Resume requires calling :
> 
> 	"do_reset()"
> 	for (;;)
> 		if ((check_power()) == active)
> 			break;
> 	"piix_config_drive_xfer_rate()" 
> 	unblock request pathway.

You don't need to block/unblock request pathways. kernel/suspend.c takes care of that.

									Pavel
-- 
I'm pavel-7aPAsKgELzg@public.gmane.org "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss-q33YXrgyAoMgsBAKwltoeQ@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
