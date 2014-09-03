From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [PATCH v3 1/3] Mailbox: Add support for PCC mailbox and channels
Date: Wed, 03 Sep 2014 17:27:18 +0200
Message-ID: <3014220.200vGHmhs3@wuerfel>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org> <20140902230331.GF29327@sirena.org.uk> <CAJ5Y-eYNDeFDKj=4BUr4PdLDuZQjsbOisdwbtbxGQC9TsJpsgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:54481 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbaICP1Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 11:27:24 -0400
In-Reply-To: <CAJ5Y-eYNDeFDKj=4BUr4PdLDuZQjsbOisdwbtbxGQC9TsJpsgA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Wednesday 03 September 2014 11:23:21 Ashwin Chaugule wrote:
> On 2 September 2014 19:03, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Sep 02, 2014 at 04:15:05PM -0400, Ashwin Chaugule wrote:
> >
> >> > Using platform_data would no be helpful, because there is no platform
> >> > code to fill that out on ACPI based systems.
> >
> >> Right. So the question is how do we work around the "mbox->dev" and
> >> "client->dev" expectations in the Mailbox framework for PCC, given
> >> that these tables aren't backed by "struct devices" ?
> >
> > As previously suggested just looking things up in the context of a
> > device created to represent the PCC controller seems fine; clients know
> > they're using PCC so can just call a PCC specific API which hides the
> > mechanics from them (for example, using a global variable to store the
> > device).
> 
> IIUC, this means, either modifying the existing
> mbox_controller_register() to know when a PCC mbox is being added, or
> have another PCC specific API for registering as a mailbox? Then, in
> the PCC specific API that requests a PCC channel, depending on what we
> do in the registration path, this function can pick out the PCC
> mailbox pointer and try_module_get(mbox->dev..). Since this is PCC
> specific anyway, we don't need the client->dev argument at all. Did I
> understand you correctly?

Yes, I think this would be reasonable. 

	Arnd
