From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: Re: [PATCH](memory hotplug) Repost remove useless message at boot time from 2.6.18-rc4.
Date: Fri, 25 Aug 2006 20:59:33 +0900
Message-ID: <20060825205423.0778.Y-GOTO@jp.fujitsu.com>
References: <20060810142329.EB03.Y-GOTO@jp.fujitsu.com> <1155643418.4302.1154.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:48583 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751158AbWHYMAK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Aug 2006 08:00:10 -0400
In-Reply-To: <1155643418.4302.1154.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: akpm@osdl.org, "Brown, Len" <len.brown@intel.com>, keith mannthey <kmannth@us.ibm.com>, ACPI-ML <linux-acpi@vger.kernel.org>, Linux Kernel ML <linux-kernel@vger.kernel.org>, Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>


> I sent a patch a while ago that gets rid of the whole namespace walking
> by making acpi_memoryhotplug an acpi device and making use of the .add
> callback function and the acpi_bus_register_driver call.
> 
> I am not sure whether this is possible if you have multiple memory
> devices, though (if not maybe it should be made possible?)...
> 
> Yasunori even tested the patch and sent an Ok:
> http://marc.theaimsgroup.com/?t=114065312400001&r=1&w=2
> 
> If this is acceptable I can rebase the patch on a current kernel.

Hi. Thomas-san.
Did you rebase your patch?

I'm trying to do it now too. 
But, current code (2.6.18-rc4) seems to register handler for
only enable status devices at boot time.
So, notification is -discarded- due to no handler for new memory
device when hot-add event occurs. Hmmm. :-(


Bye.

-- 
Yasunori Goto 


