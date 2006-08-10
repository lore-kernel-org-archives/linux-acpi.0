From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 2/2] acpi,backlight: MSI S270 laptop support - driver
Date: Thu, 10 Aug 2006 05:36:08 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB60133D741@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12728 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751421AbWHJJgX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Aug 2006 05:36:23 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Lennart,

Your s270 platform driver needs a different home in the source tree
outside of drivers/acpi/, and the patch that adds it must add an entry
to MAINTAINERS.

lcd brightness platform support should talk to the existing
backlight stuff under sysfs.

wlan and bluetooth indicators/controls need to appear under
generic places under sysfs -- not under platform specific
files under /proc/acpi.

Yes, the existing platform specific drivers such as asus, toshiba, and
ibm
are bad examples.

thanks,
-Len
