From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: brightness control on thinkpad t61p
Date: Tue, 8 Jan 2008 12:18:20 +0000
Message-ID: <20080108121819.GA1324@srcf.ucam.org>
References: <20071223000057.739d5891.akpm@linux-foundation.org> <20071224073406.GA1018@srcf.ucam.org> <20071226141027.6d1a509f.akpm@linux-foundation.org> <20071226222321.GA32297@srcf.ucam.org> <20071227123358.GB25535@khazad-dum.debian.net> <20080107013623.GA6667@khazad-dum.debian.net> <20080107194833.GA22506@srcf.ucam.org> <20080108003246.GA15587@khazad-dum.debian.net> <20080108004559.GA27177@srcf.ucam.org> <20080108120653.GA23216@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:34290 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbYAHMSa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jan 2008 07:18:30 -0500
Content-Disposition: inline
In-Reply-To: <20080108120653.GA23216@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue, Jan 08, 2008 at 10:06:53AM -0200, Henrique de Moraes Holschuh wrote:

> Is there a *real* technical reason why we can't just round to the nearest?
> That will work well with any firmware, and it will not remove functionality
> from any box, while at the same time plugging the current issues nicely.

Yes. Software makes the assumption that writing a value larger than the 
current value will result in the value increasing, which isn't 
necessarily true if you round it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
