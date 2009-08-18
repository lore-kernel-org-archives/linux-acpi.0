From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 0/2] ACPI 4.0 power meter
Date: Tue, 18 Aug 2009 16:47:57 -0700
Message-ID: <20090818234757.2004.88017.stgit@elm3a70.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:57917 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbZHRXha (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Aug 2009 19:37:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Darrick J. Wong" <djwong@us.ibm.com>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Pavel Machek <pavel@ucw.cz>

Hi all,

This is a two-part patchset.  The first patch extends the hwmon sysfs interface
to include power capping features and extra data about the accuracy and
internal operation of the power meter.  The second patch implements a hwmon
driver for ACPI 4.0 compliant power meters that uses the expanded sysfs
interface.  I don't have an example DSDT from any actual piece of hardware, but
I can send some sample ASL code that I've been using to outfit kvm with a power
meter if anyone requests it.

This latest revision updates the driver itself to send sysfs poll notifications
upon receipt of ACPI events and updates the sysfs hwmon documentation to
reflect that.

--D
