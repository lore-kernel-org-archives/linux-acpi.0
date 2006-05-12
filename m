From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPI_ALLOCATE and may sleep warning
Date: Fri, 12 May 2006 14:02:00 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB66D5B81@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38960 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932106AbWELSCF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2006 14:02:05 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>
Cc: linux-acpi@vger.kernel.org


>Could we do something like this:
>
>#define ACPI_ALLOCATE(a)	kmalloc((a),
(in_atomic())?GFP_ATOMIC:GFP_KERNEL)
>#define ACPI_ALLOCATE_ZEROED(a)	kzalloc((a),
(in_atomic())?GFP_ATOMIC:GFP_KERNEL)

The question is if we allocate with interrupts off
only on resume, or during normal operation.

If it is only during resume, then I think we should
be using the exact same mechanism that we use
during boot, It must also apply to semaphores,
not just kmalloc.

-Len
