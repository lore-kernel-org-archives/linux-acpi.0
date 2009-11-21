From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] acpi/blacklist: enable OSI(Linux) on newer eeepc
Date: Sat, 21 Nov 2009 22:22:45 +0100
Message-ID: <71cd59b00911211322t45be6c92g2a0c78c03d7eb5e9@mail.gmail.com>
References: <1258752548-9299-1-git-send-email-corentincj@iksaif.net>
	 <20091121184503.GA15141@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:51209 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228AbZKUVWj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Nov 2009 16:22:39 -0500
Received: by pwi3 with SMTP id 3so2732549pwi.21
        for <linux-acpi@vger.kernel.org>; Sat, 21 Nov 2009 13:22:45 -0800 (PST)
In-Reply-To: <20091121184503.GA15141@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

On Sat, Nov 21, 2009 at 7:45 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Fri, Nov 20, 2009 at 10:29:08PM +0100, Corentin Chary wrote:
>> Without this patch, eeepc-laptop won't work on newer Eeepc
>> because the interface it uses is disabled.
>
> It looks easy to add the WMI interface instead. Please let's not
> perpetuate this kind of thing.
>

I think we could add that patch to 2.6.32, then revert it in 2.6.33 (or later)
when a eeepc-wmi driver (or wmi support inside eeepc-laptop) is available.
And I don't think such a driver (patch) will be available before 2.6.32.

That means that owner of 1000h and 1005ha won't be able to use eeepc-laptop
(camera, rfkill, hotkeys) without adding acpi_osi="Linux" manually in 2.6.32.

I know this is not a long term solution.

I would be happy to add a WMI interface as soon as I can get the hardware.

-- 
Corentin Chary
http://xf.iksaif.net
