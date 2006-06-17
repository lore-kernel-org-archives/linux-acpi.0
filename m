From: Linus Torvalds <torvalds@osdl.org>
Subject: Resume on Apple Mac Mini
Date: Sat, 17 Jun 2006 14:18:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606171408230.5498@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB670F3C4@hdsmsx411.amr.corp.intel.com>
 <44677056.1080004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:50361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750906AbWFQVTB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Jun 2006 17:19:01 -0400
In-Reply-To: <44677056.1080004@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>, "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org


It turns out that the Apple Mac Mini comes back from suspend in legacy 
mode.

The simplest and most obvious fix would seem to be the following trivial 
one-liner, which just enables ACPI mode after any suspend event.

Comments? Can anybody see any downsides to just doing something this 
obvious, and doing it unconditionally?  I've seen a much more complicated 
patch that only does this for Apple hardware, but I wouldn't be surprised 
at all if this is more common.

In fact, googling for the symptoms ("nobody cared" and "acpi_irq" and 
"suspend") gives quite a number of hits, so I would not be surprised at 
all if this is not Apple-related at all, but that we should always have 
done this.

Comments? 

		Linus

---
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 56f861e..7b6c146 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -109,6 +108,11 @@ static int acpi_pm_enter(suspend_state_t
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
 
+	/*
+	 * Make sure we're back in ACPI mode!
+	 */
+	acpi_enable();		
+
 	/* restore processor state
 	 * We should only be here if we're coming back from STR or STD.
 	 * And, in the case of the latter, the memory image should have already
