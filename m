From: Len Brown <lenb@kernel.org>
Subject: Re: Use of ACPI_FLUSH_CPU_CACHE()
Date: Fri, 19 Dec 2008 05:28:36 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812190524350.11043@localhost.localdomain>
References: <4911F71203A09E4D9981D27F9D8308580D926D5F@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:59303 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbYLSK2m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 05:28:42 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KC400JFXD3Q12K4@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Dec 2008 04:28:38 -0600 (CST)
In-reply-to: <4911F71203A09E4D9981D27F9D8308580D926D5F@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> I noticed that Linux does not define anything for this macro (in aclinux.h)
> 
> #define ACPI_FLUSH_CPU_CACHE()

Confusing?  Yes.
A bug?  No.

aclinux.h is like like this:

#ifdef __KERNEL__
#else                           /* !__KERNEL__ */
#define ACPI_FLUSH_CPU_CACHE()
#endif                          /* __KERNEL__ */

ie. that dummy definition is only used in user-mode simulation on Linux.

The real one is in arch/x86/include/asm/acpi.h:

#define ACPI_FLUSH_CPU_CACHE()  wbinvd()

cheers,
Len Brown, Intel Open Source Technology Center
