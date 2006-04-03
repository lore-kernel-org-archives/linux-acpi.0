From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: acpi_thread_id = acpi_os_get_thread_id()
Date: Mon, 3 Apr 2006 07:35:50 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E04DF3123@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29213 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751545AbWDCOfx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2006 10:35:53 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

HP-UX wanted the new type. It can be defined as necessary for Linux;
However,I can change the default to UINT32 if that's what is used on
most operating systems.

The information as to thread ID can be very useful when debugging multi
threaded issues, and will probably become more important as we encounter
more of these. I would like to keep it around for the time being.

Bob


> -----Original Message-----
> From: Brown, Len
> Sent: Saturday, April 01, 2006 12:14 AM
> To: Moore, Robert
> Cc: linux-acpi@vger.kernel.org
> Subject: acpi_thread_id = acpi_os_get_thread_id()
> 
> Bob,
> with the new type acpi_thread_id, it seems that the thread_id grows
from
> 32-bits
> to 64-bits on a 64-bit mahcine.
> 
> acpi_os_get_thread_id() currently returns task.pid on Linux,
> a 32-bit integer on both 32 and 64-bit machines.
> 
> So if acpi_os_get_thread_id() is called at interrupt level,
> its return value is meaningless.
> 
> Linux doesn't define ACPI_MUTEX_DEBUG, and looks like it never will.
> 
> Is it possible to delete the concept of acpi_os_get_thread_id()?
> I'm wondering at the moment if the right thing isn't to do this:
> 
> #define acpi_os_get_thread_id() (0)
> 
> thanks,
> -Len
