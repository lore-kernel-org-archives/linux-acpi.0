From: Chen Gong <gong.chen@linux.intel.com>
Subject: (unknown)
Date: Wed, 15 Dec 2010 18:18:13 +0800
Message-ID: <1292408294-30584-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:8156 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266Ab0LOKPR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Dec 2010 05:15:17 -0500
Received: from gchen by gchen-debian.bj.intel.com with local (Exim 4.69)
	(envelope-from <gong.chen@linux.intel.com>)
	id 1PSoR7-0007y3-1D
	for linux-acpi@vger.kernel.org; Wed, 15 Dec 2010 18:18:17 +0800
Subject: 
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

[PATCH] eliminate the usage of printk_ratelimit

It is a simple printk limit patch based on latest acpi-test tree
