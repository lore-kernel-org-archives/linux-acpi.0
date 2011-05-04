From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH 0/3] pstore: fix some errors when erst as the interface
Date: Wed,  4 May 2011 11:06:49 +0800
Message-ID: <1304478412-11843-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2301 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755132Ab1EDDGr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 May 2011 23:06:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, ying.huang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

[PATCH 1/3] fix one type of return value in pstore
[PATCH 2/3] fix pstore filesystem mount/remount issue
[PATCH 3/3] fix potential logic issue in pstore read interface

These patches fix some potential errors for pstore when erst as
the underlying interface. And fix a pstore filesystem mount/remount
issue.
