From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [Openipmi-developer] IPMI device discovery [was Re: [PATCH ]
	IPMI:	Locate the IPMI system interface in ACPI namespace]
Date: Thu, 19 Nov 2009 19:09:03 +0800
Message-ID: <1258628943.2933.35.camel@localhost.localdomain>
References: <1258363089-26881-1-git-send-email-yakui.zhao@intel.com>
	 <200911180945.45570.bjorn.helgaas@hp.com> <4B045BD9.8070906@hp.com>
	 <200911181419.27238.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55085 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758168AbZKTCUp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Nov 2009 21:20:45 -0500
In-Reply-To: <200911181419.27238.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Rocky Craig <rocky.craig@hp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, Myron Stowe <myron.stowe@hp.com>, "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>

On Thu, 2009-11-19 at 05:19 +0800, Bjorn Helgaas wrote:
> On Wednesday 18 November 2009 01:40:57 pm Rocky Craig wrote:
> > Bjorn Helgaas emitted:
> > 
> > > Anything described by the SPMI should also be described in the namespace.
> > 
> > I believe that distinction/request/requirement was lost "back in the day".
> 
> I disagree that this requirement was lost.  The ACPI spec is regrettably
> vague, but I think it still contains the very general requirement that
> the ACPI namespace should describe everything that cannot be found by a
> standard hardware enumeration mechanism.
The detection of IPMI system interface in ACPI namespace is not defined
in ACPI spec. Instead it is defined in IPMI 2.0 spec. The SPMI detection
is also defined in IPMI 2.0 spec. 

ACPI 4.0 spec only defines that the ACPI aml code can access the BMC
controller. 
> 
> That requirement allows the OS to use a single coherent device
> discovery, driver binding, and resource management scheme to cover
> all these devices.  If we had to deal with all these devices piece-
> meal, with an SPMI table here, an SPCR table there, we'd go more
> mad than we already are.
> 
> There may be firmware that has an SPMI but neglects to put the device
> in the namespace.  In my opinion, that's clearly a defect.  I think
> it's unlikely since Windows relies on the namespace, but it's certainly
> a risk.
> 
> Bjorn

