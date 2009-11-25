From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Tue, 24 Nov 2009 23:50:07 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911242347030.4058@localhost.localdomain>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:11848 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934500AbZKYEuG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Nov 2009 23:50:06 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KTN00A1IERNW4YA@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 24 Nov 2009 22:50:12 -0600 (CST)
In-reply-to: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Lutomirski <luto@mit.edu>, jerone.young@canonical.com
Cc: linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, 9 Nov 2009, Andrew Lutomirski wrote:

> The ThinkPad X200s, like the X61, requires OSI=Linux for the mute
> button to work.  Without this patch (or the equivalent command-line
> parameter), the mute button does not generate a keystroke and,
> instead, messes up the sound hardware.
> 
> Tested on an X200s.
> 
> Signed-off-by: Andy Lutomirski <luto@mit.edu>

I just applied the analogous T400/T500 patch from
http://bugzilla.kernel.org/show_bug.cgi?id=13934

and I'd apply this one too if it were not malformed.


Jerome,
Perhaps you can post the patches from the canonical list
so we can take care of these "all at once"?

Somebody tell Lenovo (again) that they are being bad.

thanks,
-Len Brown, Intel Open Source Technology Center


