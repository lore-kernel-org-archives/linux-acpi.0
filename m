From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Date: Wed, 22 Mar 2006 02:15:09 -0500
Message-ID: <E1FLxYj-00011i-Px@approximate.corpus.cam.ac.uk>
References: <3ACA40606221794F80A5670F0AF15F840B417B9D@pdsmsx403>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpauth08.mail.atl.earthlink.net ([209.86.89.68]:33412 "EHLO
	smtpauth08.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1750998AbWCVHPa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 02:15:30 -0500
In-Reply-To: Your message of "Wed, 22 Mar 2006 09:30:04 +0800."
             <3ACA40606221794F80A5670F0AF15F840B417B9D@pdsmsx403>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de, mchehab@infradead.org, Brian Marete <bgmarete@gmail.com>, Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>, jgarzik@pobox.com, Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>, Meelis Roos <mroos@linux.ee>

So the kernel with this UPDT() hung at the 2nd sleep:

                    Method (UPDT, 0, NotSerialized)
                    {
                        If (IGNR)
                        {
                            Decrement (IGNR)
                        }
                        Else
                        {
                            If (H8DR)
                            {
                                If (Acquire (I2CM, 0x0064)) {}
                                Else
                                {
                                    Store (I2RB (Zero, 0x01, 0x04), Local7)
                                    If (Local7)
                                    {
                                        Fatal (0x01, 0x80000003, Local7)
                                    }

                                    Release (I2CM)
                                }
                            }
                        }
                    }

Relative to a working kernel (well, a kernel that I could get to hang
only once, and then all reboots afterwards it never would hang), these
are the extra lines:

                                    Store (I2RB (Zero, 0x01, 0x04), Local7)
                                    If (Local7)
                                    {
                                        Fatal (0x01, 0x80000003, Local7)
                                    }

Since I don't think Fatal() isn't being called, I guess the problem is
in I2RB.  But all those magic numbers in I2RB make me recultant to take
out lines, unless you tell me which changes won't harm the hardware.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
