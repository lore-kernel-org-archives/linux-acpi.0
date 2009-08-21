From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 0/3] acpi: improvements for Documentation/thermal/sysfs-api.txt
Date: Fri, 21 Aug 2009 10:54:11 +0200
Message-ID: <200908211054.11922.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpm-eml105.kpnxchange.com ([195.121.3.9]:61590 "EHLO
	CPSMTPM-EML105.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754973AbZHUIyM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Aug 2009 04:54:12 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sujith Thomas <sujith.thomas@intel.com>, Zhang Rui <rui.zhang@intel.com>

Here's three patches for your consideration:
1/3: reformat for improved readability
2/3: document passive attribute for thermal zones
3/3: move to acpi directory

The first patch mainly reduces the width of the text to make it fit better 
in normal windows, but also has a number of consistency improvements.

The second patch is the only one that really changes content. It documents 
an attribute that is currently missing in the document.
Note that I've not checked whether the description of the API still 
matches the driver code.

The third patch moves the document to an IMO more logical location and
removes the thermal directory from the top Documentation level.

Cheers,
FJP
