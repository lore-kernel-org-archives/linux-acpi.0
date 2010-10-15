From: Corey Minyard <minyard@acm.org>
Subject: Re: [RFC PATCH 1/4] IPMI: Add one interface to get more info of
 low-level IPMI device
Date: Thu, 14 Oct 2010 22:03:37 -0500
Message-ID: <4CB7C489.3050900@acm.org>
References: <1286869630-18695-1-git-send-email-yakui.zhao@intel.com>
 <1286869630-18695-2-git-send-email-yakui.zhao@intel.com>
 <4CB7358F.7040808@acm.org> <1287104855.22388.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:63308 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755977Ab0JODDo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Oct 2010 23:03:44 -0400
Received: from wf-rch.minyard.local ([unknown] [173.57.145.237])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAB00JPN9TZCOW0@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 14 Oct 2010 22:03:35 -0500 (CDT)
In-reply-to: <1287104855.22388.34.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>


On 10/14/2010 08:07 PM, ykzhao wrote:
>
>> The way you are doing it, there is no need for a refcount, since you are
>> making a copy of the data.
>>
>> Is a copy or a pointer better?  A pointer is generally preferred, it
>> keeps from having to either store data on the stack or dynamically
>> allocate it for the copy.  But it's not a huge deal in this case.  A
>> pointer will require you to dynamically allocate the smi_info structure
>> so you can free it separately.  But then only the top-level put routine
>> is required, it can simply free the structure if the refcount is zero.
>>      
> When the pointer mechanism is used, we will have to allocate the
> smi_info structure dynamically. Every time the function of
> ipmi_get_smi_info, it will be allocated dynamically. And if it fails in
> the allocation, we can't return the expected value.
>    
Well, you misunderstand.  You allocate one copy when the SMI info is 
created.  And you return a pointer to that with the refcount 
incremented.  No need to allocate a new one on each call.  Use the 
refcounts to know when to free it.

> But when the copy is used, it will be much simpler.  It is the caller's
> responsibility to prepare the corresponding data structure. They can
> define it on stack. Of course they can also dynamically allocate it.
>
> Can we choose the copy mechanism to make it much simpler?
>    
Sure, I think I already said this :).  Just get rid of the refcount stuff.

-corey
