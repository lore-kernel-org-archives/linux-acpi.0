From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI, APEI, Fix use resource_size
Date: Thu, 14 Dec 2017 00:07:30 +0100
Message-ID: <CAJZ5v0h5AMJkQFm3uHX+DS=tSeYgYq+6=h0b-WP8Y+McSTLc3w@mail.gmail.com>
References: <1513007072-32020-1-git-send-email-gomonovych@gmail.com>
 <4222319.ltJQ6b6Cov@aspire.rjw.lan> <20171213153857.2cftlirw7vbo5orm@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f176.google.com ([74.125.82.176]:36182 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdLMXHb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Dec 2017 18:07:31 -0500
In-Reply-To: <20171213153857.2cftlirw7vbo5orm@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vasyl Gomonovych <gomonovych@gmail.com>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Dec 13, 2017 at 4:38 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Wed, Dec 13, 2017 at 01:19:55AM +0100, Rafael J. Wysocki wrote:
>> On Monday, December 11, 2017 4:44:31 PM CET Vasyl Gomonovych wrote:
>> > Use resource_size function on resource object
>> > Underneath __request_region set res->end to start + n - 1
>> > Lets use resourse_size to set value properly.
>> >
>> > Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
>>
>> Boris, what do you think?
>
> So if MAINTAINERS says we review apei stuff, it doesn't mean that you
> should completely stop doing that! :-P

Which is exactly why you've got this question at all. ;-)

> So this looks like a fix to me since it didn't do the + 1 before.
>
> I don't believe this would break any APEI stuff but it should be tested
> a little just in case.

OK, let's queue it up for 4.16, then.
