From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 06/15] PNP: increase I/O port & memory option address
 sizes
Date: Sun, 01 Jun 2008 23:39:50 +0200
Message-ID: <48431726.1070206@keyaccess.nl>
References: <20080530224853.976744229@ldl.fc.hp.com> <20080530224932.584460616@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:34050 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbYFAVge (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Jun 2008 17:36:34 -0400
In-Reply-To: <20080530224932.584460616@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

On 31-05-08 00:48, Bjorn Helgaas wrote:

> ACPI Address Space Descriptors can be up to 64 bits wide.
> We should keep track of the whole thing when parsing resource
> options, so this patch changes PNP port and mem option
> fields from "unsigned short" and "unsigned int" to
> "resource_size_t".
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Rene Herman <rene.herman@gmail.com>

Rene.
