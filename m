From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Mon, 15 Jul 2013 17:35:23 +0200
Message-ID: <4740878.DpcUBhhgIN@linux-5eaq.site>
References: <1373888637-20737-1-git-send-email-oliver@neukum.org> <7120686.9AnYUBdZSM@skinner.arch.suse.de> <20130715150611.GC1074@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46766 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932429Ab3GOPdi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jul 2013 11:33:38 -0400
In-Reply-To: <20130715150611.GC1074@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Thomas Renninger <trenn@suse.de>, lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org

On Monday 15 July 2013 12:06:11 Henrique de Moraes Holschuh wrote:
> On Mon, 15 Jul 2013, Thomas Renninger wrote:

> > I would not make it too complicated.
> > Sticking to the latest Windows version should be enough for this one.
> > What bad should happen if we still try to resume and fail...
> 
> Hmm, why was that check added in the first place?

Safety.

> If it is useless,
> removing it for good is fine.  If it is _not_ useless, we should still do
> the checking when not operating in windows-8 firmware mode.

Firmware will only be tested against Windows 8 pretty soon.
We'd end up with a gigantic list of exceptions.

	Regards
		Oliver

