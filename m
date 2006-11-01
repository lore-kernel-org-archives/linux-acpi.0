From: Pavel Machek <pavel@ucw.cz>
Subject: acpiphp makes noise on every lid close/open
Date: Wed, 1 Nov 2006 12:56:18 +0100
Message-ID: <20061101115618.GA1683@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51102 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1423976AbWKAL42 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Nov 2006 06:56:28 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kristen.c.accardi@intel.com, kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>

Hi!

With 2.6.19-rc4, acpi complains about "acpiphp_glue: cannot get bridge
info" each time I close/reopen the lid... On thinkpad x60. Any ideas?
(-mm1 behaves the same).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
