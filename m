From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: Runtime GPEs not saved over suspend/resume if type != "platform"
Date: Thu, 26 Oct 2006 19:05:46 +0400
Message-ID: <4540CECA.80304@linux.intel.com>
References: <1C601A6A3344064EB423D0C1E83B717B5C5954@pdsmsx411.ccr.corp.intel.com> <200610252054.32945.rjw@sisk.pl> <4540B667.6090707@linux.intel.com> <200610261701.50692.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:59554 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1752152AbWJZPFw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Oct 2006 11:05:52 -0400
In-Reply-To: <200610261701.50692.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>

Rafael J. Wysocki wrote:
> On Thursday, 26 October 2006 15:21, Alexey Starikovskiy wrote:
>> Both yours and mine patches suffer from the same problem -- it's not possible to write
>> to "/sys/power/disk" any longer, as all values other than PM_DISK_PLATFORM would be rejected :)
> 
> Well, I'm running with my patch applied now:
Great, then we are ready to push it out :)
> 
> albercik:~ # cat /sys/power/disk
> platform
> albercik:~ # echo shutdown > /sys/power/disk
> albercik:~ # cat /sys/power/disk
> shutdown
> albercik:~ #
> 
> Greetings,
> Rafael
> 
> 
