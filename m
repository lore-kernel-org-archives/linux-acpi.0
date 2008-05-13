From: David Wagner <daw@cs.berkeley.edu>
Subject: Dell XPS420 DMI info
Date: Tue, 13 May 2008 16:15:53 -0700 (PDT)
Message-ID: <200805132315.m4DNFrW9023342@taverner.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:56183 "EHLO
	taverner.cs.berkeley.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760731AbYENAPL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 May 2008 20:15:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On booting Linux 2.6.25-14.fc9.x86_64 (a Fedora 9 kernel), I get the
following boot message:

ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000 - efffffff
PCI: Using configuration type 1
ACPI: EC: Look up EC in DSDT
ACPI: BIOS _OSI(Linux) query ignored
ACPI: DMI System Vendor: Dell Inc.
ACPI: DMI Product Name: Dell XPS420                  
ACPI: DMI Product Version: 
ACPI: DMI Board Name: 0TP406
ACPI: DMI BIOS Vendor: Dell Inc.
ACPI: DMI BIOS Date: 01/02/2008
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org

It told me to send this info to linux-acpi@vger.kernel.org, so
that's what I'm doing.  Other info:

# cat /etc/sysconfig/hw-uuid
c2e6d017-9514-4dec-932f-a5ae57e30f8e

(this is the Smolt UID, yes?)  This is on a Dell XPS420 machine.
Let me know if there is any other information I can provide.
