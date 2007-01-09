From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 0/2] Bay driver bug fixes
Date: Mon, 8 Jan 2007 16:21:01 -0800
Message-ID: <20070108162101.a32772bf.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2002 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbXAIAVU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Jan 2007 19:21:20 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@jikos.cz, akpm@osdl.org

Hi Len,
Here are 2 patches to fix a couple bugs with the bay driver.  The first
addresses the problem that jikos reported with the bay driver failing
at load due to BUG: at lib/kref.c:32 kref_get().  Since the bay driver
is also a platform driver, I found that when it is compiled into the 
kernel (built in) there is a problem with it being simultaneously an
acpi driver as well as a platform driver.  Since it wasn't really useful
for the bay driver to be an acpi driver, I removed that code.  The second
patch addresses the build issue with bay when dock is not built by making
the bay driver depend on the dock driver.  

Thanks,
Kristen

--
