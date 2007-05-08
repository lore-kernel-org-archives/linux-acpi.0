From: Richard Hughes <hughsient@gmail.com>
Subject: Debugging resume on Lenovo laptop
Date: Tue, 08 May 2007 11:46:32 +0100
Message-ID: <1178621192.32168.6.camel@hughsie-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:14211 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966632AbXEHKqp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 May 2007 06:46:45 -0400
Received: by ug-out-1314.google.com with SMTP id 44so92437uga
        for <linux-acpi@vger.kernel.org>; Tue, 08 May 2007 03:46:43 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>

I've bugzilla'd this before (#7860), but with no specific outcome.

I'm now in a position where I have some fairly heavy-duty testing stuff
at my disposal, including stuff like DriverStudio. Does anybody know how
I can "trace" the successful suspend and resume in Windows XP, and then
use this to work out what Linux is doing wrong? I don't even get to the
first resume steps in Linux, so I'm guessing Windows XP does some voodoo
to either ACPI or the EC before it suspends.

Ideas welcome - thanks.

Richard.


