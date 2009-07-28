From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Illuminated keyboard on ASUS U50VG laptop, backlight or led ?
Date: Tue, 28 Jul 2009 21:51:09 +0200
Message-ID: <71cd59b00907281251k7fc6cf7fga433531572394b99@mail.gmail.com>
References: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f216.google.com ([209.85.220.216]:47500 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbZG1TvK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jul 2009 15:51:10 -0400
Received: by fxm12 with SMTP id 12so270186fxm.37
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2009 12:51:10 -0700 (PDT)
In-Reply-To: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, acpi4asus-user@lists.sourceforge.net

On Fri, Jul 24, 2009 at 9:34 AM, Corentin Chary<corentin.chary@gmail.com> wrote:
> Hi,
> I'm working on Illimunated keyboard for some new Asus U50VG,
> There is some kind of backlight for the keyboard:
> http://forum.amtech.com.vn/attachments/reviews-zone/16272d1245751662-laptop-asus-u50vg-con-sot-moi-cua-asus-p1010643.jpg
> There is 4 level of brightness.
>
> I've found the ACPI to control that, but I'm not sure if I should
> register it as a led or as a backlight.
>
> Any Idea ?
>
> Thanks

No answers.
I think I'll implement that as a backlight, because it is a backlight
even if it's not for a screen.

-- 
Corentin Chary
http://xf.iksaif.net - http://uffs.org
