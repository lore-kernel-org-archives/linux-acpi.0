From: Matt Mackall <mpm@selenic.com>
Subject: [PATCH] x86: trim ACPI sleep stack buffer
Date: Thu, 09 Oct 2008 11:56:21 -0500
Message-ID: <1223571381.17706.94.camel@calx>
References: <1222819957.13453.15.camel@calx>
	 <20081009085649.GC29957@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from waste.org ([66.93.16.53]:57332 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753080AbYJIQ6w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2008 12:58:52 -0400
In-Reply-To: <20081009085649.GC29957@atrey.karlin.mff.cuni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Thu, 2008-10-09 at 10:56 +0200, Pavel Machek wrote:
> > We've got:
> > 
> > #if defined(CONFIG_SMP) && defined(CONFIG_64BIT)
> > static char temp_stack[10240];
> > #endif
> > 
> > and:
> > 
> > #ifdef CONFIG_SMP
> >         stack_start.sp = temp_stack + 4096;
> > #endif
> > 
> > ..which suggests we use at most 4k of the stack?
> 
> I guess someone (probably me) was "playing it safe" -- not exactly
> remembering if stack grows down or up. I guess it should be safe to
> change it... will do that.
> 									Pavel

I've already got a patch, I was just wondering if there was some obscure
architectural reason for it that I wasn't aware of.


x86: trim ACPI sleep stack buffer

x86_64 SMP suspend to RAM uses a 10k temporary stack for saving the
kernel state, but only 4k of it is used. Shrink it to 4k.

Signed-off-by: Matt Mackall <mpm@selenic.com>

diff -r 73d55a1b6c10 arch/x86/kernel/acpi/sleep.c
--- a/arch/x86/kernel/acpi/sleep.c	Wed Oct 08 14:48:45 2008 -0500
+++ b/arch/x86/kernel/acpi/sleep.c	Thu Oct 09 11:51:54 2008 -0500
@@ -21,7 +21,7 @@
 static unsigned long acpi_realmode;
 
 #if defined(CONFIG_SMP) && defined(CONFIG_64BIT)
-static char temp_stack[10240];
+static char temp_stack[4096];
 #endif
 
 /**

-- 
Mathematics is the supreme nostalgia of our time.

