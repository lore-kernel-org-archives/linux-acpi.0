From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [PATCH v3 1/3] Mailbox: Add support for PCC mailbox and channels
Date: Wed, 03 Sep 2014 16:50:27 +0200
Message-ID: <3269758.LiiZS9ag7d@wuerfel>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org> <5594980.1z2dWMD9C4@wuerfel> <20140903144921.GT29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:53676 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932616AbaICOup (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 10:50:45 -0400
In-Reply-To: <20140903144921.GT29327@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Mark Brown <broonie@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Wednesday 03 September 2014 15:49:21 Mark Brown wrote:
> On Wed, Sep 03, 2014 at 01:23:21PM +0200, Arnd Bergmann wrote:
> > On Tuesday 02 September 2014 16:15:05 Ashwin Chaugule wrote:
> 
> > > Right. At least not in a way DT does. PCC clients know if something
> > > needs to be written/read via PCC mailbox and can identify a PCC
> > > subspace. (i.e. Mailbox channel). The PCC mailbox is uniquely
> > > identified/defined in the spec.
> 
> > > #define ACPI_ADR_SPACE_PLATFORM_COMM    (acpi_adr_space_type) 10
> 
> > > So we could use this ID instead of a string and use that to look up
> > > the PCC controller for a PCC client.
> 
> > I didn't realize this was the case. Does that mean we can treat
> > pcc as a linearly accessible address space the way we do for
> > system memory, pci-config etc?
> 
> > If that works, we should probably just have a regmap for it rather
> > than expose the mailbox API to client drivers.
> 
> A regmap doesn't seem to map very well here - as far as I can tell the
> addresses referred to are mailboxes rather than registers or memory
> addresses.  I could be misunderstanding though.

No, I think you are right. Nevermind then.

	Arnd
