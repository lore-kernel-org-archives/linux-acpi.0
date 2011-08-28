From: "M. Vefa Bicakci" <m.v.b@runbox.com>
Subject: No AC adapter ACPI events on Sony Vaio VPCS12X9E
Date: Sun, 28 Aug 2011 10:44:40 +0300
Message-ID: <4E59F1E8.4040806@runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aibo.runbox.com ([91.220.196.211]:51904 "EHLO aibo.runbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284Ab1H1IFl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 Aug 2011 04:05:41 -0400
Received: from [10.9.9.160] (helo=penny.runbox.com)
	by bars.runbox.com with esmtp (Exim 4.71)
	(envelope-from <m.v.b@runbox.com>)
	id 1Qxa2s-0006oH-Cn
	for linux-acpi@vger.kernel.org; Sun, 28 Aug 2011 09:44:42 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

As the subject line summarizes, I do not get any ACPI events when I unplug/plug
the AC adapter on a Sony Vaio VPCS12X9E.

The laptop is currently running an up-to-date installation of Kubuntu 11.04,
but with a manually compiled vanilla 3.0.3 kernel. For the record, the same
problem also exists with the stock version 2.6.38 kernel that comes with
Kubuntu 11.04.

I have also reported this bug at
	https://bugzilla.kernel.org/show_bug.cgi?id=41762

Since I am going to travel soon and lose physical access to this hardware,
I wanted to ask if there is anything I could do to debug this problem.
I have included the acpidump and ACPI debug outputs in the bug report.

Any help would be appreciated.

Regards,

Mehmet Vefa Bicakci
