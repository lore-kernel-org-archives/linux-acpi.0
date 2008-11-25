From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Regression: ACPI AC driver doesn't work on Toshiba Portege R500 (bisected)
Date: Tue, 25 Nov 2008 10:06:49 +0100
Message-ID: <200811251006.50223.rjw@sisk.pl>
References: <200811230053.14211.rjw@sisk.pl> <200811241430.02434.rjw@sisk.pl> <1227576051.15014.305.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:44744 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbYKYJHa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Nov 2008 04:07:30 -0500
In-Reply-To: <1227576051.15014.305.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, walken <walken@zoy.org>

On Tuesday, 25 of November 2008, Zhang Rui wrote:
> On Mon, 2008-11-24 at 21:30 +0800, Rafael J. Wysocki wrote:
> > On Monday, 24 of November 2008, Zhang Rui wrote:
[--snip--]
> >=20
> > Do I understand correctly that you intend to revert commit
> > faee816b1502385dc9bc5abf2960d1cc645844d1 and provide an alternative=
 patch
> > for walken?
> >=20
> First, I think it's safe to revert
> commit =EF=BB=BFfaee816b1502385dc9bc5abf2960d1cc645844d1
> because bug #10503 can not be reproduced in the upstream kernel as a
> result of another commit  49db139955d3392c6c4facf987905d0a9afed581

OK, I'll send the revert of faee816b1502385dc9bc5abf2960d1cc645844d1 to=
 Len
later today.

> Second, if we can make sure all the pci devices won't issue any PMEs
> when the /sys/devices/.../power/wakeup files are "disabled",

It is supposed to work like this.  If it doesn't, then there is a bug t=
hat has
to be fixed.

> then I'd glad to generate another patch which always enables the PCI =
root
> bridge (PNP0A03) GPE, both at runtime and sleep state, just like what=
 we do
> for the buttons.

Please go for it.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
