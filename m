From: Pavel Machek <pavel@suse.cz>
Subject: Controlling backlight on thinkpad x60
Date: Mon, 8 Sep 2008 17:10:58 +0200
Message-ID: <20080908151058.GA1650@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47921 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbYIHPVQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Sep 2008 11:21:16 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>
Cc: ACPI mailing list <linux-acpi@vger.kernel.org>

Hi!

Some time ago, FN-Home/End just adjusted the brightness, and
/proc/acpi/ibm contained backlight control.

In 2.6.27-rc5, /proc/acpi/ibm does not contain backlight control and
/sys/class/backlight is empty...

(I do have CONFIG_ACPI_VIDEO disabled, it killed my machine last time
I enabled it, is it mandatory now?)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
