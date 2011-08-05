From: "Lan, Tianyu" <tianyu.lan@intel.com>
Subject: RE: [PATCH] Battery: sysfs_remove_battery(): possible circular
 locking
Date: Sat, 6 Aug 2011 01:36:58 +0800
Message-ID: <625BA99ED14B2D499DC4E29D8138F15062C4514168@shsmsx502.ccr.corp.intel.com>
References: <20110805003322.GA8311@swordfish>
 <1312521008.2096.173.camel@lantianyu-ws>
 <20110805163944.GA3132@swordfish.minsk.epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54513 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094Ab1HERhF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Aug 2011 13:37:05 -0400
In-Reply-To: <20110805163944.GA3132@swordfish.minsk.epam.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

>Well, how about using separate (independent lock) for sysfs_remove_battery()
>case? Since we can't safely drop battery->lock in sysfs_remove_battery() before 
>power_supply_unregister() call.
>Not sure if it should be within struct acpi_battery, perhaps we could
>have it as a 'global' battery lock. Anyway, here it is:
I think it should be within struct acpi_battery. There maybe one or more batteries.
