From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Linux doesn't shutdown (turn off) the computer
Date: Fri, 16 Apr 2010 15:06:17 -0300
Message-ID: <phlm97-dol.ln1@tux.abusar.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50429 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757722Ab0DPSPF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Apr 2010 14:15:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1O2q4F-0008Q0-FL
	for linux-acpi@vger.kernel.org; Fri, 16 Apr 2010 20:15:03 +0200
Received: from 189.62.197.41 ([189.62.197.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 16 Apr 2010 20:15:03 +0200
Received: from fragabr by 189.62.197.41 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 16 Apr 2010 20:15:03 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

	I've been using Linux since 1997 and started with Slackware
3.1 with an AT case.

	Then some time after, I upgraded the system to a ATX case and
ATX power supply of course. Unfortunately Linux never turn the computer
off after shutdown. It *always* stay at the "System halted" screen and
I have to press for 4 seconds the power button for the computer to
turn off.

	With Windows everything works perfectly...

	I tested this Linux system with 3 different motherboards and
the problem remains.

	So, is it a ACPI issue, configuration? What logs or information
do you need to properly debug this?

	Now I'm using Linux 2.6.33.

	Thanks.

	Ps: my question is: what happens after the "System halted"
message? The kernel sends a signal to the motherboard, BIOS, whatever
to shutdown the computer? Maybe something is blocking it? Thanks.

-- 
Linux 2.6.33: Man-Eating Seals of Antiquity


