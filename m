From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ACPI if power button pressed 1x it creates the same ACPI event twice
Date: Wed, 11 Feb 2015 01:37:32 +0100
Message-ID: <2062077.TXpRYWcx5S@vostro.rjw.lan>
References: <618666178.20150113173510@eikelenboom.it> <13866742.20150119142155@eikelenboom.it> <1891343962.20150210234617@eikelenboom.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65354 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750808AbbBKAO3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2015 19:14:29 -0500
In-Reply-To: <1891343962.20150210234617@eikelenboom.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sander Eikelenboom <linux@eikelenboom.it>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, February 10, 2015 11:46:17 PM Sander Eikelenboom wrote:

[cut]

> Hi Rafael / Len,
> 
> Unfortunately haven't heard anything back .. and with 3.19-rc6 it seems 
> miraculously fixed, i receive only one event on a powerbutton press.
> 
> However with 3.19.0 (final) .. it was back again .. 1 press .. 2 events.
> 
> So i bisected ... but i came out on the netlink commit below. Now seems acpid to 
> be using input layer and netlink if the deprecated /proc/apci/events is not compiled in (which 
> isn't at present) according to [1]. 
> 
> But how the fsck this relates to one another... the only thing i can imagine is 
> that i have to take that text literal: It uses both input layer and netlink 
> simultaneously and will receive an event via both of those ways which slightly 
> differ in naming but have the same origin ?

That's unlikely.

I'm not sure what the problem is ATM and I suppose it would require some serious
debugging, so I'd recomment filing an ACPI bug at bugzilla.kernel.org and adding
this information to it.  That increases the chances that someone will take care
of it sooner that I can.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
