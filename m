From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Wed, 12 Aug 2009 22:18:13 +0200
Message-ID: <200908122218.13975.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59778 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753904AbZHLUVq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Aug 2009 16:21:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@linux.intel.com>

Hi,

The following patches introduce a mechanism allowing us to execute device
drivers' suspend and resume callbacks asynchronously during system sleep
transitions, such as suspend to RAM.  The idea is explained in the [1/1] patch
message.

Comments welcome.

Thanks,
Rafael

