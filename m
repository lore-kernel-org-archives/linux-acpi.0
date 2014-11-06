From: Scott Ashcroft <scott.ashcroft@talk21.com>
Subject: Re: [PATCH v1 0/4] ACPI / LPSS: fix system hangup on BYT
Date: Thu, 6 Nov 2014 18:06:14 +0000
Message-ID: <1415297174.91152.YahooMailNeo@web87401.mail.ir2.yahoo.com>
References: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com>
Reply-To: Scott Ashcroft <scott.ashcroft@talk21.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nm36-vm8.bullet.mail.ne1.yahoo.com ([98.138.229.120]:43866 "EHLO
	nm36-vm8.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751600AbaKFSPn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Nov 2014 13:15:43 -0500
In-Reply-To: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Blin, Jerome" <jerome.blin@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>



> Scott, do you have a chance to test this patch series against last linux-pm
> tree on HP laptops? I would appreciate your Tested-by tag.

This allows the laptop to power down but it appears to not dismount the file systems cleanly.
Running 'init 0' looks like it is doing a shutdown but the last thing it logs is something to do with ntp rather than the normal flushing disks etc.

I'll try and get some logs. Are there any debug options I should turn on?

Cheers,
Scott

