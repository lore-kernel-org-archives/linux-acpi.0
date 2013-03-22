From: Paul Bolle <pebolle@tiscali.nl>
Subject: acpi: config ACPI_PROCFS still needed?
Date: Fri, 22 Mar 2013 22:05:49 +0100
Message-ID: <1363986349.1390.197.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:61775 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423056Ab3CVVFv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Mar 2013 17:05:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

As far as I can tell, the last user of config ACPI_PROCFS got removed in
v2.6.38, with commit cef6e8a3790d6bdc305496629c357a56001d59a6 ("ACPI
processor: remove processor throttling control procfs I/F"). I must
admit I can't really wrap my head around the (former) purpose of
ACPI_PROCFS. So perhaps someone can tell me whether its Kconfig entry is
still needed.


Paul Bolle

