From: Jean Delvare <khali@linux-fr.org>
Subject: ACPI requesting I/O ports?
Date: Fri, 2 Mar 2007 22:14:39 +0100
Message-ID: <20070302221439.e9a67df5.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:4817 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965641AbXCBVRC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Mar 2007 16:17:02 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

Hi Len,

As a follow up of this dicussion:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019015.html

I'd like to know if it would be possible to have the acpi subsystem
somehow declare or even request the I/O ports it will be accessing when
running AML code? There is a need for this, otherwise other drivers
might access the same resources as the AML code does, with possibly bad
consequences.

Another approach proposed by Pavel Machek would be a general mutex to
protect the AML code from the rest of the kernel, this would probably
work too but the granularity (and thus the latency) would be better
with a per-I/O-region approach.

Thanks,
-- 
Jean Delvare
