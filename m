From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH]  Avoid wiping out pr->performance during preregistering
Date: Mon, 30 Mar 2009 10:04:56 +0200
Message-ID: <20090330100456.319fa3c8@dhcp-lab-109.englab.brq.redhat.com>
References: <20090324134159.4c83b445@dhcp-lab-109.englab.brq.redhat.com>
	<alpine.LFD.2.00.0903272113550.26419@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:42856 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202AbZC3ITI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Mar 2009 04:19:08 -0400
In-Reply-To: <alpine.LFD.2.00.0903272113550.26419@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

On Fri, 27 Mar 2009 21:15:23 -0400 (EDT)
Len Brown <lenb@kernel.org> wrote:

> > When cpufreq driver call acpi_processor_preregister_performance() , function
> > will clean up pr->performance even if there is possibly already registered
> > other cpufreq driver. The patch fix this potential problem. It also remove 
> > double checks in P domain basic validity code and move these checks to function
> > where _PSD data is captured.
> > 
> > Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> > ---
> >  drivers/acpi/processor_perflib.c |   46 +++++++++++++++++--------------------
> >  1 files changed, 21 insertions(+), 25 deletions(-)
> > 
> 
> What failure symptom does the user see before this patch is applied?
> Does it merit backporting to .stable?

Nothing destructive, kernel ignore P-states limit requested by BIOS using
ACPI _PPC . I think this patch is not so good candidate for backporting.

Cheers
Stanislaw Gruszka
