From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: Power-button event after resume from S3
Date: Fri, 7 Apr 2006 10:49:45 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD11906E5@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38986 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932295AbWDGCtv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Apr 2006 22:49:51 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felix Kuehling <fkuehlin@ati.com>, linux-acpi@vger.kernel.org
Cc: Matthew Tippett <mtippett@ati.com>, Chang-Hwa Lee <changl@ati.com>

>Are there plans for a real fix for this problem, either in the 
>kernel or
>in acpid?
>

We need a  patch to handle the wakeup power-button event.
Do you want to hack a patch for this?

Probably, you need to hack acpi_button_notify.
like:

if (acpi_in_suspend)
	don't generate event.

--Luming
