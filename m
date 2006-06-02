From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [patch 10/13] Remove acpi_os_create_lock(), acpi_os_delete_lock()
Date: Fri, 2 Jun 2006 12:34:41 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4634E2A@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2333 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932197AbWFBTgz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2006 15:36:55 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, adobriyan@gmail.com

Andrew,

Thanks, you are absolutely correct. We have recently been driving this
kind of thing back up into the ACPICA core by allowing the host to
define types which are then compiled into ACPICA (ACPI_CPU_FLAGS for
example) to simplify the ACPICA-to-host interfaces, and this is another
OSL interface we should change to allow this.

Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Andrew Morton
> Sent: Friday, June 02, 2006 12:24 PM
> To: Moore, Robert
> Cc: Brown, Len; linux-acpi@vger.kernel.org; adobriyan@gmail.com
> Subject: Re: [patch 10/13] Remove acpi_os_create_lock(),
> acpi_os_delete_lock()
> 
> On Fri, 2 Jun 2006 12:09:14 -0700
> "Moore, Robert" <robert.moore@intel.com> wrote:
> 
> > This will not always be the case, in fact we are about to expand the
use
> > of the spinlock interfaces.
> 
> Sure, but this function is absolutely crackers.  All it does is to
> dynamically allocate and initialise a spinlock.  But the storage for
the
> pointer-to-spinlock is the same as, or larger than the spinlock
itself.
> 
> This thing has to die - please kill it before it spreads.  The
spinlock
> should be aggregated by value into the containing structure.  Not by
> reference.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
