From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/3] Mailbox: Add support for PCC mailbox and channels
Date: Thu, 28 Aug 2014 10:39:01 +0200
Message-ID: <2961329.Rr1sZlGzgn@wuerfel>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org> <CAJ5Y-eak9A14z3im_5sgvnqMQDRf5rNgcQNGwDV2aYh_POkLOA@mail.gmail.com> <20140827190902.GR17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:58684 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936406AbaH1IjQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Aug 2014 04:39:16 -0400
In-Reply-To: <20140827190902.GR17528@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Wednesday 27 August 2014 20:09:02 Mark Brown wrote:
> On Wed, Aug 27, 2014 at 09:07:15AM -0400, Ashwin Chaugule wrote:
> > On 27 August 2014 06:27, Mark Brown <broonie@kernel.org> wrote:
> > > On Tue, Aug 26, 2014 at 03:35:36PM -0400, Ashwin Chaugule wrote:
> 
> > >> +static struct mbox_controller *
> > >> +mbox_find_pcc_controller(char *name)
> > >> +{
> > >> +     struct mbox_controller *mbox;
> > >> +     list_for_each_entry(mbox, &mbox_cons, node) {
> > >> +             if (mbox->name)
> > >> +                     if (!strcmp(mbox->name, name))
> > >> +                             return mbox;
> > >> +     }
> > >> +
> > >> +     return NULL;
> > >> +}
> 
> > > This doesn't look particularly PCC specific?
> 
> > Call this mbox_find_controller_by_name() instead?
> 
> That certainly looks like what it's doing.  Probably also make the name
> that gets passed in const while you're at it.

The mailbox API intentionally does not have an interface for
that: you are supposed to get a reference to an mbox controller
from a phandle or similar, not by knowing the name of the controller.

Unfortunately, the three patches that Ashwin posted don't have a
caller for this function, so I don't know what it's actually used for.
Why do we need this function for pcc, and what are the names that
can be passed here?

	Arnd
