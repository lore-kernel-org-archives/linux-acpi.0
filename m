From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] acpi: mv models with win8 brightness problems from win8 blacklist to use_native_backlight
Date: Thu, 10 Jul 2014 22:21:31 +0200
Message-ID: <3027325.cMgWkAleA5@vostro.rjw.lan>
References: <1402912525-9067-1-git-send-email-hdegoede@redhat.com> <CAFquV7W4Uw=CBqbosVDbvkKKtd=A9Cv3YRgAwPvQrMXYKQnwkA@mail.gmail.com> <53BEAD42.70802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56019 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750988AbaGJUDY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jul 2014 16:03:24 -0400
In-Reply-To: <53BEAD42.70802@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Yidi Lin <yidi.lin@canonical.com>, Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thursday, July 10, 2014 05:12:02 PM Hans de Goede wrote:
> Hi,
> 
> On 07/10/2014 03:40 PM, Yidi Lin wrote:
> > Hi,
> > 
> > The quirk of Dell Inspiron 7737 is not for win8 backlight issue.
> > 
> > Dell Inspiron 7737 will power on immediately after shutdown with win8
> > capability.
> > Disable win8 capability to workaround the issue.
> > 
> > It seems that I add the quirk to the improper segment.
> 
> Yeah a comment that this one was not for a backlight issue would
> have been nice. Still, you managed to catch it in time, which is
> good, thanks for the heads up.
> 
> > Sorry for misleading you.
> 
> NP.
> 
> Rafael, do you want me to do a follow up patch to move the
> Dell Inspiron 7737 entry back, or do you want me to do a V3
> of the patch ?

I'd prefer to get a v3.

Rafael

