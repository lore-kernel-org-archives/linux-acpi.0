From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Wed, 25 Mar 2009 07:51:30 +0800
Message-ID: <0A882F4D99BBF6449D58E61AAFD7EDD60E5E878B@pdsmsx502.ccr.corp.intel.com>
References: <49C484B7.20100@goop.org>
 <0A882F4D99BBF6449D58E61AAFD7EDD60E5E877B@pdsmsx502.ccr.corp.intel.com>
 <49C88647.8080404@goop.org> <200903241045.19194.bjorn.helgaas@hp.com>
 <49C91832.8090300@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:25764 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898AbZCXXwr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 19:52:47 -0400
In-Reply-To: <49C91832.8090300@goop.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Jeremy Fitzhardinge' <jeremy@goop.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Cihula, Joseph" <joseph.cihula@intel.com>

>From: Jeremy Fitzhardinge [mailto:jeremy@goop.org] 
>Sent: Wednesday, March 25, 2009 1:28 AM
>
>Bjorn Helgaas wrote:
>> On Tuesday 24 March 2009 01:05:43 am Jeremy Fitzhardinge wrote:
>>   
>>> Tian, Kevin wrote:
>>>     
>>>> OK, then it's safe to avoid that change. I had thought 
>that dom0's 0-1M
>>>> is identity-mapped to machine 0-1M... :-)
>>>>       
>>> No, only the ISA 640k-1M region.
>>>     
>>
>> I'm speaking out of turn here because I don't work on Xen or
>> suspend/resume.  However, I do try to clean up random bits of
>> ACPI, and I have to say this patch looks like a pain in the
>> maintenance department.  Having tests for a specific hypervisor
>> is unpleasant.  We don't want to end up with tests for a collection
>> of hypervisors.
>
>I agree.  If we start to see other hypervisor-specific changes in this 
>area, we'd need to rethink this approach.  But I'm not 
>inclined to add a 
>layer of infrastructure to just deal with Xen. (IOW, abstract 
>only when 
>there's something to abstract.)
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
>
>The two changes this patch makes are, unfortunately, unavoidable:
>
>   1. Turn the final "enter sleep" into a hypercall, so that Xen can do
>      all the low-level context save/restore.  The normal 
>baremetal case
>      is still localized in acpica/hwsleep.c, but it (may) make an
>      excursion into arch code to see if it should do 
>something else, and
>   2. Directly enter the sleep state, rather than save cpu context
>      (which Xen does)
>
>Though, come to think of it, perhaps there's no harm in letting the 
>kernel do its own state-saving.  I'll check.
>

Well, I guess it's doable, since do_suspend_lowlevel also needs
to restore processor context upon S3 failure (function return from
acpi_enter_sleep_state instead of from wakeup stub). Then only
1st change remains which is the minimal change same to what
TXT S3 requires.

Thanks,
Kevin