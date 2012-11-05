From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] gpio / ACPI: add ACPI support
Date: Mon, 05 Nov 2012 14:19:54 +0100
Message-ID: <4684026.MA6h34pt1X@vostro.rjw.lan>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com> <6279158.LZAthHxtvS@vostro.rjw.lan> <CACRpkdb6-YsyiSYoJb+Jea_9NPGe+8Nqy1hkCk=Mjki26S3-Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:55808 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932101Ab2KENPo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Nov 2012 08:15:44 -0500
In-Reply-To: <CACRpkdb6-YsyiSYoJb+Jea_9NPGe+8Nqy1hkCk=Mjki26S3-Zw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, linux-acpi@vger.kernel.org

On Monday, November 05, 2012 02:11:03 PM Linus Walleij wrote:
> On Mon, Nov 5, 2012 at 1:46 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Monday, November 05, 2012 02:14:21 PM Mathias Nyman wrote:
> 
> >> per-chip based numbering sounds saner, but this deals with what we
> >> currently have.
> >
> > And we need something to hook up drivers to right now.
> 
> So speaking of it I have these drivers consuming pinctrl that I need
> to hook up right now and the subsystem maintainers are NACKing
> the patches because they want a centralized solution instead of
> per-driver hooks and I get the red light...
> 
> Do you think they will change their mind and give me green light if
> I tell them I just need to do it right now? ;-)

Well, it's just a matter of fairness to me, actually.

If you allowed somebody to do something in the past, it's simply unfair
to forbid someone else to do a similar thing later, isn't it?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
