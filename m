From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [linux-pm] Re: [patch] hibernation: utilize ACPI hardware signature
Date: Thu, 03 Jan 2008 19:26:56 +1100
Message-ID: <477C9C50.4060907@nigel.suspend2.net>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com> <200801021512.54140.rjw@sisk.pl> <477C0155.70902@nigel.suspend2.net> <200801022318.59392.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from home.nigel.suspend2.net ([203.171.70.205]:51676 "EHLO
	server1.example.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753092AbYACI1A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jan 2008 03:27:00 -0500
In-Reply-To: <200801022318.59392.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?ISO-8859-15?Q?Erik_Andr=E9n?= <erik.andren@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, linux acpi <linux-acpi@vger.kernel.org>

Hi.

Rafael J. Wysocki wrote:
>>>> Is there another mechanism preventing this?
>>> Not at the kernel level, but you can prevent this from happening by running
>>> mkswap on all swap spaces that refuse to come up after a fresh boot.
>> We really should do something about this. It should be possible to
>> handle this properly if something along the following lines was implemented:
>>
>> 1) Each filesystem implements a function taking a pointer to a struct
>> block_device and returns a mount count for that filesystem without
>> making any modifications to the filesystem.
>> 2) Hibernation implementations store the major & minor numbers and mount
>> counts for each mounted filesystem in the image header when hibernating,
>> and recheck those values at resume time. If the mount count on any
>> filesystem has changes, we warn the user, invalidate the image and boot
>> normally.
> 
> That may quickly become complicated.
> 
> For example, boot kernel need not contain all drivers used by the hibernated
> ones, so some filesystems may be physically inaccessible to them.

Mmmm. That's true, and I'd never heard that point raised before or
thought of it myself. Thanks!

Nigel
