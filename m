From: Pavel Machek <pavel@ucw.cz>
Subject: 3.14-rc: /proc/acpi/battery gone?
Date: Fri, 14 Mar 2014 22:14:57 +0100
Message-ID: <20140314211456.GA23213@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45317 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422AbaCNVO7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Mar 2014 17:14:59 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>

Hi!

It seems /proc/acpi/battery interface is gone, and I don't see any
option to reintroduce it... what is going on?

(I got into habit of archiving content of /proc/acpi/battery to
monitor, how battery ages..)

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
