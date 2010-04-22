From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Looking for some pointers on WMI/EC access
Date: Thu, 22 Apr 2010 14:53:36 +0100
Message-ID: <20100422135336.GA31984@srcf.ucam.org>
References: <s2o71cd59b01004200030jfaa10a4bs81e937d2e50b15b0@mail.gmail.com> <1271762498.1537.215.camel@pancake> <m2i71cd59b01004200509ye8fa593xc7bd5b201d484046@mail.gmail.com> <1271853961.1537.1781.camel@pancake> <20100421133305.GA28710@srcf.ucam.org> <1271860206.1537.1914.camel@pancake> <20100421143239.GA484@srcf.ucam.org> <1271924488.3790.25.camel@flunder> <20100422133605.GA31680@srcf.ucam.org> <1271944219.29664.42.camel@pancake.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57650 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382Ab0DVNxl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Apr 2010 09:53:41 -0400
Content-Disposition: inline
In-Reply-To: <1271944219.29664.42.camel@pancake.fritz.box>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Thu, Apr 22, 2010 at 03:50:19PM +0200, Florian Echtler wrote:

> There's 4 dedicated hotkeys. Of these, one generates KEY_F8 for no
> particular reason, one (correctly!) generates KEY_MUTE, one just
> generates an 0x95 event that dies as described before and the fourth one
> (which _does_ work in Splashtop!) does nothing at all.

So two come through the keyboard controller, one generates an EC event 
and one does nothing? I do wonder about firmware engineers sometimes.

> I also think so in general, but in this case, the entire notification
> setup looks like an incredible mess to me. In any other case, I wouldn't
> really bother with the hotkeys, but as this is a tablet PC, the hotkeys
> on the screen side become really important all of a sudden...

Yeah. I'll take a look and see if there's anything obvious.

Thanks,
-- 
Matthew Garrett | mjg59@srcf.ucam.org
