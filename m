From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: 2.6.24-rc1: OOPS at  acpi_battery_update
Date: Thu, 08 Nov 2007 19:11:53 +0300
Message-ID: <47333549.90505@suse.de>
References: <1193652664.22149.4.camel@localhost> <200711050118.34610.rjw@sisk.pl> <20071108155344.GA12231@cataract> <200711081717.00421.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:60212 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759587AbXKHQMB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Nov 2007 11:12:01 -0500
In-Reply-To: <200711081717.00421.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Johannes Weiner <hannes-kernel@saeurebad.de>, "Michael (rabenkind) Brandstetter" <listen@selfservix.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Rafael J. Wysocki wrote:
> On Thursday, 8 of November 2007, Johannes Weiner wrote:
>> Hi,
>>
>> is there any reason, why acpi_battery_get_property() should call
>> acpi_battery_update() at all?
> 
> Alex?
If someone wants to read stale values, he could comment out acpi_battery_update.

Regards,
Alex.
