From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Linux 2.6.24.1  - kernel does not boot; IRQ trouble?
Date: Mon, 18 Feb 2008 05:00:56 -0800
Message-ID: <20080218050056.fb0fc0bf.akpm@linux-foundation.org>
References: <23590.97305.qm@web52910.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40759 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760809AbYBRNB7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Feb 2008 08:01:59 -0500
In-Reply-To: <23590.97305.qm@web52910.mail.re2.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 17 Feb 2008 00:54:08 +0000 (GMT) Chris Rankin <rankincj@yahoo.com> wrote:

> [Try this again, except this time I'll force the attachment as inline text!]
> 
> Hi,
> 
> I have managed to boot 2.6.24.1 on this machine, with the NMI watchdog enabled, by using the
> "acpi=noirq" option. (There does seem to be some unhappiness with bridge symlinks in sysfs,
> though.)
> 

Is this a regression?  If so, which was the latest kernel version which
worked OK?

> NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
> NFSD: starting 90-second grace period
> [drm] Initialized drm 1.1.0 20060810
> [drm] Initialized mga 3.2.1 20051102 on minor 0
> agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
> agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
> [drm] Initialized card for AGP DMA.
> 

and here it hangs, I assume?

Please add initcall_debug to the kernel boot command line so we can see if
we can get a more precise idea of where it went wrong.

Do you believe that this hang is somehow caused by x86 NMI?  If so, why?

Thanks.
