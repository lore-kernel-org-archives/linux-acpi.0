From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/2] drivers: PL061: Add platform driver probing support
Date: Tue, 11 Aug 2015 14:53:30 +0200
Message-ID: <CACRpkdYd_oWsx23h4-Hjk8rqcgnuMqd47SEg+4ubtR08jgQY9g@mail.gmail.com>
References: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
	<20150803075848.GH7557@n2100.arm.linux.org.uk>
	<55BF33AD.5040502@huawei.com>
	<20150803094923.GI7557@n2100.arm.linux.org.uk>
	<20150803162623.GB30867@kroah.com>
	<20150803190935.GL7557@n2100.arm.linux.org.uk>
	<20150807022141.GD25067@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36409 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934106AbbHKMxa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Aug 2015 08:53:30 -0400
Received: by obnw1 with SMTP id w1so146885172obn.3
        for <linux-acpi@vger.kernel.org>; Tue, 11 Aug 2015 05:53:30 -0700 (PDT)
In-Reply-To: <20150807022141.GD25067@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Shannon Zhao <zhaoshenglong@huawei.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alexandre Courbot <gnurou@gmail.com>, Shannon Zhao <shannon.zhao@linaro.org>

On Fri, Aug 7, 2015 at 4:21 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Aug 03, 2015 at 08:09:35PM +0100, Russell King - ARM Linux wrote:

>> Right now, there seems to be a move to convert _all_ AMBA device drivers
>> to become dual-drivers: an amba bus driver and a platform driver.  Is
>> that something you really want to see, irrespective of ACPI issues?
>
> Ick, no, I don't think that's wise at all.  Why not just make the needed
> resources availble to _all_ bus drivers, then it doesn't matter if it's
> AMBA, or ACPI, or USB, or anything else?

Amen to that.

> I thought that is what some recent patches did to the acpi/of core, but
> maybe I was mistaken.

I think you're referring to the initiative to provide query functions that will
work the same on device trees and ACPI devices, that is to get a key/value
from a certain struct device * no matter if it came from a DT or ACPI.

This is about how the core hardware description spawns devices. While
DT will (correctly) spawn AMBA devices, the ACPI code apparently
doesn't. But it should. of_amba_device_create() even shows exactly
how to do it.

What I fear is that ACPI actually has no way to tell whether a device is
an AMBA device but rather thinks the whole world consists of
platform_devices, and then *THAT* needs to be fixed.

Yours,
Linus Walleij
