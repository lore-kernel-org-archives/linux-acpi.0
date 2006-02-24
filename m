From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: Re: [PATCH] acpi_memoryhotplug.c needs not to walk whole namespace twice to register notify handler
Date: Fri, 24 Feb 2006 14:31:04 +0900
Message-ID: <20060224122247.B225.Y-GOTO@jp.fujitsu.com>
References: <200602230103.15673.trenn@suse.de> <200602230625.58671.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:21157 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750918AbWBXFbw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Feb 2006 00:31:52 -0500
In-Reply-To: <200602230625.58671.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, intel-linux-acpi@linux.intel.com, kamezawa.hiroyu@jp.fujitsu.com, "Yu, Luming" <luming.yu@intel.com>, Kristen Accardi <kristen.c.accardi@intel.com>

Hello.
Thomas-san.

> > This is how it is currently done in memhotplug:
> > Driver_register is invoked. There the HID is searched and device pointer passed
> > if a memory hotplug device is found.
> > Then a second search for the same HID (by walk_namespace) is done in memhotplug
> > and the notify handler is registered for those.

I'd misunderstood for long time. Indeed, I agree it was redundant.
I tested your patch on Tiger4 with memory hotplug emulation.
It works well. ;-) Thanks.

> > BTW: How is this memory hotplugging supposed to work. It only reacts on ACPI notifies, my machine
> > only has "Check" notify events for mem. What kind of hardware do I need to test this and
> > how will the eject request be initiated?

I don't have any real machine yet. Now, our firmware team is making
effort to develop it for our new box.
But, Intel might have real box which can use memory hotplug....

Bye.

-- 
Yasunori Goto 



