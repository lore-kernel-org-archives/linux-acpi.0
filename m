From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 1/3] acpi: dock driver
Date: Fri, 14 Apr 2006 19:17:27 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6300EF2@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12364 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751442AbWDNXRb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Apr 2006 19:17:31 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Accardi, Kristen C" <kristen.c.accardi@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, mochel@linux.intel.com, arjan@linux.intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz, temnota@kmv.ru

 
On Fri, 2006-04-14 at 15:42 -0700, Brown, Len wrote:

>> Re: acpi_os_free()
>> Please call kfree() instead, that wrapper is intended
>> just for the ACPICA core and although it appears symmetric,
>> it really shouldn't be used outside drivers/acpi/*/*.c

> Really?  why is it exported then?  We use this in drivers/pci/hotplug
as
> well, and it is all over the place in drivers/acpi.  Should I be
> modifying the hotplug drivers to not use this call?

yes.

re: why it is exported?
this is just the tip of the ice-berg of things that are exported and
should not be.

thanks,
-Len
