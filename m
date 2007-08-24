From: Thomas Renninger <trenn@suse.de>
Subject: Re: ACPI video extensions - ACPI vendor specific drivers vs. video
	module
Date: Fri, 24 Aug 2007 14:10:23 +0200
Message-ID: <1187957423.3404.10.camel@prodigy.site>
References: <1187344606.8780.845.camel@queen.suse.de>
	 <20070817131853.GA5027@khazad-dum.debian.net>
	 <1187941725.3399.32.camel@prodigy.site>
	 <20070824114825.GA12881@srcf.ucam.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34250 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757390AbXHXMWt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 08:22:49 -0400
In-Reply-To: <20070824114825.GA12881@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, "Starikovskiy, Alexey Y" <astarikovskiy@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>, Mattia Dongili <malattia@linux.it>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>, linux-acpi@vger.kernel.org

On Fri, 2007-08-24 at 12:48 +0100, Matthew Garrett wrote:
> On Fri, Aug 24, 2007 at 09:48:45AM +0200, Thomas Renninger wrote:

> > I could imagine that distinguishing can be done through the OSI/_OS (or
> > similar, there are two ACPI functions to identify the OS, the old one is
> > called from OS telling the BIOS which OS is running, the other one is
> > called from BIOS and OS tells which OS are supported IIRC). Maybe if a
> > Vista string is in the game, the video extensions are armed...
> > Maybe there is a specific function the OS must call to make the video
> > extensions work.
> 
> I'm not sure there's any especially compelling reason. As long as the 
> platform-specific interfaces still work, there's no reason to prefer the 
> ACPI interfaces.

There are some reasons:
  - If the platform-specific interfaces do not work anymore, it's
    already too late. E.g. we see this now for 10.3 with the ThinkPad
    driver.
  - If Vista is accessing those functions we should do this also
  - Video module is rather untested and really needs some testing to
    get the "Windows compatibility certificate". If Windows is really
    making use of those functions extensively, this is the driver to
    go for in future.
  - Code cleanup: It would be great to rip out some duplicate code.
    Especially the code size growth of the ThinkPad module which now
    exceeds the 4000 line mark makes me a bit worry how this should
    stay maintainable (imagine Henrique not doing all the good work
    there anymore...).

   Thomas

