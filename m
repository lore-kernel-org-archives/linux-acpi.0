From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 00/18] PNP: convert resource options to unified dynamic
 list, v2
Date: Tue, 10 Jun 2008 05:00:13 +0200
Message-ID: <484DEE3D.7000705@keyaccess.nl>
References: <20080604220933.168145536@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:55578 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbYFJDAW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 23:00:22 -0400
In-Reply-To: <20080604220933.168145536@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

On 05-06-08 00:09, Bjorn Helgaas wrote:

> This patch series converts the PNP resource option structures
> to a unified linked list.  This preserves resource order, which
> is important for some devices.  The bulk of the series is in
> the last patch, and it has more a more detailed changelog.
> 
> Rene Herman did some testing of ISA devices and reviewed
> v1 of this series.  I think I addressed all his comments.
> Any comments would be welcome.
> 
> This depends on some patches that are in -mm, but not yet
> upstream.  In mmotm, these would probably go after
> pnp-dont-sort-by-type-in-sys-resources.patch

Perhaps it would've been different if I'd been a full-blown git wizzard 
but this is getting rather painful to test against mainline. Would it be 
possible for you to repost (privately or publicly) that which this 
depends on against current mainline?

I had to blow away my local trees here and while rebuilding the needed 
manual adjustments were just just enough to make me worry that I'd end 
up with something not entirely correct.

Rene.
