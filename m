From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [PATCH v3 1/3] Mailbox: Add support for PCC mailbox and channels
Date: Wed, 03 Sep 2014 13:23:21 +0200
Message-ID: <5594980.1z2dWMD9C4@wuerfel>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org> <2819816.9eneSBSqnQ@wuerfel> <CAJ5Y-eakQDGsC8Y=oDsbrm2QAPWZPpAe3P8fMFK+5vH1+hR5xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:50797 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119AbaICLX2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 07:23:28 -0400
In-Reply-To: <CAJ5Y-eakQDGsC8Y=oDsbrm2QAPWZPpAe3P8fMFK+5vH1+hR5xw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tuesday 02 September 2014 16:15:05 Ashwin Chaugule wrote:
> >
> >> > The "index" in mbox_request_channel() picks
> >> > up one set of strings. How should this work with PCC? Should we use
> >> > the PCC client platform_device->dev->platform_data to store mailbox
> >> > controller strings?
> >
> > I didn't think there was more than one PCC provider, why do you even
> > need a string?
> >
> > For the general case in ACPI, there should be a similar way of looking
> > up mailbox providers to what we have in DT, but if I understand you
> > correctly, the PCC specification does not allow that.
> 
> Right. At least not in a way DT does. PCC clients know if something
> needs to be written/read via PCC mailbox and can identify a PCC
> subspace. (i.e. Mailbox channel). The PCC mailbox is uniquely
> identified/defined in the spec.
> 
> #define ACPI_ADR_SPACE_PLATFORM_COMM    (acpi_adr_space_type) 10
> 
> So we could use this ID instead of a string and use that to look up
> the PCC controller for a PCC client.

I didn't realize this was the case. Does that mean we can treat
pcc as a linearly accessible address space the way we do for
system memory, pci-config etc?

If that works, we should probably just have a regmap for it rather
than expose the mailbox API to client drivers.

	Arnd
