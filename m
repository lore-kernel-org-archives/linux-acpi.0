From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute in	sysfs
Date: Sun, 7 Jan 2007 11:19:00 +0000
Message-ID: <20070107111859.GB4792@ucw.cz>
References: <1168083318.5619.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4967 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932504AbXAGLTL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Jan 2007 06:19:11 -0500
Content-Disposition: inline
In-Reply-To: <1168083318.5619.37.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org

Hi!

> Create /sys/power/alarm.
> The way it works is exactly the same as /proc/acpi/alarm.
> I.e. "#echo yyyy-mm-dd hh-mm-ss >/sys/power/alarm" supports existing absolute time.
> And "#echo +yyyy-mm-dd hh-mm-ss >/sys/power/alarm" supports a duration.

NAK. /proc/acpi/alarm is a mess, and this just moves it to /sysfs.
'One value per file', please.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
