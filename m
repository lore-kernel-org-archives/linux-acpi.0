From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [discuss] [RFC] make PC Speaker driver work on x86-64
Date: Mon, 1 May 2006 09:09:28 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0605010906010.5353@yvahk01.tjqt.qr>
References: <200604291830.k3TIUA23009336@harpo.it.uu.se> <200604301046.22369.ak@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from linux01.gwdg.de ([134.76.13.21]:22412 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751294AbWEAHJi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 May 2006 03:09:38 -0400
In-Reply-To: <200604301046.22369.ak@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, Mikael Pettersson <mikpe@it.uu.se>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

>> Is there a better way to do this? ACPI?
>
>Maybe. ACPI folks, any opinion? 
>
>-Andi (known to rip out the speaker cables in new machines) 
>

Leave the cables, try this for ttyX:

diff --fast -Ndpru linux-2.6.16-rc1-git3-SUSE20060124/drivers/char/vt.c linux-2.6-AS24/drivers/char/vt.c
--- linux-2.6.16-rc1-git3-SUSE20060124/drivers/char/vt.c	2006-01-28 19:01:17.000000000 +0100
+++ linux-2.6-AS24/drivers/char/vt.c	2006-01-28 19:01:18.860985000 +0100
@@ -115,7 +115,7 @@ const struct consw *conswitchp;
  * Here is the default bell parameters: 750HZ, 1/8th of a second
  */
 #define DEFAULT_BELL_PITCH	750
-#define DEFAULT_BELL_DURATION	(HZ/8)
+#define DEFAULT_BELL_DURATION	0
 
 extern void vcs_make_devfs(struct tty_struct *tty);
 extern void vcs_remove_devfs(struct tty_struct *tty);
#<<eof>>

X seems silent by default for me, if not, you can configure it too.
But ttyX always get reset to HZ/8 when you make a tty reset, which is why I 
put 0 as a default.



Jan
-- 
