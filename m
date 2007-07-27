From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/2] 2.6.23-rc1: known regressions with patches v2
Date: Fri, 27 Jul 2007 22:53:30 +0200
Message-ID: <46AA5B4A.40500@googlemail.com>
References: <46AA5A28.3090205@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:19788 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937821AbXG0U4U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jul 2007 16:56:20 -0400
Received: by ug-out-1314.google.com with SMTP id j3so770821ugf
        for <linux-acpi@vger.kernel.org>; Fri, 27 Jul 2007 13:56:20 -0700 (PDT)
In-Reply-To: <46AA5A28.3090205@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, v4l-dvb-maintainer@linuxtv.org, Thierry MERLE <thierry.merle@free.fr>, "Dwaine P. Garden" <dwainegarden@rogers.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Adrian Bunk <bunk@stusta.de>, Christoph Lameter <clameter@sgi.com>, Pekka Enberg <penberg@cs.helsinki.fi>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Mikael Pettersson <mikpe@it.uu.se>, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Mel Gorman <mel@skynet.ie>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Simon Arlott <simon@fire.lp0.eu>, linux-usb-devel@lists.sourceforge.net, Alan Stern <stern@rowlan>

Hi all,

Here is a list of some known regressions in 2.6.23-rc1
with patches available.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

List of Aces

Name                    Regressions fixed since 21-Jun-2007
Adrian Bunk                            6
Andi Kleen                             4
Andrew Morton                          4
Linus Torvalds                         4
Al Viro                                3
Jens Axboe                             3
Tejun Heo                              3
David Woodhouse                        2
Hugh Dickins                           2



Media

Subject         : usbvision: don't return an uninitialized value
References      : http://lkml.org/lkml/2007/7/23/65
Last known good : ?
Submitter       : Adrian Bunk <bunk@stusta.de>
Caused-By       : ?
Handled-By      : Adrian Bunk <bunk@stusta.de>
Patch           : http://lkml.org/lkml/2007/7/23/65
Status          : patch available



Memory management

Subject         : [bug] SLUB & freeing locks
References      : http://lkml.org/lkml/2007/7/26/90
Last known good : ?
Submitter       : Ingo Molnar <mingo@elte.hu>
Caused-By       : ?
Handled-By      : Peter Zijlstra <peterz@infradead.org>
Patch           : http://lkml.org/lkml/2007/7/26/97
Status          : patch available



Power Management

Subject         : ACPI-related oops on x86_64
References      : http://lkml.org/lkml/2007/7/23/111
Last known good : ?
Submitter       : Mel Gorman <mel@skynet.ie>
Caused-By       : ?
Handled-By      : Len Brown <lenb@kernel.org>
Patch           : http://lkml.org/lkml/2007/7/23/300
Status          : patch available

Subject         : 2.6.23-rc1 broke APM
References      : http://lkml.org/lkml/2007/7/23/169
Last known good : ?
Submitter       : Mikael Pettersson <mikpe@it.uu.se>
Caused-By       : ?
Handled-By      : H. Peter Anvin <hpa@zytor.com>
Patch           : http://lkml.org/lkml/2007/7/23/489
Status          : patch available



SYSFS

Subject         : sysfs/udev broken in 2.6.23-rc1
References      : http://lkml.org/lkml/2007/7/24/276
Last known good : ?
Submitter       : Simon Arlott <simon@fire.lp0.eu>
Caused-By       : ?
Handled-By      : Kay Sievers <kay.sievers@vrfy.org>
                  Cornelia Huck <cornelia.huck@de.ibm.com>
Patch           : http://lkml.org/lkml/2007/7/25/83
Status          : patch available



USB

Subject         : BUG: sleeping function called from invalid context at drivers/usb/core/urb.c:524,in_atomic():1, irqs_disabled():0
References      : http://lkml.org/lkml/2007/7/23/400
Last known good : ?
Submitter       : Jeremy Fitzhardinge <jeremy@goop.org>
Caused-By       : ?
Handled-By      : Oliver Neukum <oliver@neukum.org>
Patch           : http://lkml.org/lkml/2007/7/24/203
Status          : patch available



Regards,
Michal

--
LOG
http://www.stardust.webpages.pl/log/
