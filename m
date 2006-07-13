From: Roman Zippel <zippel@linux-m68k.org>
Subject: RE: [patch 4/5] ACPI: disable SBS by default
Date: Fri, 14 Jul 2006 00:11:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0607132330320.12900@scrub.home>
References: <CFF307C98FEABE47A452B27C06B85BB6ECFA23@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from scrub.xs4all.nl ([194.109.195.176]:43693 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030425AbWGMWMP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Jul 2006 18:12:15 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ECFA23@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org, linux-acpi@vger.kernel.org, dtor@insightbb.com, dtor@mail.ru

Hi,

On Sun, 9 Jul 2006, Brown, Len wrote:

> >Default is 'n' when omitted...
> 
> This default stuff seems to be make-work
> without any real value.
> 
> At one time we had default =m to try to show
> what a reasonable usable configuration was.
> These got globally replaced to =y because
> apparently it is taboo to have default =m.
> 
> But =y defaults don't make much sense either,
> particularly if you use =m like most people do.
> 
> The last time we discussed this, Roman suggested
> deleting all the defaults that require human interaction.
> 
> As the concept appears to be meaningless, I'm inclined to agree.

The problem with using defaults is, if something should be enabled, maybe 
it shouldn't be a config option at all or at least be hidden.
In the future this should all be part of an autoconfiguration process, 
where a base configuration is generated from different sources (e.g. a 
script which looks at the current kernel or machine specific default 
config).
The point is that the defaults can depend on a lot of parameters, one of 
which is the user himself and every user likes different defaults. So 
until we have a better autoconfiguration it's better to avoid abusing the 
defaults. The current configuration system is not ready for aunt Tilly 
yet, it would be far better to provide useful help texts to allow the user 
to make reasonable a decision and the majority of the defaults should come 
from a different source anyway (the current kernel configuration) and for 
any new configuration option which can cause a kernel to be unbootable 
should maybe not an option.

bye, Roman
