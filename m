From: Yu Luming <luming.yu@intel.com>
Subject: acpi button event to input layer (was [RFC] [PATCH] Make ACPI button driver an input device)
Date: Mon, 28 Aug 2006 15:06:50 +0800
Message-ID: <200608281506.50738.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2727 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932401AbWH1HA7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Aug 2006 03:00:59 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-acpi@vger.kernel.org

Matthew / Dmitry,

I recall there was a patch to make acpi button driver as input device.
Do you have any update patch? Because we want to transition acpi event
mechanism from /proc/acpi/event to input layer. I guess the acpi button driver
would be the first one to complete such transition.

http://www.gatago.com/linux/kernel/11320641.html
-- 
Thanks,
Luming
