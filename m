From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: brightness control on thinkpad t61p
Date: Tue, 8 Jan 2008 15:17:35 +0000
Message-ID: <20080108151734.GA3761@srcf.ucam.org>
References: <20071226141027.6d1a509f.akpm@linux-foundation.org> <20071226222321.GA32297@srcf.ucam.org> <20071227123358.GB25535@khazad-dum.debian.net> <20080107013623.GA6667@khazad-dum.debian.net> <20080107194833.GA22506@srcf.ucam.org> <20080108003246.GA15587@khazad-dum.debian.net> <20080108004559.GA27177@srcf.ucam.org> <20080108120653.GA23216@khazad-dum.debian.net> <20080108121819.GA1324@srcf.ucam.org> <20080108124820.GB23216@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:50715 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812AbYAHPRt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jan 2008 10:17:49 -0500
Content-Disposition: inline
In-Reply-To: <20080108124820.GB23216@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Richard Purdie <rpurdie@rpsys.net>

On Tue, Jan 08, 2008 at 10:48:20AM -0200, Henrique de Moraes Holschuh wrote:

> Heck, back to the video.c driver, you shouldn't even assume _BCL gives you a
> sorted list after the second element.  I admit it takes an special kind of
> weird firmware to screw with _BCL like that, but the ACPI spec doesn't
> mandate it, it just says that the OSPM will cycle through the values
> returned by _BCL, but nowhere does it define HOW one cycles through those...

Sorting the list is hardly a problem - we can clearly do it if 
necessary.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
