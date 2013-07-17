From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] acpi: blacklist win8 OSI for ASUS Zenbok Prime UX31A
Date: Wed, 17 Jul 2013 10:42:57 -0500
Message-ID: <CAMP44s0PbR9PX3FnUE4OU=6Xnk+UK484PudNcBtpq9CxOridjA@mail.gmail.com>
References: <1369037793-1559-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s3M=LtOfPp+AS0dv=eud1rVSzDOjYbkw+cTAQPzLsK2wg@mail.gmail.com>
	<4224252.tpDZo1Wai9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:54598 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572Ab3GQPm7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jul 2013 11:42:59 -0400
Received: by mail-wi0-f179.google.com with SMTP id hj3so2144432wib.0
        for <linux-acpi@vger.kernel.org>; Wed, 17 Jul 2013 08:42:58 -0700 (PDT)
In-Reply-To: <4224252.tpDZo1Wai9@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wed, Jun 26, 2013 at 7:42 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, June 26, 2013 05:41:01 AM Felipe Contreras wrote:
>> On Mon, May 20, 2013 at 3:16 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> > Otherwise the backlight can't be changed, presumably because the DSDT
>> > contains stub code when in conjunction with Windows 8.
>> >
>> > https://wiki.archlinux.org/index.php/ASUS_Zenbook_Prime_UX31A
>> >
>> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>
>> Hello?
>>
>> Is there anything wrong with this patch?
>
> We're going to fix this issue in a different way.

That "different way" doesn't work correctly.

-- 
Felipe Contreras
