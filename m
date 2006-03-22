From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Wed, 22 Mar 2006 02:00:05 -0500
Message-ID: <E1FLxK9-000243-Cc@approximate.corpus.cam.ac.uk>
References: <3ACA40606221794F80A5670F0AF15F840B417BB4@pdsmsx403>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:45538 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1751001AbWCVHAc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 02:00:32 -0500
In-Reply-To: Your message of "Wed, 22 Mar 2006 09:34:53 +0800."
             <3ACA40606221794F80A5670F0AF15F840B417BB4@pdsmsx403>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, Meelis Roos <mroos@linux.ee>

I tried the following kernels (all with only THM0):

1. No other changes: It hangs, as before and as expected.

2. Commented out a large chunk of the UPDT() method:

diff -r ac2b38909dfa -r c431c477d3b6 dsdt/600x.dsl
--- a/dsdt/600x.dsl	Tue Mar 21 17:12:47 2006 -0500
+++ b/dsdt/600x.dsl	Wed Mar 22 00:22:21 2006 -0500
@@ -4132,19 +4132,6 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                                 If (Acquire (I2CM, 0x0064)) {}
                                 Else
                                 {
-                                    Store (I2RB (Zero, 0x01, 0x04), Local7)
-                                    If (Local7)
-                                    {
-                                        Fatal (0x01, 0x80000003, Local7)
-                                    }
-                                    Else
-                                    {
-                                        Store (HBS0, TMP0)
-                                        Store (HBS2, TMP2)
-                                        Store (HBS6, TMP6)
-                                        Store (HBS7, TMP7)
-                                    }
-
                                     Release (I2CM)
                                 }
                             }

So now it just grabs and releases the I2CM lock.  

This kernel hung on the first sleep, but I couldn't reproduce that
behavior.  I tried two more boots, and each time it never hung.  I even
thought it might depend on the result of previous boots, so I tried
kernel #1 again and got the same hang, and then tried #2.  But it still
wouldn't hang.  So I went back through the serial console logs to check
whether I was hallucinating, and I was not.  This kernel had indeed hung
on the first sleep, but only the first time I booted it.

So I'm going to assume that it's okay, and that if it isn't okay, it's
because of another, more intermitten bug.

3. Commented out EC0.UPDT() call in THM0._THM, and this kernel was fine,
   which is how it behaved a couple days ago, and is what I expected.

I'm about to try a smaller change (continuing the bisect):

diff -r ac2b38909dfa -r f10a309b8385 dsdt/600x.dsl
--- a/dsdt/600x.dsl	Tue Mar 21 17:12:47 2006 -0500
+++ b/dsdt/600x.dsl	Wed Mar 22 01:44:12 2006 -0500
@@ -4137,13 +4137,6 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                                     {
                                         Fatal (0x01, 0x80000003, Local7)
                                     }
-                                    Else
-                                    {
-                                        Store (HBS0, TMP0)
-                                        Store (HBS2, TMP2)
-                                        Store (HBS6, TMP6)
-                                        Store (HBS7, TMP7)
-                                    }
 
                                     Release (I2CM)
                                 }


After that bisection there's not much more to change in UPDT().
However, I can drill down into I2RB() because of this line in UPDT():

    Store (I2RB (Zero, 0x01, 0x04), Local7)

But I have no idea what's safe to experiment with in I2RB():

                    Method (I2RB, 3, NotSerialized)
                    {
                        Store (Arg0, HCSL)
                        Store (ShiftLeft (Arg1, 0x01), HMAD)
                        Store (Arg2, HMCM)
                        Store (0x0B, HMPR)
                        Return (CHKS ())
                    }


All those lines look like tricky hardware manipulations.

By the way, which debug_{level,layer} settings will show the lines of
the human-readable DSDT as they are executed?

-Sanjoy
