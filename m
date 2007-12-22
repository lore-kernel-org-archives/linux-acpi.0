From: Matt Mackall <mpm@selenic.com>
Subject: ACPI or radeon: spontaneous reboot regression
Date: Sat, 22 Dec 2007 17:58:56 -0600
Message-ID: <1198367937.8260.6.camel@cinder.waste.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from waste.org ([66.93.16.53]:38399 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714AbXLVX7d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Dec 2007 18:59:33 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: linux-acpi@vger.kernel.org, benh@kernel.crashing.org, rjw@sisk.pl

With 2.6.24-rc2, plugging and unplugging power results in a sudden
reboot. After the reboot, the machine boots normally until it switches
to graphics mode, at which point the screen is scrambled. It may hang or
repeatedly reboot at this point. Easily repeatable after just a few plug
cycles.

Switching back to 2.6.23-rc3-mm1, I can do a dozen plug cycles with no
problem.

Machine is a Thinkpad R51, with R250:

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250
[Mobility FireGL 9000] (rev 02)

(starting bisection)

-- 
Mathematics is the supreme nostalgia of our time.

