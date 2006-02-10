From: Upayavira <uv@odoko.co.uk>
Subject: IDE device ACPI handler is NULL
Date: Fri, 10 Feb 2006 06:33:14 +0000
Message-ID: <43EC33AA.3000805@odoko.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:63424 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751162AbWBJGdT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Feb 2006 01:33:19 -0500
Received: from frontend1.internal (mysql-sessions.internal [10.202.2.149])
	by frontend1.messagingengine.com (Postfix) with ESMTP id C9DE8D34327
	for <linux-acpi@vger.kernel.org>; Fri, 10 Feb 2006 01:33:18 -0500 (EST)
Received: from [10.0.0.4] (host-87-74-25-34.bulldogdsl.com [87.74.25.34])
	by www.fastmail.fm (Postfix) with ESMTP id 6097D571506
	for <linux-acpi@vger.kernel.org>; Fri, 10 Feb 2006 01:33:18 -0500 (EST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I am running Ubuntu Breezy on a Dell M60 notebook - Centrino processor,
NVidia video drivers. I have just succeeded at getting suspend/hibernate
working (sometimes). I am now getting the following message:

"ide device ACPI handler is NULL"

Sometimes on suspension, sometimes on hibernation, and sometimes on
resuming. When I get that message, the system will not resume.

Any ideas what this is about?

Thanks in advance.

Upayavira, a grateful ACPI user
