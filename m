From: Zhang Rui <rui.zhang@intel.com>
Subject: does anyone have Dell Latitude E6400?
Date: Tue, 09 Jun 2009 14:44:21 +0800
Message-ID: <1244529861.9076.61.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47321 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757171AbZFIGnj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Jun 2009 02:43:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>

Hi, all,

I need to purchase a laptop with ambient light sensor to implement the
ACPI ambient light sensor driver in Linux.
Google tells me that Dell Latitude e6400 has this, but I'm not sure if
the sensor is controlled via ACPI or platform specific methods.
so can anybody that has this laptop send me the lspci and acpidump
output please?

If somebody knows some other laptop models with this ACPI device (grep
ACPI0008 and _ALI/_ALR control methods in the acpidump), please let me
know.

BTW, to get the acpidump output, you need to download the latest pmtools
at http://www.lesswatts.org/projects/acpi/utilities.php,
build and run "acpidump > acpidump.log".

thanks,
rui

