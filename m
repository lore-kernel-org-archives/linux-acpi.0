From: Len Brown <lenb@kernel.org>
Subject: Re: a question about lid input device
Date: Tue, 28 Sep 2010 21:12:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009282109520.32026@localhost.localdomain>
References: <1276412011.19052.19294.camel@rzhang1-desktop>
 <20100614020127.GA30773@khazad-dum.debian.net>
 <8005.1278515660@foxharp.boston.ma.us>
 <20100707162511.GA25178@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:64854 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab0I2BMY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 21:12:24 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H001JKI0CKE87@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 20:12:15 -0500 (CDT)
In-reply-to: <20100707162511.GA25178@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paul Fox <pgf@foxharp.boston.ma.us>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> > the lid:  is /proc/acpi/button/lid/LID/state going away?

> Yes, according to feature-removal.txt ACPI procfs interface shoudl have
> been gone back in 2008.

Note that /proc/acpi/button/lid/*/state is not reliable
on a measurable portion of systems.

We suspect that other operating systems do not use it,
and thus when Linux tries to use it, sometimes we get burnt.

thanks,
-Len Brown, Intel Open Source Technology Center
