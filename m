From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Closing lid gives short wakeup from s2ram - APCI related?
Date: Tue, 21 Aug 2007 14:51:05 +0930 (CST)
Message-ID: <200708210521.l7L5L58I027885@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:55211 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750805AbXHUFVI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Aug 2007 01:21:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Hi

I have noticed that whenever I suspend my laptop to RAM and allow it to
suspend before closing the lid, the system appears to briefly wake up when
the lid is finally closed.  By "wake up" I mean that the HDD and CPU fan
spins up for maybe half a second before stopping again.

I do not have acpid configured to do anything (special or otherwise) when
the lid closes (all that happens is the backlight turns off, but that's
external to Linux AFAIK).  When I subsequently bring the system out of
suspend (which happens spontaneously when the lid is opened) I don't
seen anything in the acpid log (or any other log) to indicate what happened
when the lid is closed.  The behaviour is unchanged if acpid is not running.

If I trigger a s2ram and close the lid before the suspend has happened no
"wake up" happens.

Does anyone have any idea as to what might be causing this behaviour?  Is it
ACPI, something hardwired into the system, or something completely separate?
If fixing this prevents the spontaneous return-from-suspend when the lid is
opened (which I'd prefer didn't happen) then I'd be happy with that.

The system is a Fujitsu S7020 running Slackware 11.0.  The effect has been
present since at least 2.6.19 and it possibly predates that.

Regards
  jonathan
