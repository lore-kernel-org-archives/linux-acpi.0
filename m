From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [PATCH v10 1/1] Mailbox: Add support for Platform Communication Channel
Date: Tue, 11 Nov 2014 17:33:28 +0100
Message-ID: <2214649.QGmZRRXly3@wuerfel>
References: <CAJ5Y-eYbXT4rfkSXKV+jbAp=LHSZf-CHPyLuPjVdKULixO4PZA@mail.gmail.com> <CAJ5Y-eaaJW6NMSpt83onjDQ8Gr6GH-DbKg_aKxMcjqT=Hrt1sw@mail.gmail.com> <CAJe_ZhcJzC1N4pESC-BTe=MXFJuOw2Pj61TaZEOs52QQHULhSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:50339 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbaKKQdh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2014 11:33:37 -0500
In-Reply-To: <CAJe_ZhcJzC1N4pESC-BTe=MXFJuOw2Pj61TaZEOs52QQHULhSg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Patch Tracking <patches@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "lv.zheng" <lv.zheng@intel.com>

On Tuesday 11 November 2014 19:27:07 Jassi Brar wrote:
> On 11 November 2014 18:32, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> > On 10 November 2014 23:04, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> 
> In even simpler terms.... I prefer controller specific
> encoding(0x50434300) instead of controller specific api
> (pcc_mbox_request_channel).  For a different class of controller, it
> is much cleaner to define a new encoding as compared to another
> xyz_mbox_request_channel() api.

The problem with this approach is that it still leaves the interface
as controller specific, because the client now has to know that it
must pass the PCC identifier instead of an index.

A client driver using DT would just specify to use the first channel
that is defined locally in the "mboxes" properties, so it can ask for

	chan = mbox_request_channel(client, 0);

to get the first channel defined for this client while a driver using
ACPI has to look up the identifier in its own local tables:

	u32 channel_id = this_driver_parse_acpi_and_find_pccid(dev);
	chan = mbox_request_channel(client, channel_id);

which is not the same interface as the first, even if you assume the
channel_id to be globally unique in the system.

Since we will need clients to have a consistent interface across
DT and ACPI, I think the difference in firmware interfaces is better
abstracted in a PCC specific interface. 

The client driver would still need to parse two different firmware
structures, but it would at least have a consistent interface:

	u32 channel_id = of_property_read_u32(dev->of_node, "pccid");
	if (!channel_id)
		channel_id = this_driver_parse_acpi_and_find_pccid(dev);
	chan = mbox_request_channel(client, channel_id);

Alternatively, the driver could use the regular API on DT:

	chan = mbox_request_channel(cl, 0);
	if (!chan) {
		u32 chan_id = this_driver_parse_acpi_and_find_pccid(dev);
		chan = 	mbox_request_channel(client, channel_id);	
	}

For any firmware that we have control over, the mbox_request_channel()
case could even be made to work in ACPI, if we decide to add the
properties we use in DT with the new _DSD method.

	Arnd
