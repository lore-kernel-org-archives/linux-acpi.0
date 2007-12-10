From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: suspend to RAM failure on t61p
Date: Sun, 9 Dec 2007 23:25:47 -0800
Message-ID: <20071209232547.1d0c6599.akpm@linux-foundation.org>
References: <20071209011928.c9873c66.akpm@linux-foundation.org>
	<475BE227.2040003@dbservice.com>
	<20071209164053.fc8ceabb.akpm@linux-foundation.org>
	<200712100204.13881.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56593 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750978AbXLJHZ4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Dec 2007 02:25:56 -0500
In-Reply-To: <200712100204.13881.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Tomas Carnecky <tom@dbservice.com>, linux-acpi@vger.kernel.org

On Mon, 10 Dec 2007 02:04:13 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Monday, 10 of December 2007, Andrew Morton wrote:
> > On Sun, 09 Dec 2007 13:40:07 +0100 Tomas Carnecky <tom@dbservice.com> wrote:
> > 
> > > Andrew Morton wrote:
> > > > 2.6.24-rc4 on a Lenovo t61p, using FC8 config.
> > > > 
> > > > echo mem > /sys/power/state while running X.
> > > > 
> > > > It appears to suspend OK but then it instantly resumes and runs
> > > > OK except the display is blank.
> > > 
> > > http://bugzilla.kernel.org/show_bug.cgi?id=9258
> > > 
> > > I have a X61 tablet, and the screen is blank after resume, too, but
> > > pressing ctrl+alt+F1/F7 usually fixes it. It seems a problem with the X
> > > video driver. I'm not sure though.
> > > 
> > 
> > This machine doesn't bring the display back after resume-from-RAM under
> > 2.6.23 either.
> > 
> > The post-2.6.23 regresison here is that the suspend itself fails.  Under
> > 2.6.23 the machine suspends and requires a keystrike to start resuming. 
> > Under 2.6.24-rc4 it just instantly resumes all by itself.
> 
> Please see if the appended patch helps (it will probably break the RTC wakeup
> again, but well ...).
> 
> 
> ---
>  kernel/power/disk.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6/kernel/power/disk.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/disk.c
> +++ linux-2.6/kernel/power/disk.c
> @@ -378,9 +378,12 @@ int hibernation_platform_enter(void)
>  		return error;
>  
>  	suspend_console();
> -	error = device_suspend(PMSG_SUSPEND);
> -	if (error)
> -		goto Resume_console;
> +	/*
> +	 * FIXME: device_suspend(PMSG_SUSPEND) should be called here, but
> +	 * some EHCI controllers make boxes reboot instead of going into the
> +	 * S4 sleep state in that case.
> +	 */
> +	device_shutdown();
>  
>  	error = hibernation_ops->prepare();
>  	if (error)

Nope, the machine still instantly resumes after suspend-to-RAM.

Sigh.  I guess I need to git-bisect my cant-find-root-disk problem and then
once that is fixed I can bisect this suspend-to-RAM-resumes-itself
regression and the resume-from-disk-causes-reboot regression.

