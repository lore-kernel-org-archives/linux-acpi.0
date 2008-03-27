From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 00/37] PNP resource_table cleanups
Date: Thu, 27 Mar 2008 01:30:16 +0100
Message-ID: <47EAEA98.7010500@keyaccess.nl>
References: <20080326171058.099442579@ldl.fc.hp.com> <200803261842.11023.lenb@kernel.org> <200803261713.03248.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:49334 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbYC0A3A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 20:29:00 -0400
In-Reply-To: <200803261713.03248.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

On 27-03-08 00:13, Bjorn Helgaas wrote:

> Oops, sorry, I forgot to export pnp_get_resource().  I'll post an updated
> patch as a response to the original.  Is that easy for you to handle,
> Len?  If not, let me know what you'd prefer.

Works for me at least. Only had time for a quick test. After applying these, 
my snd-cs4236 driver ISAPnP soundcard is no longer found.

Rene.

