From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
 them
Date: Sat, 24 Apr 2010 15:49:38 -0500
Message-ID: <1272142178.1839.138.camel@laptop>
References: <1272062884.1594.73.camel@laptop>
	 <20100424160114.GA13867@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:46470 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab0DXUtn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Apr 2010 16:49:43 -0400
In-Reply-To: <20100424160114.GA13867@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On Sat, 2010-04-24 at 17:01 +0100, Matthew Garrett wrote:
> On Fri, Apr 23, 2010 at 05:48:04PM -0500, Jerone Young wrote:
> > This patch fixes that mute keys for X & R & W series Thinkpads. For
> > these Thinkpads in the BIOS if OS exposes itself as "Linux" it will
> > switch the functionality of the mute key to send a mute key press to the
> > OS. These machines will not be getting any bios updates in the future.
> 
> The correct way to handle this, as noted before, is to figure out what 
> Windows does and implement that.

The issue is the way Windows does it is through a userspace daemon.  By
making it OSI=Linux (just as with the Thinkpads currently already in
blacklist.c ..*61 line) the machines just send the OS a key press.

Since newer thinkpads as well as most other OEM machines take this
model. It provides a much better user experience then what it is like
today.

Basically with these machines today you press the mute button:
	- the speakers mute
	- you get no OSD from the OS .. as it has no idea anything has
          happened
	- the headphone jack doesn't mute

			Thanks,
				Jerone
>  


