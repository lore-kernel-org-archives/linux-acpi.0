From: Pavel Machek <pavel@ucw.cz>
Subject: Changes in sleep mode, on x86 PC
Date: Mon, 28 Mar 2016 23:20:12 +0200
Message-ID: <20160328212010.GA22713@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40704 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbcC1VUQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Mar 2016 17:20:16 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel list <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org

Hi!

Few releases ago, I could wake up PC from S3 sleep by hitting any
key. That ceased to work some time before, keyboard would just light a
NUM lock LED when I hit a key (4.5). Now PC seems to be sleeping (in
S3) with NUM lock LED on (4.6-rc0).

Any idea what is going on there? Does it happen for you, too? What is
the expected behaviour?

Debian 8.3, with MATE desktop, I just hit the "moon" key to make it
sleep. Keyboard is on USB.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
