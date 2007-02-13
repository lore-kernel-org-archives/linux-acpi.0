From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop: allow complex per-value input/output validation
Date: Tue, 13 Feb 2007 16:49:56 +0100
Message-ID: <20070213154956.GE5174@inferi.kami.home>
References: <20070212210107.GA5577@inferi.kami.home> <200702122355.56336.lenb@kernel.org> <49660.85.47.20.193.1171356477.squirrel@picard.linux.it> <1171357148.6028.5.camel@localhost.localdomain> <50157.85.47.20.193.1171358948.squirrel@picard.linux.it> <20070213121659.GA25171@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from MTA068A.interbusiness.it ([85.37.17.68]:22430 "EHLO
	MTA068A.interbusiness.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbXBMP4S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 10:56:18 -0500
Content-Disposition: inline
In-Reply-To: <20070213121659.GA25171@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Len Brown <lenb@kernel.org>

On Tue, Feb 13, 2007 at 10:16:59AM -0200, Henrique de Moraes Holschuh wrote:
> On Tue, 13 Feb 2007, Mattia Dongili wrote:
> > well this is actually hardware driven, the brightness_default in
> > sony-laptop only exposes a DSDT method to set this value.
> > So it's actually one more feature, not a software trick :)
> > I admit the attribute could be better named 'poweron_brightness'.
> 
> ThinkPads can also do this, if we keep their CMOS up-to-date (which we do,
> currently).  The solution taken by ibm-acpi is to set the power-on
> brightness at every brighness change, so the machine powers up in the last
> state it was left in.

yes, that's the same as in windows. And actually something I did think
about the same to get rid of the brighness_default stuff, but I'm not
really convinced it's a nice behaviour, maybe as a configurable option.

Anyway, I still believe it could be nice to implement it as a general
interface in the backlight subsys.

Let's see if I can prepare a patch :)
-- 
mattia
:wq!
