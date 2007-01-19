From: Richard Hughes <hughsient@gmail.com>
Subject: Debugging video resume problems
Date: Fri, 19 Jan 2007 00:17:30 +0000
Message-ID: <1169165850.3613.10.camel@hughsie-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:52517 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932783AbXASARt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jan 2007 19:17:49 -0500
Received: by ug-out-1314.google.com with SMTP id 44so320941uga
        for <linux-acpi@vger.kernel.org>; Thu, 18 Jan 2007 16:17:48 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Guys,

I have a shiny new Lenovo 3000 N100 laptop. Hibernate works with the
latest git tree from kernel.org, but suspend fails to resume with a
black screen and no other flashing LED's or other activity. I've tried
2.6.18 and 2.6.19 and neither of those work either.

This laptop has no serial ports, so I can't even see if it's oopsed
remotely. Is there a guide (howto) that can help debug this? I've tried
nearly all the usual combinations of acpi_sleep=s3_bios,s3_mode but I
really need a hand with this one.

As I've got no messages on the screen at resume, I really don't know
where to begin to fix this, advice would be really appreciated.

Thanks,

Richard Hughes.


