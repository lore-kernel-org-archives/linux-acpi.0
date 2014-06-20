From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [RFC v2 1/3] Mailbox: Add support for ACPI
Date: Fri, 20 Jun 2014 21:08:55 +0200
Message-ID: <5207109.Ir8j6FZuiX@wuerfel>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org> <CAJ5Y-eZ0z-SPSn9oxced2GOAw+OA5rC+uq4pCSXh5H2JujPm1g@mail.gmail.com> <CAJ5Y-ebp1rrRwDWCWSqkSpFg0jr4JktzKpBhWQv9jrwxhqndQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:62804 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbaFTTJa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2014 15:09:30 -0400
In-Reply-To: <CAJ5Y-ebp1rrRwDWCWSqkSpFg0jr4JktzKpBhWQv9jrwxhqndQQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, Jassi Brar <jassisinghbrar@gmail.com>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Patch Tracking <patches@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Friday 20 June 2014 14:55:16 Ashwin Chaugule wrote:
> So, in order to get an mbox->dev for ACPI platforms, we'd need an
> entry in the DSDT table. That seems rather pointless, since the DSDT
> is reserved for devices and is supposed to be OS agnostic. Since the
> mailbox controller itself is not really a "device" with a resource
> descriptor, I dont see the point in adding a dummy DSDT entry for the
> sake of getting this `struct device`. Also, I'm told adding new
> entries to this table requires registering a unique 4 character
> identifier and approval from some committees. If there are other ways
> to get this structure I'd like to hear about it.
> 
> The other alternative would be to piggy back on the ACPI CPU detection
> code, which looks for the ACPI0007 device node in the DSDT and use
> that as the mbox controller device. This node is already registered
> and is an established method to detect CPUs. But I'm not sure what
> happens when CPUs are hotplugged off, we surely dont want mailbox
> clients such as PCC to break.

The main question here is whether you expect having to support multiple
mailbox devices in an ACPI system. If you think there is never more than
one, you wouldn't need a DSDT entry, but if you can end up in a situation
where another device needs to specify which mailbox it is using, then
you need that entry anyway.

	Arnd
