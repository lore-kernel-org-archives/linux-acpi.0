From: Matt Mackall <mpm@selenic.com>
Subject: Thinkpads not waking up on lid open with -rc6-mm1
Date: Tue, 17 Apr 2007 14:55:00 -0500
Message-ID: <20070417195459.GJ11115@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from waste.org ([66.93.16.53]:56193 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161039AbXDQUH1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Apr 2007 16:07:27 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Both my T30 and R51 aren't waking up when I open the lid any more. I
have to hold down the power button for a moment. On my R51, I see this:

$ cat /proc/acpi/wakeup
Device  S-state   Status   Sysfs node
LID       S3    *enabled
SLPB      S3    *enabled
PCI0      S3     disabled  no-bus:pci0000:00
UART      S3     disabled  pnp:00:09
PCI1      S4     disabled  pci:0000:00:1e.0
USB0      S3     disabled  pci:0000:00:1d.0
USB1      S3     disabled  pci:0000:00:1d.1
AC9M      S4     disabled  pci:0000:00:1f.6

..so it ought to work?

-- 
Mathematics is the supreme nostalgia of our time.
