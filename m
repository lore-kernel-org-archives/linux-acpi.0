From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH 0/4]  Disable Mwait for CPU C-states and add the boot
	option of "idle=nomwait" ,"idle=halt"
Date: Tue, 17 Jun 2008 14:38:54 +0800
Message-ID: <1213684734.19901.8.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32031 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139AbYFQG2G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jun 2008 02:28:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Hi, all,
    This following patch series is to disable mwait for CPU C-states and add the boot option
of "idle=nomwait", "idle=halt"
    Patch 01:
	Disable the C2C3_FFH access mode if MWAIT is unsupported
    Patch 02:
	Add the boot option of "idle=halt". If the option of "idle=halt" is added,
Halt will be used for CPU idle. In such case CPU C-state won't be used again for CPU idle.
    Patch 03: 
       Add boot option of "idle=nomwait" to disable mwait for CPU
C-states. If the option of "idle=nomwait" is added, OSPM won't
use mwait for CPU C-states. 
    Patch 04:
       Add DMI check to disable mwait for CPU C-states. For the bogus
BIOS the mwait will automatically be disabled for CPU C-states.
    
    Thanks for the review.
   
Yakui


