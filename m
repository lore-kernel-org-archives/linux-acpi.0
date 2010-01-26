From: Len Brown <lenb@kernel.org>
Subject: Re: Question about ACPI Video
Date: Mon, 25 Jan 2010 22:24:02 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001252223270.20770@localhost.localdomain>
References: <d292941c1001250145o43dc2785p6cdc7d2ff6d47e76@mail.gmail.com>
 <1264467484.22448.310.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:47607 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab0AZDYQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2010 22:24:16 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWU00J6K443KI26@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Jan 2010 21:24:16 -0600 (CST)
In-reply-to: <1264467484.22448.310.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: luke lin <luke.lin1105@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Luke lin <luke1105@gmail.com>

> > why after level == max_level, it will still need set_level again?
> > is this a bug, or it is necessary.
> > 
> Because setting the backlight to max_level is just to check if _BQC uses
> indexed value. We need to set the backlight back after this is done.

perhaps a good place for a comment?

thanks,
Len Brown, Intel Open Source Technology Center

