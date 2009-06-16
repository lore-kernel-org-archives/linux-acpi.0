From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.30: hibernation/swsusp lockup due to acpi-cpufreq
Date: Tue, 16 Jun 2009 02:16:28 +0200
Message-ID: <200906160216.29537.rjw@sisk.pl>
References: <20090615232709.GA6059@sig21.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46631 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbZFPAQW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jun 2009 20:16:22 -0400
In-Reply-To: <20090615232709.GA6059@sig21.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Arjan van de Ven <arjan@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On Tuesday 16 June 2009, Johannes Stezenbach wrote:
> Hi,
> 
> on my aging Thinkpad T42p resume from hibernation
> fails in 2.6.30. There is a backtrace on suspend prior
> to writing out the disk image, but I cannot capture
> it due to lack of a serial port on the T42p. On
> resume the machine is dead after reading the image
> from disk.
> 
> I've bisected this to:
> 
>  commit 01599fca6758d2cd133e78f87426fc851c9ea725
>  Author: Andrew Morton <akpm@linux-foundation.org>
>  Date:   Mon Apr 13 10:27:49 2009 -0700
> 
>     cpufreq: use smp_call_function_[single|many]() in acpi-cpufreq.c
> 
> I see in git log that this commit is known broken, but the
> resume on my machine is still broken in 2.6.30.
> 
> If I disable CONFIG_X86_ACPI_CPUFREQ suspend/resume works in 2.6.30.

Thanks a lot for bisecting this!

Is it the reason for the enabling of interrupts during cpufreq_suspend()?

/me wonders

Is there anything we can do to fix this quickly?

Rafael
