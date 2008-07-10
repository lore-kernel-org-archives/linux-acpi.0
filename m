From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH -mm 4/8] serio: Speed-up resume
Date: Thu, 10 Jul 2008 11:11:58 -0400
Message-ID: <20080710151158.GA4332@anvil.corenet.prv>
References: <200807100152.17755.rjw@sisk.pl> <200807100201.56232.rjw@sisk.pl> <20080710113535.GD15412@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:17844 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302AbYGJPMF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jul 2008 11:12:05 -0400
Received: by py-out-1112.google.com with SMTP id p76so1858769pyb.10
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jul 2008 08:12:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080710113535.GD15412@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Shaohua Li <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, jikos@suse.cz

On Thu, Jul 10, 2008 at 01:35:35PM +0200, Pavel Machek wrote:
> On Thu 2008-07-10 02:01:55, Rafael J. Wysocki wrote:
> > From: Shaohua Li <shaohua.li@intel.com>
> > Subject: serio: Speed-up resume
> > 
> > serio_resume will call into psmouse_extensions(). In my test, the
> > routine is very slow, it blocks resume about 1 sec. Below patch (move
> > resume to kseriod, just like boot time probe) cures the issue in my
> > test, and seems no side effect. I'm no familiar with serio driver, so
> > please check. 
> > 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > Acked-by: Len Brown <lenb@kernel.org>
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Cc: Jiri Kosina <jikos@suse.cz>
> 
> ACK from me, but I'm not a serio expert.
> 								Pavel

I think the patch makes sense, maybe it will even help with resume in
general when we fail to resume for some reason and then when they reload
drivers after the system is fully up it magically starts workign again.
It is in my 'master' branch from which Andrew is pulling into -mm. I
will let it sit there for a bit though.

-- 
Dmitry
