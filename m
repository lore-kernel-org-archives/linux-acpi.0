From: Alan Stern <stern@rowland.harvard.edu>
Subject: ACPI resume problem: sleeping with interrupts disabled
Date: Mon, 26 Jun 2006 10:44:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606261038010.9506-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56327 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030278AbWFZOoW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Jun 2006 10:44:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

One of my computers running 2.6.17 has a problem with resume-from-disk.  
During the early stages of the resume, when interrupts must remain
disabled, the ACPI code tries to carry out various blocking activities.  
As a result interrupts get enabled and things go wrong.

The problems are in drivers/acpi/osl.c.  acpi_os_acquire_object() does 
memory allocations with GFP_KERNEL and acpi_os_wait_semaphore() does a 
down().

It looks like this problem was already recognized and fixed in 
acpi_os_allocate().  Should the same fix be applied to the other two 
routines?

Alan Stern

