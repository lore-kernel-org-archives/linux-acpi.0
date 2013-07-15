From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Tue, 16 Jul 2013 01:56:49 +0200
Message-ID: <3454747.PmElQdFDGy@vostro.rjw.lan>
References: <1373888637-20737-1-git-send-email-oliver@neukum.org> <4740878.DpcUBhhgIN@linux-5eaq.site> <20130715163427.GG1074@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:44015 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757698Ab3GOXq5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jul 2013 19:46:57 -0400
In-Reply-To: <20130715163427.GG1074@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Oliver Neukum <oneukum@suse.de>, Thomas Renninger <trenn@suse.de>, lenb@kernel.org, linux-acpi@vger.kernel.org

On Monday, July 15, 2013 01:34:27 PM Henrique de Moraes Holschuh wrote:
> On Mon, 15 Jul 2013, Oliver Neukum wrote:
> > On Monday 15 July 2013 12:06:11 Henrique de Moraes Holschuh wrote:
> > > On Mon, 15 Jul 2013, Thomas Renninger wrote:
> > > > I would not make it too complicated.
> > > > Sticking to the latest Windows version should be enough for this one.
> > > > What bad should happen if we still try to resume and fail...
> > > 
> > > Hmm, why was that check added in the first place?
> > 
> > Safety.
> > 
> > > If it is useless,
> > > removing it for good is fine.  If it is _not_ useless, we should still do
> > > the checking when not operating in windows-8 firmware mode.
> > 
> > Firmware will only be tested against Windows 8 pretty soon.
> > We'd end up with a gigantic list of exceptions.
> 
> No, we won't.  We can query the ACPI core for the OSI compatibility level
> requested by the firmware, and ignore the test only for win8.
> 
> We still have 10 to 15 years worth of users using non-win8 firmware boxes on
> x86/x86-64.

But what's the risk from removing the check exactly for those systems?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
