From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Fuijtsu Lifebook RFKILL support
Date: Thu, 11 Dec 2008 11:50:30 +1030 (CST)
Message-ID: <200812110120.mBB1KU9u027511@turbo.physics.adelaide.edu.au>
References: <1228957506.4045.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:43066 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752260AbYLKBUo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Dec 2008 20:20:44 -0500
In-Reply-To: <1228957506.4045.11.camel@localhost> from "Tony Vroon" at Dec 11, 2008 01:05:06 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony@linx.net
Cc: Ivo van Doorn <ivdoorn@gmail.com>, linux-acpi@vger.kernel.org, jwoithe@physics.adelaide.edu.au

Hi Tony

> There is preliminary code ready to implement RFKILL support on Fujitsu
> laptops. Unfortunately, I can't see how to express this specific switch
> type within the existing framework.
> The laptop has one "big" kill switch that kills everything,
> WLAN/Bluetooth/3G, you name it. I have no means to turn individual
> radios on or off, all I'll get is a big notifier (from which I can fire
> up a query to see whether the kill switch state got changed).

Do the laptops in question allow you to control each radio individually or
is it just a single global kill switch?

> Jonathan, if you have DSDTs for machines other then a Lifebook S6410,
> S6420 or E8410 could you please e-mail these to me. I would like to see
> whether the callbacks I'm using are present.

The only DSDT I have access to is the one from my box - an S7020.  This has
a hardware rfkill switch which AFAIK doesn't have a software interface. 
There are a few owners of more recent Fujitsu laptops on the list though;
perhaps they can help out (although at first glance they may not have any
models additional to those you've already got).

Despite this I'll get a DSDT for the S7020 for you in the next few days if
you like.

Regards
  jonathan
