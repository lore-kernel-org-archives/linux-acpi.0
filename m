From: David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH v2 0/2] net: thunder: Add ACPI support.
Date: Mon, 10 Aug 2015 17:58:35 -0700
Message-ID: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:35915 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932670AbbHKA6s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Aug 2015 20:58:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, Robert Richter <rrichter@cavium.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Sunil Goutham <sgoutham@cavium.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, rafael@kernel.org, David Daney <david.daney@cavium.com>

From: David Daney <david.daney@cavium.com>

Change from v1:  Drop PHY binding part, use fwnode_property* APIs.

The first patch (1/2) rearranges the existing code a little with no
functional change to get ready for the second.  The second (2/2) does
the actual work of adding support to extract the needed information
from the ACPI tables.

David Daney (1):
  net, thunder, bgx: Add support to get MAC address from ACPI.

Robert Richter (1):
  net: thunder: Factor out DT specific code in BGX

 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 134 +++++++++++++++++++---
 1 file changed, 120 insertions(+), 14 deletions(-)

-- 
1.9.1

