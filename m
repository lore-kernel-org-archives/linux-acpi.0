From: "Brown, Len" <len.brown@intel.com>
Subject: RE: hello
Date: Fri, 28 Apr 2006 13:18:38 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB64E8BD3@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10788 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030457AbWD1RSs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Apr 2006 13:18:48 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Teo <teo.ubuntu@yahoo.com>
Cc: linux-acpi@vger.kernel.org

Teo,
thanks for the photo.

> pci_mmcfg_read()

try "pci=nommconf"

if it works, then, then try the latest kernel from kernel.org
to see if this is specific to ubuntu or generic to Linux.
If specific to ubuntu, looks like the bug you filed there already covers
it.
If generic to Linux file a bug at kernel.org against drivers/pci

thanks,
-Len
