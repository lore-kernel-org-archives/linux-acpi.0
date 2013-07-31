From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [REGRESSION/PATCH] acpi: blacklist win8 OSI for ASUS Zenbok
 Prime UX31A
Date: Wed, 31 Jul 2013 15:00:10 +0100
Message-ID: <20130731140010.GA24560@srcf.ucam.org>
References: <1375125658-1223-1-git-send-email-felipe.contreras@gmail.com>
 <3453253.oZLO1ChPbL@vostro.rjw.lan>
 <CAMP44s02V_FO1BPJZqo6MB9RMknXYdV7AXDqbJzYHpgK1GUuJw@mail.gmail.com>
 <37178266.QXgbv9rq0i@vostro.rjw.lan>
 <CAMP44s2LqiEGtS72FuTjsHUa1MH2kfaYHmcpNKMmAm2LnbFCCQ@mail.gmail.com>
 <20130731051421.GA15766@srcf.ucam.org>
 <CAMP44s2B=nQLnZm7gyYAJZgt_x3KszRZLUC=fom0t9=Eze+smA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38135 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab3GaOAP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Jul 2013 10:00:15 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2B=nQLnZm7gyYAJZgt_x3KszRZLUC=fom0t9=Eze+smA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Aaron Lu <aaron.lwe@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Jul 31, 2013 at 06:32:47AM -0500, Felipe Contreras wrote:
> On Wed, Jul 31, 2013 at 12:14 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > There's no mechanism for an OS to know whether or not a firmware
> > implementation will actually turn the backlight off at 0, so there's no
> > way the OS can define the lowest backlight state as anything other than
> > "May or may not turn the screen off".
> 
> Yes there is; quirks.

We aren't going to maintain a quirk list in order to support a guarantee 
that was never made. "0" as a backlight level has potentially meant 
"screen off" since the interface was first introduced.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
