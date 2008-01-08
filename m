From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: brightness control on thinkpad t61p
Date: Tue, 8 Jan 2008 00:45:59 +0000
Message-ID: <20080108004559.GA27177@srcf.ucam.org>
References: <20071223000057.739d5891.akpm@linux-foundation.org> <20071224073406.GA1018@srcf.ucam.org> <20071226141027.6d1a509f.akpm@linux-foundation.org> <20071226222321.GA32297@srcf.ucam.org> <20071227123358.GB25535@khazad-dum.debian.net> <20080107013623.GA6667@khazad-dum.debian.net> <20080107194833.GA22506@srcf.ucam.org> <20080108003246.GA15587@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:43567 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbYAHAqK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jan 2008 19:46:10 -0500
Content-Disposition: inline
In-Reply-To: <20080108003246.GA15587@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, Jan 07, 2008 at 10:32:46PM -0200, Henrique de Moraes Holschuh wrote:

> Should we?  Why?  We lose information doing that.  Instead of a nice linear
> 0-100% brightness scale, you are now back to an 8 or 16-level non-linear
> brightness scale.

The spec makes no guarantees about what that 0-100 range means - it may 
be brightness, power consumption or bonghits. It's really not guaranteed 
to be meaningful, and the backlight class doesn't provide that guarantee 
either.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
