From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 03/18] PNP: IORESOURCE_* flags are PNP-specific, not ISA
 PNP-specific
Date: Sat, 14 Jun 2008 10:06:25 +0200
Message-ID: <48537C01.80202@keyaccess.nl>
References: <20080604220933.168145536@ldl.fc.hp.com> <20080604221127.351243617@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:55137 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758273AbYFNKke (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Jun 2008 06:40:34 -0400
In-Reply-To: <20080604221127.351243617@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

On 05-06-08 00:09, Bjorn Helgaas wrote:

> Change comments on the bus-specific IORESOURCE bit definitions
> to indicate the PNP ones are not ISA-specific.  They are used
> by PNPBIOS and PNPACPI in addition to ISAPNP.
> 
> Rene Herman <rene.herman@gmail.com> wrote this patch:
>     http://marc.info/?l=linux-acpi&m=121200787202959&w=4.
> I picked it up to resolve conflicts with other patches.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Rene Herman <rene.herman@gmail.com>

Rene.

