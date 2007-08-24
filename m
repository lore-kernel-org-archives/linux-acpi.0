From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI video extensions - ACPI vendor specific drivers vs. video module
Date: Fri, 24 Aug 2007 15:09:11 +0100
Message-ID: <20070824140911.GA15085@srcf.ucam.org>
References: <1187344606.8780.845.camel@queen.suse.de> <20070817131853.GA5027@khazad-dum.debian.net> <1187941725.3399.32.camel@prodigy.site> <20070824114825.GA12881@srcf.ucam.org> <1187957423.3404.10.camel@prodigy.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 78-32-9-130.no-dns-yet.enta.net ([78.32.9.130]:53040 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1761094AbXHXOJV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Aug 2007 10:09:21 -0400
Content-Disposition: inline
In-Reply-To: <1187957423.3404.10.camel@prodigy.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, "Starikovskiy, Alexey Y" <astarikovskiy@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>, Mattia Dongili <malattia@linux.it>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>, linux-acpi@vger.kernel.org

On Fri, Aug 24, 2007 at 02:10:23PM +0200, Thomas Renninger wrote:
> On Fri, 2007-08-24 at 12:48 +0100, Matthew Garrett wrote:
> > I'm not sure there's any especially compelling reason. As long as the 
> > platform-specific interfaces still work, there's no reason to prefer the 
> > ACPI interfaces.
> 
> There are some reasons:
>   - If the platform-specific interfaces do not work anymore, it's
>     already too late. E.g. we see this now for 10.3 with the ThinkPad
>     driver.

The driver shouldn't expose functionality that doesn't work.

>   - Code cleanup: It would be great to rip out some duplicate code.
>     Especially the code size growth of the ThinkPad module which now
>     exceeds the 4000 line mark makes me a bit worry how this should
>     stay maintainable (imagine Henrique not doing all the good work
>     there anymore...).

It's not code duplication. Old Thinkpads (and we're talking 2004 here, 
not amazingly old) don't implement the backlight control section of the 
video spec, so removing the functionality from thinkpad-acpi would be a 
regression.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
