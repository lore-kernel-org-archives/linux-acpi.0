From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v3 1/3] Mailbox: Add support for PCC mailbox
 and channels
Date: Wed, 3 Sep 2014 11:23:21 -0400
Message-ID: <CAJ5Y-eYNDeFDKj=4BUr4PdLDuZQjsbOisdwbtbxGQC9TsJpsgA@mail.gmail.com>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
	<CAJ5Y-eZVQL-2k1XgfFW1_QZb9G_S2d9YLo3PAH1VytvOhDnd-Q@mail.gmail.com>
	<CAJ5Y-eb4e9bC99zF0FCA4MF6F3iAoQWfKqbRznckNsTFEoN_5w@mail.gmail.com>
	<2819816.9eneSBSqnQ@wuerfel>
	<CAJ5Y-eakQDGsC8Y=oDsbrm2QAPWZPpAe3P8fMFK+5vH1+hR5xw@mail.gmail.com>
	<20140902230331.GF29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:41781 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756448AbaICPXX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 11:23:23 -0400
Received: by mail-wg0-f51.google.com with SMTP id l18so8643343wgh.10
        for <linux-acpi@vger.kernel.org>; Wed, 03 Sep 2014 08:23:22 -0700 (PDT)
In-Reply-To: <20140902230331.GF29327@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 2 September 2014 19:03, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 02, 2014 at 04:15:05PM -0400, Ashwin Chaugule wrote:
>
>> > Using platform_data would no be helpful, because there is no platform
>> > code to fill that out on ACPI based systems.
>
>> Right. So the question is how do we work around the "mbox->dev" and
>> "client->dev" expectations in the Mailbox framework for PCC, given
>> that these tables aren't backed by "struct devices" ?
>
> As previously suggested just looking things up in the context of a
> device created to represent the PCC controller seems fine; clients know
> they're using PCC so can just call a PCC specific API which hides the
> mechanics from them (for example, using a global variable to store the
> device).

IIUC, this means, either modifying the existing
mbox_controller_register() to know when a PCC mbox is being added, or
have another PCC specific API for registering as a mailbox? Then, in
the PCC specific API that requests a PCC channel, depending on what we
do in the registration path, this function can pick out the PCC
mailbox pointer and try_module_get(mbox->dev..). Since this is PCC
specific anyway, we don't need the client->dev argument at all. Did I
understand you correctly?

Thanks,
Ashwin
