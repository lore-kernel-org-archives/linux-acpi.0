From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: CONFIG_SUSPEND? (was: Re: [GIT PATCH] ACPI patches for
 2.6.23-rc1)
Date: Thu, 26 Jul 2007 13:55:18 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707261351430.3442@woody.linux-foundation.org>
References: <200707251238.50218.lenb@kernel.org> <200707262117.26353.rjw@sisk.pl>
 <alpine.LFD.0.999.0707261255380.3442@woody.linux-foundation.org>
 <200707262248.09187.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59941 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757143AbXGZU4R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2007 16:56:17 -0400
In-Reply-To: <200707262248.09187.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, david@lang.hm, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>



On Thu, 26 Jul 2007, Rafael J. Wysocki wrote:
> 
> My point is we have ACPI dependent on PM, so if you want ACPI, you end
> up with all of the STR stuff built in, which is what you don't like (if I
> understand that correctly).  If we have CONFIG_SUSPEND, you'll be able to
> choose ACPI alone. :-)

Good point. 

Anyway, I think the ACPI problem really is as trivial as the following 
three-liner removal fix. If the user doesn't want suspend, ACPI shouldn't 
force it on him.

A nicer fix might be to also make some of the ACPI helper routines depend 
on whether they are needed or not (which in turn will depend on whether 
suspend support has been compiled into the kernel), but quite frankly, 
that's secondary at least for me.

So if we have a few ACPI routines that will never get called (because we 
don't even enable the interfaces that would *cause* them to be called), I 
don't think that's a huge problem. It's a beauty wart, but nobody really 
cares (and it's even something that we could get the compiler to optimize 
away for us if we really cared).

		Linus

---
    Don't force-enable suspend/hibernate support just for ACPI
    
    It's a totally independent decision for the user whether he wants
    suspend and/or hibernation support, and ACPI shouldn't care.
    
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 drivers/acpi/Kconfig |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 251344c..22b401b 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -11,9 +11,6 @@ menuconfig ACPI
 	depends on PCI
 	depends on PM
 	select PNP
-	# for sleep
-	select HOTPLUG_CPU if X86 && SMP
-	select SUSPEND_SMP if X86 && SMP
 	default y
 	---help---
 	  Advanced Configuration and Power Interface (ACPI) support for 
