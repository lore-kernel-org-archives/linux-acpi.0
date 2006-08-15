From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH](memory hotplug) Repost remove useless message at boot
	time from 2.6.18-rc4.
Date: Tue, 15 Aug 2006 14:03:38 +0200
Message-ID: <1155643418.4302.1154.camel@queen.suse.de>
References: <20060804213230.D5D4.Y-GOTO@jp.fujitsu.com>
	 <20060810142329.EB03.Y-GOTO@jp.fujitsu.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:16831 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030279AbWHOL66 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Aug 2006 07:58:58 -0400
In-Reply-To: <20060810142329.EB03.Y-GOTO@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: akpm@osdl.org, "Brown, Len" <len.brown@intel.com>, keith mannthey <kmannth@us.ibm.com>, ACPI-ML <linux-acpi@vger.kernel.org>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>

On Thu, 2006-08-10 at 14:32 +0900, Yasunori Goto wrote:
> Hello.
> 
> I would like to repost this patch to remove noisy useless message at boot
> time from 2.6.18-rc4.
> (I said "-mm doesn't shows this message in previous post", but it was wrong.
>  This messages are shown by -mm too.)
> 
> -------------------------
> This is to remove noisy useless message at boot time from 2.6.18-rc4.
> The message is a ton of
> "ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device"

I sent a patch a while ago that gets rid of the whole namespace walking
by making acpi_memoryhotplug an acpi device and making use of the .add
callback function and the acpi_bus_register_driver call.

I am not sure whether this is possible if you have multiple memory
devices, though (if not maybe it should be made possible?)...

Yasunori even tested the patch and sent an Ok:
http://marc.theaimsgroup.com/?t=114065312400001&r=1&w=2

If this is acceptable I can rebase the patch on a current kernel.

    Thomas

