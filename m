From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Wed, 25 Mar 2009 07:40:05 +0800
Message-ID: <0A882F4D99BBF6449D58E61AAFD7EDD60E5E878A@pdsmsx502.ccr.corp.intel.com>
References: <49C484B7.20100@goop.org>
 <0A882F4D99BBF6449D58E61AAFD7EDD60E5E877B@pdsmsx502.ccr.corp.intel.com>
 <49C88647.8080404@goop.org> <200903241045.19194.bjorn.helgaas@hp.com>
 <49C91832.8090300@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34281 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754516AbZCXXkN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 19:40:13 -0400
In-Reply-To: <49C91832.8090300@goop.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Jeremy Fitzhardinge' <jeremy@goop.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Cihula, Joseph" <joseph.cihula@intel.com>

>From: Jeremy Fitzhardinge [mailto:jeremy@goop.org] 
>Sent: Wednesday, March 25, 2009 1:28 AM
>
>
>>   It looks like suspend becomes a weird hybrid of
>> ACPI and Xen, which makes it harder to reason about future suspend
>> changes.  And all this discussion about 640k-1M and dom0 identity
>> mapping and "there's no special effort to remap it" and whether
>> there are conflicts makes me nervous.  There's no way all those
>> assumptions can be remembered or verified five years down the road.
>>   
>
>Well, I think Kevin was over-complicating things in his own mind.  The 
>upshot is that the normal "running on bare metal" code can do 
>its normal 
>thing, and if we happen to be running under Xen we can make it 
>a no-op.  
>In other words, the acpi developers don't really need to worry 
>about the 
>"running under Xen case", for the most part.

Yes, I'm just trying to think about corner case which is however
not true per Jeremy's expanation. There's nothing to affect bare
metal running. :-)

Thanks
Kevin
