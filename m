From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 5/5] gpio / ACPI: Add support for ACPI GPIO operation regions
Date: Fri, 14 Mar 2014 11:50:39 +0100
Message-ID: <CACRpkdaoQZ4TTSyAiGuCAseyWd1e7PFGeQ0xjqwJqC=aasVdww@mail.gmail.com>
References: <1394456094-21671-1-git-send-email-mika.westerberg@linux.intel.com>
	<1394456094-21671-6-git-send-email-mika.westerberg@linux.intel.com>
	<CACRpkdY3z-XGHwn5sQKM-8cKYHzr3_40h53032ETN6PaDW779w@mail.gmail.com>
	<1394723102.17925.40.camel@acox1-desk.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:57800 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbaCNKuj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Mar 2014 06:50:39 -0400
Received: by mail-ob0-f175.google.com with SMTP id uy5so2347172obc.20
        for <linux-acpi@vger.kernel.org>; Fri, 14 Mar 2014 03:50:39 -0700 (PDT)
In-Reply-To: <1394723102.17925.40.camel@acox1-desk.ger.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Cox, Alan" <alan.cox@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Mar 13, 2014 at 4:05 PM, Cox, Alan <alan.cox@intel.com> wrote:
>> > +                       gpiod_set_raw_value(desc, !!((1 << i) & *value));
>>
>> What is this? How can the expression !!((1 << i) possibly evaluate to
>> anything else than "true"? I don't get it. Just (desc, *value) seem more
>> apropriate.
>
>
> The expression is !!((1 << i) & *value)
>
> so its the standard C sematic for 'logical and' ? 1 : 0

Hm I missed the first paranthesis when parsing in my head,
all wrong, too bad. Thanks Alan.

Yours,
Linus Walleij
