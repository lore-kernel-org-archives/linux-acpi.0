From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
Date: Tue, 07 Jul 2009 10:24:54 +0200
Message-ID: <1246955094.8143.110.camel@twins>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com>
	 <1245825558.19816.1861.camel@twins>
	 <20090624074703.GA28458@sli10-desk.sh.intel.com>
	 <1245830585.31755.11.camel@twins>
	 <alpine.LFD.2.00.0906241239440.20716@localhost.localdomain>
	 <1246002370.31755.187.camel@twins>
	 <alpine.LFD.2.00.0906261209370.4148@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from viefep31-int.chello.at ([62.179.121.49]:1434 "EHLO
	viefep31-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808AbZGGI0f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jul 2009 04:26:35 -0400
In-Reply-To: <alpine.LFD.2.00.0906261209370.4148@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Shaohua Li <shaohua.li@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "andi@firstfloor.org" <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>

On Fri, 2009-06-26 at 12:46 -0400, Len Brown wrote:

> We'd like to ship the forced-idle thread as a self-contained driver,
> if possilbe.  Because that would enable us to easily back-port it
> to some enterprise releases that want the feature.  So if we can
> implement this such that it is functional with existing scheduler
> facilities, that would be get us by.  If the scheduler evolves
> and provides a more optimal mechanism in the future, then that is
> great, as long as we don't have to wait for that to provide
> the basic version of the feature.

I don't think we should ever merge anything because of backports for
stale kernels.

If you want it in enterprise stuff all you need is something upstream,
and that something should be the scheduler driven bits.

After that you can argue the full backport isn't possible (should be
quite easy given that enterprise kernels still think kABI is something
sane) and propose this hack for them.

