From: Juliusz Chroboczek <jch@pps.jussieu.fr>
Subject: Re: ACPI failures on Dell Latitude E6220
Date: Sat, 24 Dec 2011 17:20:39 +0100
Message-ID: <8739cavt48.fsf@pirx.pps.jussieu.fr>
References: <87r50zzvf6.fsf@pirx.pps.jussieu.fr>
	<87vcp998us.fsf@pirx.pps.jussieu.fr>
	<20111222100849.GA6548@elie.Belkin>
	<7iipl8d9kk.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:53478 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674Ab1LXQUr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Dec 2011 11:20:47 -0500
In-Reply-To: <7iipl8d9kk.fsf@lanthane.pps.jussieu.fr> (Juliusz Chroboczek's
	message of "Thu, 22 Dec 2011 14:23:23 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: linux-acpi@vger.kernel.org

>> Thanks for the update.  Am I right in guessing that 3.1.4-1 is broken,
>> too,

> I'll try, but not right now (I'm in just a wee bit of a rush).

I'm completely unable to reproduce the issue now.

I've tried 3.0.0-3, 3.1.1-1, 3.1.4-1, 3.1.5-1 and 3.2~rc4-1~experimental.1,
and the system enters PC7 and has decent battery life under all of them.

So it looks like the differences in ACPI log messages were a red her-
ring, and that something else changed on my system that was preventing
PC7 from being entered.

 - it's not a BIOS change (I'm still running A03);
 - it's not the iwlwifi firmware (that was last upgraded on 6 November);
 - it could be the X server or the user-space DRI components, which were
   upgraded a number of times since then.

I'm really at a loss; please let me know if you have any ideas.

-- Juliusz
