From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [v3.11][3.12][Regression]  ACPI / processor: Use common hotplug infrastructure
Date: Fri, 15 Nov 2013 12:44:11 -0500
Message-ID: <52865D6B.1080902@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54469 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab3KORoS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Nov 2013 12:44:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Rafael,

A kernel bug affecting several users was opened against Ubuntu[0]. 
After a bisect, it was found the following commit introduced the regression:

commit ac212b6980d8d5eda705864fc5a8ecddc6d6eacc
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date: Fri May 3 00:26:22 2013 +0200

    ACPI / processor: Use common hotplug infrastructure

The regression was introduced as of v3.11-rc1.

This commit doesn't revert cleanly in 3.12, and requires the revert of
other commits as well.  I wanted to get your feedback since you are the
author.

   
Thanks,
   
Joe

http://pad.lv/1237336
