From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: brightness control on thinkpad t61p
Date: Mon, 7 Jan 2008 19:48:33 +0000
Message-ID: <20080107194833.GA22506@srcf.ucam.org>
References: <20071223000057.739d5891.akpm@linux-foundation.org> <20071224073406.GA1018@srcf.ucam.org> <20071226141027.6d1a509f.akpm@linux-foundation.org> <20071226222321.GA32297@srcf.ucam.org> <20071227123358.GB25535@khazad-dum.debian.net> <20080107013623.GA6667@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:41656 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbYAGTsp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jan 2008 14:48:45 -0500
Content-Disposition: inline
In-Reply-To: <20080107013623.GA6667@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Sun, Jan 06, 2008 at 11:36:23PM -0200, Henrique de Moraes Holschuh wrote:

> Bah, I spoke too soon.  Latest round of BIOSes seems to have broken this,
> either that or I completely misunderstood the older AML code.
> 
> Rounding to the nearest supplied _BCL value before we call _BCM apparently
> will be needed on thinkpads as well.

We should just stop exposing the 0-100 range, and instead map it into a 
contiguous (smaller) range. I've posted a patch to do that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
