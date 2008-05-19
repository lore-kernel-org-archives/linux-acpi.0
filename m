From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 3/4] PNP: remove ratelimit on add resource failures
Date: Tue, 20 May 2008 01:15:23 +0200
Message-ID: <48320A0B.7040008@keyaccess.nl>
References: <20080515220726.029505668@ldl.fc.hp.com> <20080515220754.916930897@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:49389 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761119AbYESXVY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 May 2008 19:21:24 -0400
In-Reply-To: <20080515220754.916930897@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

On 16-05-08 00:07, Bjorn Helgaas wrote:

> We used to have a fixed-size resource table.  If a device had
> twenty resources when the table only had space for ten, we didn't
> need ten warnings, so we added the ratelimit.
> 
> Now that we can dynamically allocate new resources, we should
> only get failures if the allocation fails.  That should be
> rare enough that we don't need to ratelimit the messages.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Rene Herman <rene.herman@gmail.com>

Rene

