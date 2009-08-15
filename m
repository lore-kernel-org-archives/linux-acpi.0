From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA Release 20090730 linuxized patches
Date: Fri, 14 Aug 2009 23:33:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908142332450.30537@localhost.localdomain>
References: <1250215084.2987.7.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_t7QS/d0lvxqU7L6QDwhaIw)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:36555 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbZHODda (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2009 23:33:30 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KOE00KTLF7FTCZ4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 14 Aug 2009 22:33:21 -0500 (CDT)
In-reply-to: <1250215084.2987.7.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_t7QS/d0lvxqU7L6QDwhaIw)
Content-type: TEXT/PLAIN; charset=ISO-8859-7
Content-transfer-encoding: 8BIT

On Fri, 14 Aug 2009, Lin Ming wrote:

> Hi, Len
> 
> ACPICA Release 20090730 linuxized patches attached.
> Build&Test on 32&64 bit machines.

please build with CONFIG_DMAR=y

  CC      drivers/pci/dmar.o
drivers/pci/dmar.c: In function ¡dmar_parse_one_dev_scope¢:
drivers/pci/dmar.c:87: error: ¡struct acpi_dmar_pci_path¢ has no member 
named ¡dev¢
drivers/pci/dmar.c:87: error: ¡struct acpi_dmar_pci_path¢ has no member 
named ¡fn¢
drivers/pci/dmar.c:91: error: ¡struct acpi_dmar_pci_path¢ has no member 
named ¡dev¢
drivers/pci/dmar.c:91: error: ¡struct acpi_dmar_pci_path¢ has no member 
named ¡fn¢
drivers/pci/dmar.c:101: error: ¡struct acpi_dmar_pci_path¢ has no member 
named ¡dev¢
drivers/pci/dmar.c:101: error: ¡struct acpi_dmar_pci_path¢ has no member 
named ¡fn¢

--Boundary_(ID_t7QS/d0lvxqU7L6QDwhaIw)--
