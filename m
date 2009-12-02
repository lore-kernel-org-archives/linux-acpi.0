From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH v1 3/5] ipmi: remove unused PCI probe coded
Date: Wed, 02 Dec 2009 15:36:29 -0600
Message-ID: <4B16DDDD.8030905@acm.org>
References: <20091118000427.14214.14043.stgit@bob.kio>
 <20091118000524.14214.41587.stgit@bob.kio>
 <20091201231841.GA7903@minyard.local>
 <200912021253.00726.bjorn.helgaas@hp.com>
 <E0AA796A7E3F4C4E8F1065D15FE478618CE8B806@EXCH-MBX-4.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:39574 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbZLBVg0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2009 16:36:26 -0500
Received: from wf-rch.minyard.local ([173.57.145.237])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KU100FOTO0UOWRY@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 02 Dec 2009 15:36:30 -0600 (CST)
In-reply-to: <E0AA796A7E3F4C4E8F1065D15FE478618CE8B806@EXCH-MBX-4.vmware.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bela Lubkin <blubkin@vmware.com>
Cc: 'Bjorn Helgaas' <bjorn.helgaas@hp.com>, Zhao Yakui <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Myron Stowe <myron.stowe@hp.com>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, Len Brown <lenb@kernel.org>

Bela Lubkin wrote:
> Bjorn Helgaas wrote:
>
>   
>> The original 5-patch series leaves the PCI base address alone.  That's
>> the same as the old behavior for HP devices, and we verified that it
>> works on an HP DL380G6 by disabling SMBIOS/SMPI/PNP detection.  (We
>> also verified that, as you would expect, it did NOT work if we increment
>> the base address).
>>     
> ...
>   
>> So the question is what to do about non-HP PCI IPMI interfaces.  The
>> pre-b0defcdbd2b7d code increments the base address, but that's been
>> gone for several years.  Since we've had no complaints, and we don't
>> know about any non-HP PCI interfaces, I propose that we just remove
>> that HP-specific adjustment completely, i.e., use this series as-is.
>>     
>
> Much older HP systems had a PCI SMIC interface.  Are you
> sure those haven't been broken somewhere along the way?
>
> (Please don't say "we don't care about things that old".)
>   
Well, I do care, but if it's HP, it will have the same PCI vendor id, so 
it should be the same.  The change that Bjorn proposed won't actually 
change anything in the current kernel, it will just remove some dead 
code.  So I think everything is ok.  If the older HP systems won't work, 
we actually haven't changed anything, but I'll take a patch to fix them.

-corey
