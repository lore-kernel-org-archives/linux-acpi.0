From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Asus P1-AH2 won't suspend (regression)
Date: Fri, 4 Jan 2008 17:56:33 +0100
Message-ID: <200801041756.33733.rjw@sisk.pl>
References: <20080104144238.GA5176@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53176 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715AbYADQyb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Jan 2008 11:54:31 -0500
In-Reply-To: <20080104144238.GA5176@zoy.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michel Lespinasse <walken@zoy.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Friday, 4 of January 2008, Michel Lespinasse wrote:
> Hi,
> 
> I'm unable to get an asus P1-AH2 system to suspend (to ram). The issue
> occurs at suspend time: the system displays "Suspending console(s)" but
> does not turn off the screen and system fans.
> 
> I used to have suspend/resume working fine on this system using a
> 2.6.20.x kernel. Yes, I know this is a huge range... suspend has
> been broken on this sytem since at least 2.6.22.x
> 
> I tried running 2.6.24-rc6 with verbose PM debugging and suspend/resume
> event tracing. Still no luck, the last message I see is still
> "Suspending console(s)". The information from event tracing seems to be:
>   Magic number: 8:471:282
>   hash matches device tty19
> 
> I'm not sure if that's any help. Is there any way to help figure out the
> problem besides a git bisect ? would extra event traces during/after the
> suspend console stage help ???
> 
> This is with an x86_64 kernel. .config file can be found at
> http://lespinasse.org/config-2.6.24-rc6 if that's any help.

Please try the patch series from:
http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.24-rc6/patches/
on top of 2.6.24-rc6 (patches 28-34 are relevant in particular) and see if that
helps.

Thanks,
Rafael
