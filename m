From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 3/3] Drop platform sysfs support
Date: Tue, 18 Aug 2009 14:23:29 +0100
Message-ID: <9b2b86520908180623i4e7ce5cv9a4cd6b1704a0e5f@mail.gmail.com>
References: <4A89E76B.5070204@dell.com>
	 <9b2b86520908180143t4b25c1f7hd78cd4b4333c4ab4@mail.gmail.com>
	 <1250589285.5150.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:36956 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758626AbZHRNX3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Aug 2009 09:23:29 -0400
In-Reply-To: <1250589285.5150.1.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mario Limonciello <mario_limonciello@dell.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, cezary.jackiewicz@gmail.com

On 8/18/09, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Alan,

>> In practice I suspect it makes no difference that the rfkill and
>> backlight devices are exported as virtual devices with no physical
>> parent.  I just don't think it's "right" :-).
>
> it actually does make a difference for hardware detection. We wanna have
> them hanging of the compal platform device.

Ok.  I wasn't sure that userspace was allowed to rely on that, but I
re-read Documentation/ABI/testing/sysfs-devices and I see now that it
can be allowed.

Some of these issues with the compal-laptop work may come from copying
dell-laptop.  dell-laptop is the only driver which creates rfkill
devices without a parent device.  In fact, it doesn't even create a
platform device :-).

I'll try sending a patch or two to clean up dell-laptop.  I don't have
the hardware but it should be pretty mechanical, almost a copy+paste
job from a "good" driver.

Thanks
Alan
