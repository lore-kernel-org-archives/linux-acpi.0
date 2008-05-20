From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 1/7] ACPI Hibernation: Use ACPI hardware signature
Date: Tue, 20 May 2008 17:17:48 +0200
Message-ID: <20080520151748.GA2067@elf.ucw.cz>
References: <200805200129.19904.rjw@sisk.pl> <200805200131.33913.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54705 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbYETPQt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 May 2008 11:16:49 -0400
Content-Disposition: inline
In-Reply-To: <200805200131.33913.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Shaohua Li <shaohua.li@intel.com>

Hi!

> From: Shaohua Li <shaohua.li@intel.com>
> 
> ACPI defines a hardware signature. BIOS calculates the signature
> according to hardware configure, if hardware changes, the signature
> will change, in this case, S4 resume should fail.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> Acked-by: Pavel Machek <pavel@suse.cz>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

I guess I'm quite late to the party, but... could we make this use
acpi_sleep= command line option, and related variable?

That brings advantage of existing /proc/sys interface, so that s2disk
could do blacklist in userspace, and easily...

									Pavel

> @@ -152,6 +152,11 @@ and is between 256 and 4096 characters. 
>  			s3_beep is for debugging; it makes the PC's speaker beep
>  			as soon as the kernel's real-mode entry point is called.
>  
> +	acpi_s4_nosigcheck [HW,ACPI] S4 hardware signature
> +			ACPI will ignore the S4 hardware signature
> +			default: The hardware signature is checked during
> +			         resume from S4.
> +
>  	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
>  			Format: { level | edge | high | low }
>  

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
