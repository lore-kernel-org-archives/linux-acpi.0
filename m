From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: 2.6.21-rc2 regression vs. 2.6.20: AT keyboard only works with pci=noacpi
Date: Wed, 7 Mar 2007 23:14:24 -0500
Message-ID: <200703072314.25316.dtor@insightbb.com>
References: <20070303151424.3b08c33e.thatistosayiseenem@gawab.com> <20070307212534.325f2f32.thatistosayiseenem@gawab.com> <d120d5000703071350s42285352g5c9824755c58163@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:1696 "EHLO
	asav04.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbXCHEOX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Mar 2007 23:14:23 -0500
In-Reply-To: <d120d5000703071350s42285352g5c9824755c58163@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ash Milsted <thatistosayiseenem@gawab.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org

On Wednesday 07 March 2007 16:50, Dmitry Torokhov wrote:
> On 3/7/07, Ash Milsted <thatistosayiseenem@gawab.com> wrote:
> >
> > So, I tracked this down to 2.6.21-git7, the first snapshot that gives me
> > this problem. Tellingly it does contain an input tree merge. I would git bisect
> > but I don't have a local copy of the tree - I tried to get one, but it stopped
> > halfway through the clone, probably because I had to use http... So, I hope that
> > helps.
> >
> 
> Hm, that is strange... 2.6.20-rc7 has i8042 AUX IRQ delivery test fix
> and fix for panic blink, both shoudl not really affect your keyboard.
> Can I please get full dmesg of boot with "i8042.debug
> log_buf_len=131072"?
> 

Argh, I can't believe I forgot to get this into my tree. Could you please
tell me if the patch below fixes ytour issue?

-- 
Dmitry

Input: i8042 - another attempt to fix AUX delivery checks

Do not assume that AUX_LOOP command is broken unless it
completes successfully but returns wrong (unexpected) data.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/serio/i8042.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: linux/drivers/input/serio/i8042.c
===================================================================
--- linux.orig/drivers/input/serio/i8042.c
+++ linux/drivers/input/serio/i8042.c
@@ -553,7 +553,8 @@ static int __devinit i8042_check_aux(voi
  */
 
 	param = 0x5a;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0x5a) {
+	retval = i8042_command(&param, I8042_CMD_AUX_LOOP);
+	if (retval || param != 0x5a) {
 
 /*
  * External connection test - filters out AT-soldered PS/2 i8042's
@@ -567,7 +568,12 @@ static int __devinit i8042_check_aux(voi
 		    (param && param != 0xfa && param != 0xff))
 			return -1;
 
-		aux_loop_broken = 1;
+/*
+ * If AUX_LOOP completed without error but returned unexpected data
+ * mark it as broken
+ */
+		if (!retval)
+			aux_loop_broken = 1;
 	}
 
 /*
