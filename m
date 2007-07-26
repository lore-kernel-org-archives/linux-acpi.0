From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: New ACPI error/warning with Linus' latest GIT
Date: Thu, 26 Jul 2007 23:29:20 +0300
Message-ID: <200707262329.20478.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:37878 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S936040AbXGZU3U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2007 16:29:20 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

This time on a HP Pavillion DV2000 ,

ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62<6>ACPI: PCI Root 
Bridge [PCI0] (0000:00)
ACPI: EC: Handler for query 0x57 is not found!

Seems to be a new warning/error, too noisy debugging again?

Regards,
ismail

-- 
Perfect is the enemy of good
