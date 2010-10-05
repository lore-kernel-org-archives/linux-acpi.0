From: Len Brown <lenb@kernel.org>
Subject: Re: Toshiba C650-194 ACPI bug - regression
Date: Tue, 05 Oct 2010 00:46:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010050041000.23093@localhost.localdomain>
References: <AANLkTin3mtDm9x=8E_b_0FDWdwzbU570x1Ok-btMBPiF@mail.gmail.com>
 <AANLkTi=j75zW-8NFtt8w-z8zQrL7Y_esQD6iLEcCyP00@mail.gmail.com>
 <alpine.LFD.2.00.1010012243430.2293@localhost.localdomain>
 <AANLkTi=Jn7kRpDvE4YUgLZe1yxBCZdcFYo0oUpov+PXx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:63358 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062Ab0JEErN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Oct 2010 00:47:13 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9S00C02VYCWCB1@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 04 Oct 2010 23:47:08 -0500 (CDT)
In-reply-to: <AANLkTi=Jn7kRpDvE4YUgLZe1yxBCZdcFYo0oUpov+PXx@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Allan Kelly <allankelly@gmail.com>
Cc: linux-acpi@vger.kernel.org


> BTW, what is going on here? Is there a thread where this is explained?

https://bugzilla.kernel.org/show_bug.cgi?id=14679

> Seems the BIOS deliberately alters the DSDT after initialisation. Do
> we know why? Does it do it for Win OSs?

We have no idea what the Toshiba BIOS engineers are thinking
and if their actions are deliberate or not.

If the platform has a Windows sticker on it, then it passed
some kind of Windows Compatible Test.

It is possible to read the tables back in Windows, and they
are not garbled -- so we assume that Windows makes a private
copy of them on this platform, and perhaps all platforms.

cheers,
-Len
