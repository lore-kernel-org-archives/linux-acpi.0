From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] Add support for the generic backlight device to the
	IBM ACPI driver
Date: Wed, 11 Oct 2006 14:59:13 +0200
Message-ID: <1160571553.3000.373.camel@laptopd505.fenrus.org>
References: <20061009113235.GA4444@homac.suse.de>
	 <20061011113042.GA4725@ucw.cz>  <1160571257.4936.7.camel@hughsie-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:47573 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751248AbWJKM7Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Oct 2006 08:59:16 -0400
In-Reply-To: <1160571257.4936.7.camel@hughsie-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com

On Wed, 2006-10-11 at 13:54 +0100, Richard Hughes wrote:
> On Wed, 2006-10-11 at 11:30 +0000, Pavel Machek wrote:
> > Looks okay to me. It would be nice to get this in, so that we teach
> > people to use generic interface, and so that we can remove crappy
> > interfaces in future...
> 
> What about needing a module parameter "enable-old-interface" so by
> default be only support the new interface but can support the legacy one
> if the user is running old userspace stuff? Insane?

not worth the code imo; you're adding code to save some old cruft ;)


