From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 0/8] eeepc-laptop fixes
Date: Wed, 19 Aug 2009 12:35:40 +0100
Message-ID: <9b2b86520908190435h4fccec67n35af93e884a0d79@mail.gmail.com>
References: <4A75B6C6.3020805@tuffmail.co.uk>
	 <71cd59b00908021018x3b4c0af2jde2ccf0218befa2f@mail.gmail.com>
	 <9b2b86520908180844p55bf64fdl46acdb550f2b2d51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:54000 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbZHSLfk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Aug 2009 07:35:40 -0400
Received: by bwz19 with SMTP id 19so4704748bwz.37
        for <linux-acpi@vger.kernel.org>; Wed, 19 Aug 2009 04:35:41 -0700 (PDT)
In-Reply-To: <9b2b86520908180844p55bf64fdl46acdb550f2b2d51@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org

On 8/18/09, Alan Jenkins <sourcejedi.lkml@googlemail.com> wrote:
> On 8/2/09, Corentin Chary <corentin.chary@gmail.com> wrote:
>> Thanks,
>> Applied in acpi4asus eeepc tree:
>> http://git.iksaif.net/?p=acpi4asus.git;a=shortlog;h=refs/heads/eeepc-laptop
>> With two other patch on top of yours (wimax and __init).
>> I think I'll send them for 2.6.32 because there is a lot of change.
>
> That was the idea.  Thanks!  I am suspicious of your __init and
> ABI-doc commits, I will have a closer look at them :-).

Ok, the ABI-doc looks good.  There's just one typo: "Control he card reader".

However I do think it's suspicious to have an __init function,
eeepc_hotk_add(), as an "add" method on the ACPI device.  This isn't
generally acceptable because hotplug can call the "add" method after
the driver is loaded.  There is a special registration function for
*platform* devices, platform_driver_probe(), which allows init code to
be marked __init if hotplug can be ruled out.  But there is no
equivalent for ACPI.

If we add the __init annotations, we open a codepath which would lead
to a crash.  We don't expect the firmware to ever trigger the crash,
but is it worth the risk just to save a few kilobytes?

Alan
