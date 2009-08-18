From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 3/3] Drop platform sysfs support
Date: Tue, 18 Aug 2009 09:43:36 +0100
Message-ID: <9b2b86520908180143t4b25c1f7hd78cd4b4333c4ab4@mail.gmail.com>
References: <4A89E76B.5070204@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:45603 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbZHRIng (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Aug 2009 04:43:36 -0400
In-Reply-To: <4A89E76B.5070204@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, cezary.jackiewicz@gmail.com

On 8/18/09, Mario Limonciello <mario_limonciello@dell.com> wrote:
> With rfkill support being added, the platform support is no longer
> necessary.  Standard rfkill interfaces can be used to administer the box
> now.
> --
> Mario Limonciello
> *Dell | Linux Engineering*
> mario_limonciello@dell.com
>

-static struct platform_device *compal_device;

I don't think this is the right way to go.  I don't object to removing
the sysfs attributes, but the platform device can still be useful as a
parent device to the rfkill and backlight devices.  (See my earlier
comment on the use of rfkill_allocate()).

In practice I suspect it makes no difference that the rfkill and
backlight devices are exported as virtual devices with no physical
parent.  I just don't think it's "right" :-).

Thanks
Alan
