From: David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH 0/2] net: thunder: Add ACPI support.
Date: Thu,  6 Aug 2015 17:33:08 -0700
Message-ID: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34066 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbbHGAdZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Aug 2015 20:33:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, Robert Richter <rrichter@cavium.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Sunil Goutham <sgoutham@cavium.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, David Daney <david.daney@cavium.com>

From: David Daney <david.daney@cavium.com>

Hook up PHYs, and get MAC address from ACPI for the thunder driver.

The first patch (1/2) rearranges the existing code a little with no
functional change to get ready for the second.  The second (2/2) does
the actual work of adding support to extract the needed information
from the ACPI tables.

David Daney (1):
  net, thunder, bgx: Add support for ACPI binding.

Robert Richter (1):
  net: thunder: Factor out DT specific code in BGX

 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 183 ++++++++++++++++++++--
 1 file changed, 169 insertions(+), 14 deletions(-)

-- 
1.9.1

