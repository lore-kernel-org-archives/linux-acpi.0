From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] dell-wmi Switch support and Tablet switch definition
Date: Fri, 19 Jun 2009 15:28:48 -0400
Message-ID: <4A3BE6F0.7090107@seas.upenn.edu>
References: <1245410112-13659-1-git-send-email-rafi@seas.upenn.edu> <20090619140228.GA21354@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:51856 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbZFSTnZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 15:43:25 -0400
In-Reply-To: <20090619140228.GA21354@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Fri, Jun 19, 2009 at 07:15:12AM -0400, Rafi Rubin wrote:
>> Added a bit of missing code needed to handle switch events.
>>
>> Added the definitions for the hinge rotation as seen on the
>> Latitude XT tablet.
> 
> Having thought about this a bit more, I think there's a pretty 
> fundamental problem right now - we don't know whether we're in tablet 
> mode or not when we boot, so can't set the initial state. Software that 
> depends on that may be rather confused as a result...

I agree polling the tablet state would be a good thing.  But that does not mean we should not
support the signals until we are ready to support polling.

If you are suggesting that we should not use an EV_SW because we will eventually poll the hardware
instead of keeping the state in software, then I have no problem with sending keys or other events.

However if you still think keeping the state in software and using EV_SW is a good idea, this code
is independent of the probe code.  And I think the value of having this support is well worth the
potential harm.  After all, it thinks its in non-tablet mode until the signal comes in that its
switching to tablet.  How is this any worse than always thinking its in non-tablet mode?

Rafi
