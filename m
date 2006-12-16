From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 0/2] more patches for removable drive bay
Date: Sat, 16 Dec 2006 14:40:42 -0800
Message-ID: <20061216144042.a994bf91.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34787 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422708AbWLPWky (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Dec 2006 17:40:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Len,
Here's a set of patches for changing the removable drive bay driver
(drivers/acpi/bay) from using the old proc interface to using a sysfs
interface instead.  I made the bay driver a platform driver, and 
so it's entries will now be located in /sys/devices/platform/bay.X.
There are still 2 entries - one for checking whether the bay is
present (present) that is read only, and one that is write only for
ejecting the bay (eject).  Let me know if you would prefer me to fold
these into the original bay driver patch.

Thanks,
Kristen
--
