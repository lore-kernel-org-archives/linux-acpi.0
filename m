From: "Yu, Luming" <luming.yu@intel.com>
Subject: acpi AML method trace support
Date: Tue, 11 Jul 2006 16:40:21 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1CE1CD2@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2100 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750769AbWGKIo7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jul 2006 04:44:59 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Folks,

If you are interested in debugging AML code, selecting a aml method to
trace is useful to track down AML code problem.
I have a patch filed at http://bugzilla.kernel.org/show_bug.cgi?id=6629,
which enable this feature for linux.
You need to echo full aml method path name to /proc/acpi/trace_method.
To use on shot mode, you need to echo -n 0 > /proc/acpi/trace_flag .
To use persistent mode, you need to echo -n 1 > /proc/acpi/trace_flag.

Thanks,
Luming
