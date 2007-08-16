From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] ACPI: boot correctly with "nosmp" or "maxcpus=0"
Date: Fri, 17 Aug 2007 01:25:56 +0200
Message-ID: <200708170125.57416.ak@suse.de>
References: <200708160332.30732.lenb@kernel.org> <20070816193649.GA16680@bingen.suse.de> <200708161906.47278.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51861 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756095AbXHPX0D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Aug 2007 19:26:03 -0400
In-Reply-To: <200708161906.47278.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Friday 17 August 2007 01:06:47 Len Brown wrote:
> On Thursday 16 August 2007 15:36, Andi Kleen wrote:
> > > @@ -157,10 +162,13 @@ early_param("nosmp", nosmp);
> > >  static int __init maxcpus(char *str)
> > >  {
> > >  	get_option(&str, &max_cpus);
> > > -	return 1;
> > > +	if (max_cpus == 0)
> > > +		disable_ioapic_setup();
> > 
> > I must say I never liked that maxcpus=0 ... does disable the APIC
> > too. There can be situations where you want only a single CPU,
> > but still full APICs because modern systems don't boot without. 
> 
> maxcpus=1 will give you that.
> new kernel-parameters.txt in patch should say this
> (matching what comment in the code says)

Ok.

> The only reason I fixed it instead of changing it per above
> is because people may be used to it in non ACPI configurations
> and get surprised when it doesn't do exactly the same
> thing (or in this case doesn't boot at all) in an ACPI configuration.

Patch is fine for me.

-Andi
