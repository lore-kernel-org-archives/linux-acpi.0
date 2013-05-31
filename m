From: Joe Jin <joe.jin@oracle.com>
Subject: Why write CPER_NOTIFY_MCE to ERST when reboot
Date: Fri, 31 May 2013 16:22:36 +0800
Message-ID: <51A85DCC.3000109@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:45799 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048Ab3EaIWp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 May 2013 04:22:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Luck <tony.luck@intel.com>
Cc: linux-acpi@vger.kernel.org, david zhuang <david.zhuang@oracle.com>

Hi Tony,

With commit 0bb77c46 "pstore: X86 platform interface using ACPI/APEI/ERST"
when reboot the server kernel will call erst_writer() to write CPER_NOTIFY_MCE
to ERST, if reboot the server to Windows we find MCE from system event logs.
Any reason write this to ERST when reboot?

Any input will appreciate!

Regards,
Joe
