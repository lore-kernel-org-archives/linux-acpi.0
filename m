From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 10/13] Remove acpi_os_create_lock(), acpi_os_delete_lock()
Date: Fri, 2 Jun 2006 15:39:42 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6A171C4@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:22797 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932483AbWFBTjq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2006 15:39:46 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org, adobriyan@gmail.com

Alexey,

This patch does the right thing, but I'm not going to apply it
because it will just create work in terms of a conflict
within dual-licensed ACPICA code that is already being
cleaned up as we speak.

I'm glad you brought this up, because the cleanup
will be even cleaner now:-)

thanks,
-Len

>-----Original Message-----
>From: Moore, Robert 
>Sent: Friday, June 02, 2006 3:35 PM
>To: Andrew Morton
>Cc: Brown, Len; linux-acpi@vger.kernel.org; adobriyan@gmail.com
>Subject: RE: [patch 10/13] Remove acpi_os_create_lock(), 
>acpi_os_delete_lock()
>
>Andrew,
>
>Thanks, you are absolutely correct. We have recently been 
>driving this kind of thing back up into the ACPICA core by 
>allowing the host to define types which are then compiled into 
>ACPICA (ACPI_CPU_FLAGS for example) to simplify the 
>ACPICA-to-host interfaces, and this is another OSL interface 
>we should change to allow this.
>
>Bob
>
>
>> -----Original Message-----
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> owner@vger.kernel.org] On Behalf Of Andrew Morton
>> Sent: Friday, June 02, 2006 12:24 PM
>> To: Moore, Robert
>> Cc: Brown, Len; linux-acpi@vger.kernel.org; adobriyan@gmail.com
>> Subject: Re: [patch 10/13] Remove acpi_os_create_lock(),
>> acpi_os_delete_lock()
>> 
>> On Fri, 2 Jun 2006 12:09:14 -0700
>> "Moore, Robert" <robert.moore@intel.com> wrote:
>> 
>> > This will not always be the case, in fact we are about to 
>expand the use
>> > of the spinlock interfaces.
>> 
>> Sure, but this function is absolutely crackers.  All it does is to
>> dynamically allocate and initialise a spinlock.  But the 
>storage for the
>> pointer-to-spinlock is the same as, or larger than the 
>spinlock itself.
>> 
>> This thing has to die - please kill it before it spreads.  
>The spinlock
>> should be aggregated by value into the containing structure.  Not by
>> reference.
>> 
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
