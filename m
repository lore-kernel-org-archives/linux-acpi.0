From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Allow notifications on method execution
Date: Fri, 20 Jun 2008 23:37:03 +0100
Message-ID: <20080620223703.GA19378@srcf.ucam.org>
References: <20080620152227.GA11828@srcf.ucam.org> <20080620193941.GC20498@khazad-dum.debian.net> <20080620195840.GA16284@srcf.ucam.org> <20080620220120.GB3417@khazad-dum.debian.net> <20080620221308.GB18980@srcf.ucam.org> <20080620223344.GC3417@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56934 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbYFTWhG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 18:37:06 -0400
Content-Disposition: inline
In-Reply-To: <20080620223344.GC3417@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi@hmh.eng.br

On Fri, Jun 20, 2008 at 07:33:44PM -0300, Henrique de Moraes Holschuh wrote:

> It works marginally better if one traps the GPE, as that looks a lot
> more like what one gets in a modern thinkpad instead of what one gets
> from the NVRAM (look at the nvram polling code in thinkpad-acpi to
> understand what I mean.  Some not so pretty crap was required in there
> due to deal with loss of information in the VOLUME/MUTE handling...)

Heh. Yeah, that's true.

> Anyway, if we add notifications for normal nodes, please add them for
> GPEs too.

I'll look into that. With luck it'd let us remove polling from some of 
the other laptop hotkey drivers too.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
