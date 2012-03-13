From: Boris Ostrovsky <boris.ostrovsky@amd.com>
Subject: [PATCH 0/2] Improve power consumption for off-lined cores
Date: Tue, 13 Mar 2012 19:55:08 +0100
Message-ID: <1331664910-20095-1-git-send-email-boris.ostrovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:34271
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754159Ab2CMS4H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Mar 2012 14:56:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@amd.com>


This patch allows an off-lined core to enter C2 state (if available)
instead of C1. 

It also fixes declaration of power-state to be a signed integer.

-boris

