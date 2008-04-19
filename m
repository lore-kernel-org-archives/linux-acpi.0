From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 22/53] PNP: factor pnp_init_resource_table() and pnp_clean_resource_table()
Date: Sat, 19 Apr 2008 06:46:01 +0200
Message-ID: <48097909.7010203@keyaccess.nl>
References: <20080418204955.342963315@ldl.fc.hp.com> <20080418205051.704761191@ldl.fc.hp.com> <480920BB.9010506@keyaccess.nl> <200804182157.34313.bjorn.helgaas@hp.com> <48097886.9000907@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754566AbYDSEnQ@vger.kernel.org>
In-Reply-To: <48097886.9000907@keyaccess.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On 19-04-08 06:43, Rene Herman wrote:

> pnp: the driver 'cs4236_isapnp' has been registered
> cs4236_isapnp 01:01.00: driver attached
> cs4236_isapnp 01:01.02: driver attached
> cs4236_isapnp 01:01.03: driver attached
> cs4236_isapnp 01:01.00: too many I/O port resources
> cs4236_isapnp 01:01.00: too many I/O port resources
> cs4236_isapnp 01:01.00: too many I/O port resources
> cs4236_isapnp 01:01.00: too many IRQ resources
> cs4236_isapnp 01:01.00: too many DMA resources
> cs4236_isapnp 01:01.00: too many DMA resources
> cs4236_isapnp 01:01.00: activated

Oh, yes, 01:01.00 has three port resources, 1 IRQ resource and 2 DMA resources.

Rene.
