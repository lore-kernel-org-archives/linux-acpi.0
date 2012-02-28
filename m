From: Ken O'Brien <ken@kenobrien.org>
Subject: Power measurement clarification
Date: Tue, 28 Feb 2012 16:38:28 +0000
Message-ID: <4F4D0304.1050102@kenobrien.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47419 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964813Ab2B1Qic (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Feb 2012 11:38:32 -0500
Received: by bkcik5 with SMTP id ik5so1433529bkc.19
        for <linux-acpi@vger.kernel.org>; Tue, 28 Feb 2012 08:38:30 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Greetings,

In the ACPI spec there is a section (10.4) on power meters. Can someone 
clarify what these meters physically are? Are they external devices or 
onboard chips? If they're the latter, how can I detect them and read 
their data in userspace?

Regards,

Ken
