From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 15/15] PNP: convert resource options to single linked list
Date: Wed, 4 Jun 2008 14:50:09 -0600
Message-ID: <200806041450.10576.bjorn.helgaas@hp.com>
References: <20080530224853.976744229@ldl.fc.hp.com> <4845D937.2000205@keyaccess.nl> <4846810B.2030301@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:39557 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbYFDUuH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jun 2008 16:50:07 -0400
In-Reply-To: <4846810B.2030301@keyaccess.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>

On Wednesday 04 June 2008 05:48:27 am Rene Herman wrote:
> On 04-06-08 01:52, Rene Herman wrote:

> ADS7181 in fact might as well delete the IRQ from the dependents and add
> "irq 2/9,10,11 High-Edge Optinal" in front as an independent same as 
> ADS7151. That way, all the cloning can go.

We currently clone for AZT0002 as well as ADS7181.  Can we do the
same for both?  It would be nice to get rid of the cloning code
if we can.

Bjorn


