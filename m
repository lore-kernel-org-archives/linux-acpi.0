From: Falempe Jocelyn <jocelyn.falempe@motorola.com>
Subject: Re: New feature proposal "quickwakeup"
Date: Fri, 06 Nov 2009 18:42:21 +0100
Message-ID: <1257529341.2528.21.camel@xhp836-11>
References: <1257523241.1318.367.camel@xhp836-11>
	 <20091106170321.GA24312@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail153.messagelabs.com ([216.82.253.51]:32994 "EHLO
	mail153.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758787AbZKFRmy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Nov 2009 12:42:54 -0500
In-Reply-To: <20091106170321.GA24312@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-omap@vger.kernel.org

On Fri, 2009-11-06 at 17:03 +0000, Matthew Garrett wrote:
> Hmm. This is an interesting approach. Just to understand the usecase 
> better, though - my understanding is that Nokia's approach on Omap-based 
> devices has been to treat "suspend" as a runtime state, without actually 
> performing a systemwide transition. What are the constraints that make 
> shifting into a different hardware state more efficient for you?
> 
In fact we are doing "retention" in idle and with the suspend path. It's
specific to Android, with the global suspend and wakelock framework.
When all wakelocks are released (ie screen is black, no running app),
the phone goes to suspend, which freeze userspace and also suspend the
device driver. This way you can choose the wakeup sources, and stay in
suspend during a long time (a few hours). Without this, you have to
track down all user space app that wakeup the phone, and it is hard to
sleep more than a few second.
The drawback is that when you want to wakeup, it takes a lot of time to
unfreeze the userspace, and resume all the device driver. This is what
this feature address (for low-level wakeup only).
But as this patch is not Android specific, I think other platforms may
use it too.

Best regards,

Jocelyn
