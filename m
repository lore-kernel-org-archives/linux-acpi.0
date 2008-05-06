From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] bay: Exit if notify handler cannot be installed
Date: Tue, 6 May 2008 16:20:49 +0100
Message-ID: <20080506162049.237af49c@core>
References: <20080505202508.GA3690@homac>
	<20080506091522.GA4378@homac>
	<1210065811.12668.1.camel@sli10-desk.sh.intel.com>
	<20080506151846.GA22828@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38246 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756239AbYEFPbx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 May 2008 11:31:53 -0400
In-Reply-To: <20080506151846.GA22828@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Shaohua Li <shaohua.li@intel.com>, Holger Macht <hmacht@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Accardi, Kristen C" <kristen.c.accardi@intel.com>

On Tue, 6 May 2008 12:18:46 -0300
Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:

> On Tue, 06 May 2008, Shaohua Li wrote:
> > The bay driver is duplicated with libata, I thought we should delete it.
> > See bug http://bugzilla.kernel.org/show_bug.cgi?id=9526
> 
> The bay driver is currently useless, BUT it should handle a lot of stuff
> libata won't, such as bay batteries, bay floppies, and anything else in
> a bay that is not a hard disk.

The bay driver needs to become a service that hands out bay events to
all the other drivers for that to happen.
