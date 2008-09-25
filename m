From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH 0/2]  ACPI : two pachtes abut the Power resource
Date: Thu, 25 Sep 2008 13:20:49 +0800
Message-ID: <1222320049.4023.47.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9866 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000AbYIYFQ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Sep 2008 01:16:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Hi, All
    the following are two patches about the power resource driver.
    Patch 1/2: Cleanup in power resource
               The state is changed to *state in the function of acpi_power_get_state.
    Patch 2/2: delete the strick check in ACPI power transisition
         Maybe the device is already in D3 state and expected to be transited to
D3 state. As there is no _PR3 object, the power transition can't be finished and
it will be switched to the Unknow state.
         For example: 
         http://bugzilla.kernel.org/show_bug.cgi?id=9485

         Maybe it is more reasonable that the strick check in power transistion
is deleted.

    Welcome the comments.

Best regards.
   Yakui


