From: "Brown, Len" <len.brown@intel.com>
Subject: RE: kacpi_notify?
Date: Wed, 12 Jul 2006 17:55:50 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6F7630D@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:25974 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932450AbWGLV6A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2006 17:58:00 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>

Linus,
Does /proc/interrupts show that the acpi interrupt is ticking along
at the same rate as the kacpid_notify build-up?

If you run with  CONFIG_ACPI_THERMAL=n or otherwise nuke
the thermal module, does the interrupt and the kacpid_notify symptom go
away?

thanks,
-Len
