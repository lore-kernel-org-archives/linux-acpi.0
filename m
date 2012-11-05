From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] gpio / ACPI: add ACPI support
Date: Mon, 5 Nov 2012 14:11:03 +0100
Message-ID: <CACRpkdb6-YsyiSYoJb+Jea_9NPGe+8Nqy1hkCk=Mjki26S3-Zw@mail.gmail.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
	<CACRpkdYGbNCzV7QOURcEzhrNWv=kbWq+r3i66GtC75Aytso5rw@mail.gmail.com>
	<5097AD9D.7060808@linux.intel.com>
	<6279158.LZAthHxtvS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:47883 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212Ab2KENLE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Nov 2012 08:11:04 -0500
Received: by mail-ea0-f174.google.com with SMTP id c13so2250891eaa.19
        for <linux-acpi@vger.kernel.org>; Mon, 05 Nov 2012 05:11:03 -0800 (PST)
In-Reply-To: <6279158.LZAthHxtvS@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, linux-acpi@vger.kernel.org

On Mon, Nov 5, 2012 at 1:46 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, November 05, 2012 02:14:21 PM Mathias Nyman wrote:

>> per-chip based numbering sounds saner, but this deals with what we
>> currently have.
>
> And we need something to hook up drivers to right now.

So speaking of it I have these drivers consuming pinctrl that I need
to hook up right now and the subsystem maintainers are NACKing
the patches because they want a centralized solution instead of
per-driver hooks and I get the red light...

Do you think they will change their mind and give me green light if
I tell them I just need to do it right now? ;-)

I suggest to take it easy and prolong the deadline, but none of
my business primarily, you will have to go through Grant who is
probably way more reasonable than me.

Yours,
Linus Walleij
