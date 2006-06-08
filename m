From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.17-rc6-mm1 -- acpi_processor-0731 [00] processor_preregister_: Error while parsing _PSD domain information. Assuming no coordination
Date: Thu, 8 Jun 2006 02:27:10 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6AAB19A@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32162 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932525AbWFHG2I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jun 2006 02:28:08 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>
Cc: linux-acpi@vger.kernel.org, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>

This is -mm only (there is no _PSD parsing in Linus' tree)
It is benign.
We'll fix it before 2.6.18.

thanks,
-Len
 
