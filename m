From: "Brown, Len" <len.brown@intel.com>
Subject: acpi_thread_id = acpi_os_get_thread_id()
Date: Sat, 1 Apr 2006 03:13:37 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6123D0A@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:4493 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751461AbWDAINl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Apr 2006 03:13:41 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

Bob,
with the new type acpi_thread_id, it seems that the thread_id grows from
32-bits
to 64-bits on a 64-bit mahcine.

acpi_os_get_thread_id() currently returns task.pid on Linux,
a 32-bit integer on both 32 and 64-bit machines.

So if acpi_os_get_thread_id() is called at interrupt level,
its return value is meaningless.

Linux doesn't define ACPI_MUTEX_DEBUG, and looks like it never will.

Is it possible to delete the concept of acpi_os_get_thread_id()?
I'm wondering at the moment if the right thing isn't to do this:

#define acpi_os_get_thread_id() (0)

thanks,
-Len
