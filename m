From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/2] PM: x86-64 suspend-resume fix
Date: Fri, 20 Feb 2009 23:46:31 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902202345550.19156@localhost.localdomain>
References: <200902152244.47326.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:59235 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbZBUEqm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Feb 2009 23:46:42 -0500
In-reply-to: <200902152244.47326.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiri Slaby <jirislaby@gmail.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>


On Sun, 15 Feb 2009, Rafael J. Wysocki wrote:

> Hi,
> 
> The following two patches clean-up and fix the x86-64 resume code.
> 
> 1/2 is a cleanup, but it is simple enough to be applied now IMO.
> 
> 2/2 is a bug fix based on 1/2, which is 2.6.29 material.
> 
> Please apply them to the suspend branch and push to Linus for 2.6.29 (Ingo
> says he doesn't mind if they go through your tree).

1 & 2 applied to suspend branch.

thanks,
Len Brown, Intel Open Source Technology Center
