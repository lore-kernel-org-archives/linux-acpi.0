From: Pavel Machek <pavel@ucw.cz>
Subject: x60 - spontaneous thermal shutdown
Date: Mon, 4 Sep 2006 23:40:59 +0200
Message-ID: <20060904214059.GA1702@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30433 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751492AbWIDWJa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Sep 2006 18:09:30 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI mailing list <linux-acpi@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>

Hi!

x60 shut down after quite a while of uptime, in period of quite heavy
load:

Sep  4 23:33:01 amd kernel: ACPI: Critical trip point
Sep  4 23:33:01 amd kernel: Critical temperature reached (128 C), shutting down.
Sep  4 23:33:01 amd shutdown[32585]: shutting down for system halt
Sep  4 23:34:42 amd init: Switching to runlevel: 0

I do not think cpu reached 128C, as I still have my machine... Did
anyone else see that?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
