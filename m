From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime GPEs not saved over suspend/resume if type != "platform"
Date: Thu, 26 Oct 2006 17:01:49 +0200
Message-ID: <200610261701.50692.rjw@sisk.pl>
References: <1C601A6A3344064EB423D0C1E83B717B5C5954@pdsmsx411.ccr.corp.intel.com> <200610252054.32945.rjw@sisk.pl> <4540B667.6090707@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:7392 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1752142AbWJZPDQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Oct 2006 11:03:16 -0400
In-Reply-To: <4540B667.6090707@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>

On Thursday, 26 October 2006 15:21, Alexey Starikovskiy wrote:
> Both yours and mine patches suffer from the same problem -- it's not possible to write
> to "/sys/power/disk" any longer, as all values other than PM_DISK_PLATFORM would be rejected :)

Well, I'm running with my patch applied now:

albercik:~ # cat /sys/power/disk
platform
albercik:~ # echo shutdown > /sys/power/disk
albercik:~ # cat /sys/power/disk
shutdown
albercik:~ #

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
