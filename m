From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH 0/4]  Disable the power state check in device power
	transition
Date: Mon, 14 Jul 2008 15:31:06 +0800
Message-ID: <1216020666.32159.13.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50617 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753884AbYGNHTr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2008 03:19:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Hi, all,
    
    Maybe the incorrect power state is returned on the bogus bios, 
which is different with the real power state. For example: the bios returns D0
state and the real power state is D3. OS expects to set the device to D0
state. In such case if OS uses the power state returned by the BIOS and checks the device
power state very strictly in power transition, the device can't be transited to the 
correct power state.
    
    This following patch series is to disable the power state check in device 
power transition.
    Patch 01:
	Attach the ACPI device to the ACPI handle as early as possible
    Patch02:
        Get the device power state in the course of scanning device 02:
    Patch 03: 
        Add "acpi.power_nocheck=1" to disable power state check in power transition
    Patch 04:
        Add DMI check to disable power check in power transition
    
    Thanks for the review.
   
Yakui


