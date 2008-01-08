From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: brightness control on thinkpad t61p
Date: Tue, 8 Jan 2008 15:54:01 +0000
Message-ID: <20080108155401.GA4954@srcf.ucam.org>
References: <20071226222321.GA32297@srcf.ucam.org> <20071227123358.GB25535@khazad-dum.debian.net> <20080107013623.GA6667@khazad-dum.debian.net> <20080107194833.GA22506@srcf.ucam.org> <20080108003246.GA15587@khazad-dum.debian.net> <20080108004559.GA27177@srcf.ucam.org> <20080108120653.GA23216@khazad-dum.debian.net> <20080108121819.GA1324@srcf.ucam.org> <20080108124820.GB23216@khazad-dum.debian.net> <1199807102.6053.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:53079 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbYAHPyN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jan 2008 10:54:13 -0500
Content-Disposition: inline
In-Reply-To: <1199807102.6053.31.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue, Jan 08, 2008 at 03:45:02PM +0000, Richard Purdie wrote:

> I did't get enough context above but I went through the archives and it
> seems this is about linearising backlight values.

Indeed. The ACPI spec provides a range of 0-100, without specifying what 
this actually means (it gives brightness and power consumption as two 
different examples). Implementations are only required to support a 
subset of these, with the others being ignored. The current hook into 
the backlight class exports this range but provides no means for an 
application to determine which values are valid - I'd prefer to just 
flatten the range to remove the holes. Given the lack of standardisation 
in the real meaning of the values, I don't think exporting the 0-100 
range buys us anything.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
