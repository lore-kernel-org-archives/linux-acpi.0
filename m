From: Phillip Susi <psusi@cfl.rr.com>
Subject: Wakeup and S states
Date: Wed, 15 Jun 2011 11:12:03 -0400
Message-ID: <4DF8CBC3.5070801@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.123]:62778 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab1FOPMH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2011 11:12:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

It looks like the PM core has an all or nothing concept of whether a 
device can and should wake the system, but in ACPI, the answer to these 
depends on what S state you are talking about.  If you look at 
/proc/acpi/wakeup, it lists the lowest S state each device is capable of 
waking the system in, but device_can_wakeup() appears to just check an 
all or nothing flag, rather than consider what S state we may be 
transitioning to.  If a device is capable of wakeup from S3, but we are 
going to S4, then won't device_can_wakeup() return true, and thus, the 
driver will mistakenly try to enable wakeup when hibernating?

Conversely, if an ethernet controller is capable of waking up the system 
from S5, that does not mean we want it left powered on and capable of 
doing so when we shut the machine off, but had WOL enabled.  Is there no 
way to enable wakeup only from S3, even though the device is capable of 
lower levels?
