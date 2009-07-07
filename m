From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
Date: Tue, 07 Jul 2009 10:26:20 +0200
Message-ID: <1246955180.8143.112.camel@twins>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com>
	 <1245825558.19816.1861.camel@twins>
	 <20090624074703.GA28458@sli10-desk.sh.intel.com>
	 <1245830585.31755.11.camel@twins>
	 <alpine.LFD.2.00.0906241239440.20716@localhost.localdomain>
	 <1246002370.31755.187.camel@twins>
	 <alpine.LFD.2.00.0906261209370.4148@localhost.localdomain>
	 <20090630080229.GA23296@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from viefep16-int.chello.at ([62.179.121.36]:60268 "EHLO
	viefep16-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808AbZGGI2I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jul 2009 04:28:08 -0400
In-Reply-To: <20090630080229.GA23296@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "andi@firstfloor.org" <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>

On Tue, 2009-06-30 at 16:02 +0800, Shaohua Li wrote:
> Peter/Len,
> is it ok to push the driver to 2.6.31? It's driver specific and
> should not impact others.

I still think this is utterly the wrong thing to do, therefore I will
not ack this.

