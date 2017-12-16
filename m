From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI, APEI, Fix use resource_size
Date: Sat, 16 Dec 2017 11:43:27 +0100
Message-ID: <CAJZ5v0hA9QdAc1_Gwtu+hBGiH8nn84TS0Bwx0Ln4by6UpKDpSg@mail.gmail.com>
References: <1513007072-32020-1-git-send-email-gomonovych@gmail.com>
 <4222319.ltJQ6b6Cov@aspire.rjw.lan> <20171213153857.2cftlirw7vbo5orm@pd.tnic>
 <CAJZ5v0h5AMJkQFm3uHX+DS=tSeYgYq+6=h0b-WP8Y+McSTLc3w@mail.gmail.com>
 <20171214093759.n63hrae6yyug4aml@pd.tnic> <CAJZ5v0jsV3Przvn5LfchbiBQU3HK9G+hW9iOb4cHhzvbiWKPzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45593 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbdLPKn2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Dec 2017 05:43:28 -0500
In-Reply-To: <CAJZ5v0jsV3Przvn5LfchbiBQU3HK9G+hW9iOb4cHhzvbiWKPzA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Vasyl Gomonovych <gomonovych@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Dec 16, 2017 at 11:34 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Dec 14, 2017 at 10:37 AM, Borislav Petkov <bp@alien8.de> wrote:
>> On Thu, Dec 14, 2017 at 12:07:30AM +0100, Rafael J. Wysocki wrote:
>>> Which is exactly why you've got this question at all. ;-)
>>
>> So you're saying, you've got your minions to do review for you - you can
>> lay back and play all managerial now, huh?
>>
>> :-P
>>
>>> OK, let's queue it up for 4.16, then.
>>
>> Yeah, just keep an eye on reports of mapping errors...
>
> This appears to cause sparse to complain:
> drivers/acpi/apei/apei-base.c:509:21: sparse: incorrect type in
> argument 1 (different base types)
>
> It looks like that's a false-positive to me, though.

Ah, OK

It is not a false-positive.

The argument of resource_size() is (const struct resource *) and res
is of type (struct apei_res *).

I'm dropping this one.
