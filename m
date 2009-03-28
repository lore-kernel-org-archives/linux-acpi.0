From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]  Avoid wiping out pr->performance during preregistering
Date: Fri, 27 Mar 2009 21:15:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903272113550.26419@localhost.localdomain>
References: <20090324134159.4c83b445@dhcp-lab-109.englab.brq.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:36649 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbZC1BPn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2009 21:15:43 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH600E46ZHP9XG1@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 20:15:26 -0500 (CDT)
In-reply-to: <20090324134159.4c83b445@dhcp-lab-109.englab.brq.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>


On Tue, 24 Mar 2009, Stanislaw Gruszka wrote:

> When cpufreq driver call acpi_processor_preregister_performance() , function
> will clean up pr->performance even if there is possibly already registered
> other cpufreq driver. The patch fix this potential problem. It also remove 
> double checks in P domain basic validity code and move these checks to function
> where _PSD data is captured.
> 
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> ---
>  drivers/acpi/processor_perflib.c |   46 +++++++++++++++++--------------------
>  1 files changed, 21 insertions(+), 25 deletions(-)
> 

What failure symptom does the user see before this patch is applied?
Does it merit backporting to .stable?

thanks,
Len Brown, Intel Open Source Technology Center


