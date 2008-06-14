From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 17/18] ISAPNP: handle independent options following dependent
 ones
Date: Sat, 14 Jun 2008 10:39:24 +0200
Message-ID: <485383BC.20404@keyaccess.nl>
References: <20080604220933.168145536@ldl.fc.hp.com> <20080604221130.143096410@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:55077 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbYFNKkO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Jun 2008 06:40:14 -0400
In-Reply-To: <20080604221130.143096410@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

On 05-06-08 00:09, Bjorn Helgaas wrote:

> The ISAPNP spec recommends that independent options precede
> dependent ones, but this is not actually required.  The current
> ISAPNP code incorrectly puts such trailing independent options
> at the end of the last dependent option list.
> 
> This patch fixes that bug by resetting the current option list
> to the independent list when we see an "End Dependent Functions"
> tag.  PNPBIOS and PNPACPI handle this the same way.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Rene Herman <rene.herman@gmail.com>

Rene.

