From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: [PATCH 0/3] Fix backlight issues on some Windows 8 systems
Date: Sun,  9 Jun 2013 19:01:36 -0400
Message-ID: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45794 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab3FIXB7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jun 2013 19:01:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: seth.forshee@canonical.com, joeyli.kernel@gmail.com, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl

Windows 8 introduced new policy for backlight control by pushing it out to
graphics drivers. This appears to have coincided with a range of vendors
adding Windows 8 checks to their backlight control code which trigger either
awkward behaviour (Lenovo) or complete brokenness (some Dells). The simplest
thing to do would be to just disable ACPI backlight control entirely if the
firmware indicates Windows 8 support, but it's entirely possible that
individual graphics drivers might still make use of the ACPI functionality in
preference to native control.

The first two patches in this series are picked from other patchesets aimed at
solving similar problems. The last simply unregisters ACPI backlight control
on Windows 8 systems when using an Intel GPU. Similar code could be added to
other drivers, but I'm reluctant to do so without further investigation as
to the behaviour of the vendor drivers under Windows.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

