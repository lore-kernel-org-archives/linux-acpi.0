From: "Brown, Len" <len.brown@intel.com>
Subject: got ACPI power meter device?
Date: Tue, 16 Jul 2013 18:20:30 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C94841182BB6@FMSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34822 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933334Ab3GPSUb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2013 14:20:31 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Anybody have a system that exports an ACPI power meter?

We've had the power meter driver in the kernel since 2.6.31
and I'm wondering how much it is actually used in the field,
and what physical hardware meter device it is enabling.

You'll know you've got it if acpi_power_meter loads
and exports hwmon attributes.

thanks,
-Len

