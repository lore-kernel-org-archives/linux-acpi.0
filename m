From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.17-mm2 -- Slab corruption, plus invalid opcode: 0000 [#1] -- 4K_STACKS PREEMPT -- last sysfs file: /block/md0/dev
Date: Sun, 25 Jun 2006 00:32:05 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6D35512@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:47953 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751382AbWFYEcN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Jun 2006 00:32:13 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

 
>> acpi_processor-0758 [86] processor_preregister_: Error while parsing
>> _PSD domain information. Assuming no coordination
>
>Is that ACPI message new behaviour?

Yes, where new is in the last couple of months.
You can ignore the message -- it is going away.

-Len
