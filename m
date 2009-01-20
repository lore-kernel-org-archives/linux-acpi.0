From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Suspned/resume can't work on the 2.6.29-rc1 but it can work well
	on the 2.6.28
Date: Tue, 20 Jan 2009 09:08:00 +0800
Message-ID: <1232413680.3971.32.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22225 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755643AbZATA43 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Jan 2009 19:56:29 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

Hi, All
    I do some tests about suspend/resume on my two boxes. One is HP
laptop and the other is Asus EEEPC901. The suspend/resume can't work
well. Even after core is selected as the test mode, it still can't work
well.(echo core > /sys/power/pm_test)
    
    Then I do the same test by using the 2.6.28 kernel. And
suspend/resume can work well.
    
    
    Of course I will try to use the git-bisect to identify the first bad
commit ASAP.
 
Thanks.
   Yakui

