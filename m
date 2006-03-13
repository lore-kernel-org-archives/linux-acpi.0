From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.16-rc6: known regressions
Date: Mon, 13 Mar 2006 21:05:44 +0100
Message-ID: <20060313200544.GG13973@stusta.de>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751808AbWCMUFs@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Avuton Olrich <avuton@gmail.com>, xfs-masters@oss.sgi.com, linux-xfs@oss.sgi.com, Dave Jones <davej@redhat.com>, len.brown@intel.com, linux-acpi@vger.kernel.org, norsk5@xmission.com, dsp@llnl.gov, bluesmoke-devel@lists.sourceforge.net, gregkh@suse.de, linux-usb-devel@lists.sourceforge.net, pete.chapman@exgate.tek.com, Olaf Hering <olh@suse.de>, paulus@samba.org, anton@samba.org, linuxppc64-dev@ozlabs.org, Tom Seeley <redhat@tomseeley.co.uk>, Jiri Slaby <jirislaby@gmail.com>, laredo@gnu.org, v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com
List-Id: linux-acpi@vger.kernel.org

This email lists some known regressions in 2.6.16-rc6 compared to 2.6.15.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you was declared guilty for a breakage or I'm considering you in any
other way possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : XFS oopses on my box sometimes
References : http://bugzilla.kernel.org/show_bug.cgi?id=6180
Submitter  : Avuton Olrich <avuton@gmail.com>
Status     : unknown


Subject    : 2.6.16-rc5 acpi slab corruption
References : http://lkml.org/lkml/2006/3/1/223
Submitter  : Dave Jones <davej@redhat.com>
Status     : unknown


Subject    : edac slab corruption
References : http://lkml.org/lkml/2006/3/5/14
Submitter  : Dave Jones <davej@redhat.com>
Status     : unknown


Subject    : yet more slab corruption
References : https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=184310
Submitter  : Dave Jones <davej@redhat.com>
Status     : unknown


Subject    : Slab corruption in usbserial when disconnecting device
References : http://lkml.org/lkml/2006/3/8/58
Submitter  : pete.chapman@exgate.tek.com
Status     : unknown


Subject    : 2.6.16-rc5-git14 crash in spin_bug on ppc64
References : http://lkml.org/lkml/2006/3/10/190
Submitter  : Olaf Hering <olh@suse.de>
Status     : unknown


Subject    : Stradis driver udev brekage
References : http://bugzilla.kernel.org/show_bug.cgi?id=6170
             https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181063
             http://lkml.org/lkml/2006/2/18/204
Submitter  : Tom Seeley <redhat@tomseeley.co.uk>
             Dave Jones <davej@redhat.com>
Handled-By : Jiri Slaby <jirislaby@gmail.com>
Status     : unknown


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
