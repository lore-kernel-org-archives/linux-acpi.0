From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH 00/24] acpi4asus updates
Date: Fri, 28 Aug 2009 16:02:22 +0100
Message-ID: <4A97F17E.3060908@tuffmail.co.uk>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:43262 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbZH1PCX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 11:02:23 -0400
Received: by ewy2 with SMTP id 2so2202957ewy.17
        for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 08:02:24 -0700 (PDT)
In-Reply-To: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

Corentin Chary wrote:
> Hi Len,
> Here is acpi4asus series for 2.6.32:
>  * eeepc-laptop bugfixes and updates.
>  * asus-laptop updates (keyboard backlight and new hotkeys).
>  * documentation on asus-laptop, eeepc-laptop, video/lcd,
>    video/backlight and leds.
>
> Alan Jenkins (9):
>   eeepc-laptop: don't touch the pci slot if it was claimed by a
>     different driver
>   eeepc-laptop: use a mutex to serialize pci hotplug (resume vs.
>     notify)
>   
I'm hoping the two patches above will fix a regression on certain 
hardware, and that they can be pushed into 2.6.31.  Or if they don't fix 
it, that the commits responsible can be reverted - which will conflict 
with all the eeepc-laptop patches.  So you may wish to hold back on 
eeepc-laptop.

See linux-acpi thread "[Debian-eeepc-devel] Problems with wlan on a 
1005HA-M"
(regression in 2.6.31-rc6: suspend hangs and causes the wireless to be 
disabled).

My apologies
Alan
