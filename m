From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Add DMI quirk for Intel DP55KG mainboard
Date: Wed, 20 Jan 2010 00:06:49 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001200003520.4265@localhost.localdomain>
References: <20100104162114.GA30113@percival.namespace.at>
 <alpine.LFD.2.00.1001041209300.4012@localhost.localdomain>
 <4B4225B3.8070705@zytor.com> <20100104174558.158cd512@infradead.org>
 <20100106143640.GB13984@srcf.ucam.org>
 <alpine.LFD.2.00.1001061321260.4086@localhost.localdomain>
 <20100106193608.GA21447@srcf.ucam.org>
 <alpine.LFD.2.00.1001061504110.4086@localhost.localdomain>
 <4B45001E.7000404@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:43954 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab0ATFHA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2010 00:07:00 -0500
In-reply-to: <4B45001E.7000404@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Arjan van de Ven <arjan@infradead.org>, Christian Hofstaedtler <ch@zeha.at>, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bruce.w.allan@intel.com, Thomas Gleixner <tglx@linutronix.de>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

> What about using _OSI() with a *blacklist*, i.e. treat _OSI("Unknown
> String") as "new enough", whereas _OSI("Windows 2000") is ignored?

Sound reasoning, but I think that parsing the _OSI strings presented
by the BIOS so that the OS can deving whether it is a Windows XP
box or newer is more complicated than this problem merits.

I recommend that we compare DMI date with 2003 and go from there.
If we find that doesn't work, we can apply additional cleverness.

-Len Brown
Intel Open Source Technology Center

