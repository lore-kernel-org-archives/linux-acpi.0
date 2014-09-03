From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [PATCH v3 1/3] Mailbox: Add support for PCC mailbox and channels
Date: Wed, 03 Sep 2014 17:41:20 +0200
Message-ID: <3358546.EZHqfM2Zs3@wuerfel>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org> <CAJ5Y-eYNDeFDKj=4BUr4PdLDuZQjsbOisdwbtbxGQC9TsJpsgA@mail.gmail.com> <20140903153601.GW29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:64381 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932906AbaICPlf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 11:41:35 -0400
In-Reply-To: <20140903153601.GW29327@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Mark Brown <broonie@kernel.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Wednesday 03 September 2014 16:36:01 Mark Brown wrote:
> On Wed, Sep 03, 2014 at 11:23:21AM -0400, Ashwin Chaugule wrote:
> > On 2 September 2014 19:03, Mark Brown <broonie@kernel.org> wrote:
> 
> > > As previously suggested just looking things up in the context of a
> > > device created to represent the PCC controller seems fine; clients know
> > > they're using PCC so can just call a PCC specific API which hides the
> > > mechanics from them (for example, using a global variable to store the
> > > device).
> 
> > IIUC, this means, either modifying the existing
> > mbox_controller_register() to know when a PCC mbox is being added, or
> > have another PCC specific API for registering as a mailbox? Then, in
> 
> Why would you have to do that - can't the PCC specific API manage to
> hide this?

I think that's what Ashwin meant as the 'or' part of the sentence above.

	Arnd
