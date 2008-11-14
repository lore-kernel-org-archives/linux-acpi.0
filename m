From: "Moore, Robert" <robert.moore@intel.com>
Subject: Use of ACPI_FLUSH_CPU_CACHE()
Date: Fri, 14 Nov 2008 12:15:24 -0800
Message-ID: <4911F71203A09E4D9981D27F9D8308580D926D5F@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36890 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560AbYKNUP2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Nov 2008 15:15:28 -0500
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

I noticed that Linux does not define anything for this macro (in aclinux.h)

#define ACPI_FLUSH_CPU_CACHE()

 
A more typical implementation is:

#define ACPI_FLUSH_CPU_CACHE() Wbinvd()

 
This macro is used just before sleeping. Specifically, just before writing SLP_TYP and SLP_EN in AcpiEnterSleepState, when the cache should be flushed.

It seems to me that this is a bug.

Bob

 

 

