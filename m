From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 0/2] acpi: _OSI string setup regression fixes
Date: Thu, 09 Dec 2010 16:50:38 +0800
Message-ID: <1291884638.10384.45.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:25330 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754704Ab0LIIqw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Dec 2010 03:46:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>, Lukas Hejtmanek <xhejtman@ics.muni.cz>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Hi, Len

Below 2 patches fix regression reported at,
[Regression] 2.6.37-rc1: Lenovo T61 mute button does not work
https://lkml.org/lkml/2010/11/30/296

[PATCH 1/2] acpi: fix _OSI string setup regression
[PATCH 2/2] acpi: allow to add/remove multiple _OSI strings

Lukas,

I made some changes to patch 1, would you please have a try these 2
patches again?

Thanks,
Lin Ming

