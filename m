From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] acpi: blacklist win8 OSI for ASUS Zenbok Prime UX31A
Date: Wed, 17 Jul 2013 19:20:41 -0500
Message-ID: <CAMP44s0cz+sjzZngRpKvfKEpoG+0DO40qSY9nvC86YW78gASnQ@mail.gmail.com>
References: <1369037793-1559-1-git-send-email-felipe.contreras@gmail.com>
	<51CBA54C.6040703@intel.com>
	<CAMP44s2oq5+H=oCXjik4y_yaLm1YKL6nRgbwKNqfVmP4C8pthg@mail.gmail.com>
	<13622439.arY5YlYVCP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:45467 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab3GRAUm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jul 2013 20:20:42 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so2000883lab.14
        for <linux-acpi@vger.kernel.org>; Wed, 17 Jul 2013 17:20:41 -0700 (PDT)
In-Reply-To: <13622439.arY5YlYVCP@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wed, Jul 17, 2013 at 5:04 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, July 17, 2013 10:42:35 AM Felipe Contreras wrote:

>> If so, that doesn't work correctly in
>> this laptop. In this laptop intel backlight works through X, but when
>> I set the level to 0 everything is black (it works fine in ACPI), and
>> the keyboard keys don't work.
>>
>> ACPI works perfectly fine. So I think for this laptop (and possibly
>> others) ACPI without win8 mode is the way to go.
>
> While that may be the case, I'd like to avoid more blacklisting than we
> already have.

Unless your version makes it work without regression from user-space,
I don't see any other option.

-- 
Felipe Contreras
