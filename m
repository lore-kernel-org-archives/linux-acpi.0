From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 4/4] PNP: dont sort by type in /sys/.../resources
Date: Tue, 20 May 2008 01:22:56 +0200
Message-ID: <48320BD0.8010900@keyaccess.nl>
References: <20080515220726.029505668@ldl.fc.hp.com> <20080515220755.127620227@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:55911 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759622AbYESXVK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 May 2008 19:21:10 -0400
In-Reply-To: <20080515220755.127620227@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

On 16-05-08 00:07, Bjorn Helgaas wrote:

> Rather than stepping through all IO resources, then stepping through
> all MMIO resources, etc., we can just iterate over the resource list
> once directly.
> 
> This can change the order in /sys, e.g.,
> 
>     # cat /sys/devices/pnp0/00:07/resources     # OLD
>     state = active
>     io 0x3f8-0x3ff
>     irq 4
> 
>     # cat /sys/devices/pnp0/00:07/resources     # NEW
>     state = active
>     irq 4
>     io 0x3f8-0x3ff
> 
> The old code artificially sorted resources by type; the new code
> just lists them in the order we read them from the ISAPNP hardware
> or the BIOS.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Rene Herman <rene.herman@gmail.com>

Rene.

