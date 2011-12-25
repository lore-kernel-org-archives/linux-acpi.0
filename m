From: Juliusz Chroboczek <jch@pps.jussieu.fr>
Subject: Re: ACPI failures on Dell Latitude E6220
Date: Sun, 25 Dec 2011 17:55:37 +0100
Message-ID: <7iwr9k616e.fsf@lanthane.pps.jussieu.fr>
References: <87r50zzvf6.fsf@pirx.pps.jussieu.fr>
	<87vcp998us.fsf@pirx.pps.jussieu.fr>
	<20111222100849.GA6548@elie.Belkin>
	<7iipl8d9kk.fsf@lanthane.pps.jussieu.fr>
	<8739cavt48.fsf@pirx.pps.jussieu.fr>
	<20111224210300.GI25883@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from shiva.jussieu.fr ([134.157.0.129]:49900 "EHLO shiva.jussieu.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486Ab1LYQ4G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Dec 2011 11:56:06 -0500
In-Reply-To: <20111224210300.GI25883@elie.Belkin> (Jonathan Nieder's message
	of "Sat, 24 Dec 2011 15:03:00 -0600")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: linux-acpi@vger.kernel.org

>> I've tried 3.0.0-3, 3.1.1-1, 3.1.4-1, 3.1.5-1 and 3.2~rc4-1~experimental.1,
>> and the system enters PC7 and has decent battery life under all of them.

> What's weird is how gradually it got fixed on your system. :)  First
> v3.1.5 was fixed and 3.2-rc4 not fixed, and then everything fixed.

No mystery there.  I ran apt-get upgrade, removed 3.2-rc4, then switched
to the 3.1.5 kernel.  I never tested 3.2-rc4 after the upgrade.

(Note by the way that it's actually looking more complex than that -- it
looks like there are three levels of power consumption, the inital very
high one, a medium one, and the low one that I'm enjoying right now.
I believe that I can reproduce the medium one on the older kernels, but
I'm not 100% positive about it -- I'd need to do some more precise
measurements.  The only thing that I'm 100% positive about is that the
CPU is reliably entering PC7 under all kernels now.)

> Would you still be interested in tracking the ACPI method parse/execution
> failures?

I'll be glad to help if I can do that without having to understand too
much about ACPI.

-- Juliusz
