From: Patrick Mochel <mochel@linux.intel.com>
Subject: Re: [patch 1/3] acpi: dock driver
Date: Wed, 19 Apr 2006 11:06:22 -0700
Message-ID: <20060419180621.GA15072@linux.intel.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4200B79@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:35561 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750725AbWDSSKK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Apr 2006 14:10:10 -0400
Content-Disposition: inline
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A4200B79@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, greg@kroah.com, linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, arjan@linux.intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz, temnota@kmv.ru

[ Bouncing sgi address dropped. ] 

On Wed, Apr 19, 2006 at 10:51:18AM -0700, Moore, Robert wrote:
> 
> Architecturally, this was the design of ACPICA -- that anything
> OS-dependent would be written in whatever format/style/exception
> model/threading model/blah as the host OS.
> 
> We even discussed having an interface layer in order to translate
> incoming requests (to ACPICA) from the host drivers to ACPICA requests,
> and then translate the output (such as exception codes) back to the host
> format, but we ended up deciding that this was overkill. 

I don't think it needs to be formally defined, but it happens by default with
e.g. drivers/acpi/utils.c. But, they don't do any translation per se; they 
keep the same semantics that the CA exposes. Over time, these can be converted
to provide a stronger barrier between the CA and the Linuxy stuff, but I
don't think we much formality beyond a few rules of guidance. 

Besides the error namespace and the debug functions, what are other things
off the top of your head that should be contained within the CA and the OSL
layers?

Thanks,


	Pat
