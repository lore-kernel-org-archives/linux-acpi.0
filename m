From: Martin Lucina <mato@kotelna.sk>
Subject: Re: [PATCH] panasonic-laptop.c: add support for optical drive
	power control
Date: Mon, 6 Apr 2009 18:22:44 +0200
Message-ID: <20090406162243.GA24791@nodbug.moloch.sk>
References: <20090113163233.GA734@dezo.moloch.sk> <20090114060834.GN4791@prithivi.gnumonks.org> <20090114184227.GC3654@dezo.moloch.sk> <alpine.LFD.2.00.0904050051330.4821@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from chrocht.moloch.sk ([62.176.169.44]:54183 "EHLO mail.moloch.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903AbZDFQnf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Apr 2009 12:43:35 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904050051330.4821@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Harald Welte <laforge@gnumonks.org>, linux-acpi@vger.kernel.org

Harald, Len,

> Harald,
> It's your driver.  What do you what to do with this patch.
> 
> I'd delegate http://patchwork.kernel.org/patch/2372/
> to you, but you don't seem to have a patchwork account yet.

Please don't apply this just yet.  I've recently managed to get hold of
some DSDT dumps from a Panasonic CF-W5 and they've changed the CD power
management methods so as it stands the patch will only work on a CF-W4 (and
possibly older models).

I'm currently trying to get a contact at Panasonic in Japan to see if they
can provide some documentation.  If not, at the very least a more generic
approach that would work would be to call _EJ0 on the OPTD device for power
off, but I've not been able to figure out from the ACPICA documentation how
I can search the device tree for an OPTD device.

Thanks,

-mato
