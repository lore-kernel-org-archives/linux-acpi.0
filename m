From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm 4/8] serio: Speed-up resume
Date: Thu, 10 Jul 2008 13:35:35 +0200
Message-ID: <20080710113535.GD15412@elf.ucw.cz>
References: <200807100152.17755.rjw@sisk.pl> <200807100201.56232.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44410 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515AbYGJPDx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jul 2008 11:03:53 -0400
Content-Disposition: inline
In-Reply-To: <200807100201.56232.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Shaohua Li <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@suse.cz

On Thu 2008-07-10 02:01:55, Rafael J. Wysocki wrote:
> From: Shaohua Li <shaohua.li@intel.com>
> Subject: serio: Speed-up resume
> 
> serio_resume will call into psmouse_extensions(). In my test, the
> routine is very slow, it blocks resume about 1 sec. Below patch (move
> resume to kseriod, just like boot time probe) cures the issue in my
> test, and seems no side effect. I'm no familiar with serio driver, so
> please check. 
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> Acked-by: Len Brown <lenb@kernel.org>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Cc: Jiri Kosina <jikos@suse.cz>

ACK from me, but I'm not a serio expert.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
