From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v3 1/3] Mailbox: Add support for PCC mailbox
 and channels
Date: Tue, 2 Sep 2014 16:15:05 -0400
Message-ID: <CAJ5Y-eakQDGsC8Y=oDsbrm2QAPWZPpAe3P8fMFK+5vH1+hR5xw@mail.gmail.com>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
	<CAJ5Y-eZVQL-2k1XgfFW1_QZb9G_S2d9YLo3PAH1VytvOhDnd-Q@mail.gmail.com>
	<CAJ5Y-eb4e9bC99zF0FCA4MF6F3iAoQWfKqbRznckNsTFEoN_5w@mail.gmail.com>
	<2819816.9eneSBSqnQ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:45301 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200AbaIBUPG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Sep 2014 16:15:06 -0400
Received: by mail-wg0-f50.google.com with SMTP id x12so7341367wgg.21
        for <linux-acpi@vger.kernel.org>; Tue, 02 Sep 2014 13:15:05 -0700 (PDT)
In-Reply-To: <2819816.9eneSBSqnQ@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Mark Brown <broonie@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Arnd,

On 2 September 2014 15:22, Arnd Bergmann <arnd@arndb.de> wrote:
>> > Suppose we create a platform_device for the PCCT (mailbox controller)
>> > and another one for the PCC client (mailbox client). How should the
>> > PCC client(s) identify the mailbox controller without passing a name?
>> > In DT, the "mboxes" field in the client DT entry is all strings with
>> > mailbox controller names.
>
> No, it's not a string at all, it's a phandle, which is more like a
> pointer. We intentionally never match by a global string at all,
> because those might not be unique.

Ok. With PCC, I dont see a way to do this sort of pointer matching.

>
>> > The "index" in mbox_request_channel() picks
>> > up one set of strings. How should this work with PCC? Should we use
>> > the PCC client platform_device->dev->platform_data to store mailbox
>> > controller strings?
>
> I didn't think there was more than one PCC provider, why do you even
> need a string?
>
> For the general case in ACPI, there should be a similar way of looking
> up mailbox providers to what we have in DT, but if I understand you
> correctly, the PCC specification does not allow that.

Right. At least not in a way DT does. PCC clients know if something
needs to be written/read via PCC mailbox and can identify a PCC
subspace. (i.e. Mailbox channel). The PCC mailbox is uniquely
identified/defined in the spec.

#define ACPI_ADR_SPACE_PLATFORM_COMM    (acpi_adr_space_type) 10

So we could use this ID instead of a string and use that to look up
the PCC controller for a PCC client.

>
> Using platform_data would no be helpful, because there is no platform
> code to fill that out on ACPI based systems.

Right. So the question is how do we work around the "mbox->dev" and
"client->dev" expectations in the Mailbox framework for PCC, given
that these tables aren't backed by "struct devices" ?

Thanks,
Ashwin
