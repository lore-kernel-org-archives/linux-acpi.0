From: Len Brown <lenb@kernel.org>
Subject: Re: Wrong commit in the ACPI release branch
Date: Mon, 13 Dec 2010 15:11:20 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012131507120.16730@x980>
References: <201012112329.35080.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:55217 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab0LMULm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Dec 2010 15:11:42 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LDD00K1CUR1Q2W3@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 13 Dec 2010 14:11:32 -0600 (CST)
In-reply-to: <201012112329.35080.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jan Beulich <jbeulich@novell.com>

On Sat, 11 Dec 2010, Rafael J. Wysocki wrote:

> http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commit;h=091aad6af4ab29af693ced5d6970ceee9d5981c8
> 
> (ACPI: eliminate unused variable warning for !ACPI_SLEEP)
> is actually wrong, because it's going to break compilation for
> (!CONFIG_PM_SLEEP && CONFIG_PM_RUNTIME).

That's funny, that config builds for me.
It got through my 399 kernel build test, as well as linux-next.

If you have a .config that breaks, please send it to me.

> I haven't seen it before, let alone acking it or something like this, so I wonder
> why it's being pushed directly to Linus?

it fixes an unused variable warning if !CONFG_ACPI_SLEEP, per the commit 
message.

thanks,
Len Brown, Intel Open Source Technology Center

