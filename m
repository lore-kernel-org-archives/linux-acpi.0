From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH RFT] fujitsu-laptop: Use RFKILL support bitmask from firmware
Date: Mon, 19 Jan 2009 09:40:35 +1030 (CST)
Message-ID: <200901182310.n0INAZxp017967@mercury.physics.adelaide.edu.au>
References: <20090118015303.DF36D10077@gold.linx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:42386 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752834AbZARXLR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Jan 2009 18:11:17 -0500
In-Reply-To: <20090118015303.DF36D10077@gold.linx.net> from "Tony Vroon" at Jan 18, 2009 01:53:03 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Vroon <tony@linx.net>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Stephen Gildea <stepheng+linux@gildea.com>, Peter Gruber <nokos@gmx.net>, Julian Brown <jules@panic.cs-bristol.org.uk>, linux-acpi@vger.kernel.org

Hi Tony

> Up until now, we polled the rfkill status for every incoming FUJ02E3 ACPI event. 
> It turns out that the firmware has a bitmask which indicates what rfkill-related 
> state it can report.
> The rfkill_supported bitmask is now used to avoid polling for rfkill at all in 
> the notification handler if there is no support. Also, it is used in the platform 
> device callbacks. As before we register all callbacks and report "unknown" if the 
> firmware does not give us status updates for that particular bit.
> 
> This was fed through checkpatch.pl and tested on the S6420 platform.
> Jonathan, your platform is of particular importance as you are the only tester 
> on a platform with no S000 function in the DSDT. Please confirm you still get a 
> unknown status in the platform files. With debugging on full, you should see the 
> 0x1000 0x4 0x0 0x0 call disappear from your trace entirely.

I'll check this as soon as I can.  I'm at Linux.conf.au this week though so
I'm not sure I'll be able to.  We'll see.

What kernel is the patch against?

Regards
  jonathan
