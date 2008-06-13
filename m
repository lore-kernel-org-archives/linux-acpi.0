From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH 0/2]  Disable Mwait for CPU C-states on the broken BIOS
Date: Fri, 13 Jun 2008 13:32:24 +0800
Message-ID: <1213335144.13591.13.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9985 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbYFMFWM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jun 2008 01:22:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Hi, all,

    This following patch series is to disable mwait for CPU C-states on
the bogus BIOS.
    Patch 01: 
       Add module parameter processor.idle to disable mwait for CPU
C-states. If the module parameter processor.idle=1 is added, OSPM won't
use mwait for CPU C-states. 
    Patch 02:
       Add DMI check to disable mwait for CPU C-states. For the bogus
BIOS the mwait will automatically be disabled for CPU C-states.
    
    Thanks for the review.
   
Yakui


