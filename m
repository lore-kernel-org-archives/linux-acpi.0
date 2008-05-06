From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] bay: Exit if notify handler cannot be installed
Date: Tue, 6 May 2008 19:13:30 +0200
Message-ID: <20080506171330.GB20797@homac>
References: <20080505202508.GA3690@homac> <20080506091522.GA4378@homac> <1210065811.12668.1.camel@sli10-desk.sh.intel.com> <20080506151846.GA22828@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:44848 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755653AbYEFRLU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 May 2008 13:11:20 -0400
Content-Disposition: inline
In-Reply-To: <20080506151846.GA22828@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Accardi, Kristen C" <kristen.c.accardi@intel.com>

On Di 06. Mai - 12:18:46, Henrique de Moraes Holschuh wrote:
> On Tue, 06 May 2008, Shaohua Li wrote:
> > The bay driver is duplicated with libata, I thought we should delete it.
> > See bug http://bugzilla.kernel.org/show_bug.cgi?id=9526
> 
> The bay driver is currently useless, BUT it should handle a lot of stuff
> libata won't, such as bay batteries, bay floppies, and anything else in
> a bay that is not a hard disk.
> 
> The fact that the driver currently looks only after disks is just a bug.
> It should, in fact, bind to any ejectable device not already handled by
> a different driver.

Yes, it still does with my patch.

Regards,
	Holger
