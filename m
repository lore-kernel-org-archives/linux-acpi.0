From: "Yu, Luming" <luming.yu@intel.com>
Subject: ACPI FADT reset reg patch
Date: Tue, 11 Jul 2006 15:42:37 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1CE1C33@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14192 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S965255AbWGKHnD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jul 2006 03:43:03 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lcm@us.ibm.com
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

Chris,

I found a ACPI-FADT-reset-reg patch that fixed S3 reset bug
http://bugzilla.kernel.org/show_bug.cgi?id=6814.
So, Len want to merge your patch into upstream. Could you signed-off
this patch?
http://oss.oracle.com/projects/rhel4kernels/src/mainline/current/SOURCES
/linux-2.6.9-acpi-reset-mechanism.patch 

Cheers
Luming
