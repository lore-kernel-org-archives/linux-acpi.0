From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [Resend] [PATCH 0/2]  ACPI : two pachtes abut the Power resource
Date: Mon, 27 Oct 2008 16:04:46 +0800
Message-ID: <1225094686.5189.57.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23809 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998AbYJ0H6S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Oct 2008 03:58:18 -0400
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
it will be switched to the Unknown state.
         For example: 
         http://bugzilla.kernel.org/show_bug.cgi?id=9485

         Maybe it is more reasonable that the strick check in power transistion
is deleted.

    Welcome the comments.

Best regards.
   Yakui


