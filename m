From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPI for Kernel 2.6.16
Date: Sun, 2 Apr 2006 00:01:04 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6123DE0@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41504 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750786AbWDBFBI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Apr 2006 00:01:08 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: M ROBERT Bertrand <bertrand.robert@akseo.net>, linux-acpi@vger.kernel.org


>Hello, I would like to know when would be available the patch 
>ACPI for the 
>version 2.6.16.1 of kernel GNU / LINUX?
>Can the patch for the version 2.6.16 RC1 work on my version?
>I thank you beforehand.

2.6.16 is newer than 2.6.16 RC1, and probably includes parts
of the patch for rc1.

The latest patch is against 2.6.16, which should work against
2.6.16.*:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.16/

I should announce to the list when I update it and what is in it,
but I haven't been consistent about that...

There is actually a naming issue here.
the current 2.6.16 patch is really against the top of tree (ie. Linus git as
of less than 12 hours ago).  Unfortunately, Linus doesn't udpate the Makefile
after he freezes a release (such as 2.6.16), so there is a period between
then and, say 2.6.17-rc1 where the patch looks like it is against stock 2.6.16,
but may depend on the chnages that went into the tree since then.

cheers,
-Len
