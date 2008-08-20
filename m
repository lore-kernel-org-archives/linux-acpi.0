From: Jean Delvare <khali@linux-fr.org>
Subject: Thermal zone names
Date: Wed, 20 Aug 2008 22:34:23 +0200
Message-ID: <20080820223423.37f31780@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:39683 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbYHTUec (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Aug 2008 16:34:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi Rui,

The ACPI thermal zones in /proc/acpi/thermal_zone have a name. The ACPI
thermal zones in /sys/class/thermal do not. Would it be possible to add
it there? When these thermal zones are exported to libsensors, the
temperatures appear with their default labels (temp1, temp2, etc...)
Users sometimes wonder what these temperatures correspond to. The ACPI
names are short and not always clear, but sometimes they could help
figuring out what the temperature corresponds to.

-- 
Jean Delvare
