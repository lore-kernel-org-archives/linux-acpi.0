From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: question on what is ejectable?
Date: Wed, 08 Mar 2006 12:55:31 -0800
Message-ID: <1141851331.32163.26.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:14566 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932472AbWCHUt3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Mar 2006 15:49:29 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: pcihpd-discuss@lists.sourceforge.net

I notice in the acpi_bus_get_flags() function ejectable is defined as
anything that has either _EJ0 or _EJD.  However, the acpi pci hotplug
driver defines an ejectable slot as being one which must have (among
other things) _EJ0.  Is it legitimate to change the definition of an
ejectable slot to be one that has either _EJ0 or _EJD (in addition to
the other requirements for pci hotplug slots).

Kristen

