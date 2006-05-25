From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.17-rc4-mm3 - kernel panic
Date: Thu, 25 May 2006 14:55:37 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB68F03DB@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41838 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030339AbWEYS4E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 May 2006 14:56:04 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Accardi, Kristen C" <kristen.c.accardi@intel.com>
Cc: Andreas Saur <saur@acmelabs.de>, linux-acpi@vger.kernel.org, pavel@suse.cz, linux-kernel@vger.kernel.org

>the possibility that the acpiphp driver may enter it's 
>module_init before the dock driver has completed it's init?

Would there be a problem if the init for acpiphp ran
before the init for dock started?

(no, I don't think that use of acpi_walk_namespace
 would/could have any effect on the order)

I don't know if we have tight controls on module load order.
IIR it depends on the link order in the makefiles for
static modules, and the init scripts for loadable modules.

-Len
