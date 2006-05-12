From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPI_ALLOCATE and may sleep warning
Date: Fri, 12 May 2006 11:59:03 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A444DC78@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13881 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751323AbWELS7F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2006 14:59:05 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>
Cc: linux-acpi@vger.kernel.org

That will end up being a lot of code that really ought to be in one
place.

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Brown, Len
> Sent: Friday, May 12, 2006 11:02 AM
> To: Starikovskiy, Alexey Y
> Cc: linux-acpi@vger.kernel.org
> Subject: RE: ACPI_ALLOCATE and may sleep warning
> 
> 
> >Could we do something like this:
> >
> >#define ACPI_ALLOCATE(a)	kmalloc((a),
> (in_atomic())?GFP_ATOMIC:GFP_KERNEL)
> >#define ACPI_ALLOCATE_ZEROED(a)	kzalloc((a),
> (in_atomic())?GFP_ATOMIC:GFP_KERNEL)
> 
> The question is if we allocate with interrupts off
> only on resume, or during normal operation.
> 
> If it is only during resume, then I think we should
> be using the exact same mechanism that we use
> during boot, It must also apply to semaphores,
> not just kmalloc.
> 
> -Len
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
