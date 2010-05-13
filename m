From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v2 0/2] ACPI, APEI EINJ injection parameters support
Date: Thu, 13 May 2010 10:09:21 +0800
Message-ID: <1273716563-23573-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:51202 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756564Ab0EMCJ1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 May 2010 22:09:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-kernel@vger.kernel.org, ying.huang@intel.com, andi@firstfloor.org, linux-acpi@vger.kernel.org


This patch queue is based on acpi-test.git.

Changelog:

v2:

- Remove uninject support, because it is not implemented in BIOS properly now.
