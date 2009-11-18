From: Rocky Craig <rocky.craig@hp.com>
Subject: Re: [Openipmi-developer] IPMI device discovery [was Re: [PATCH ]
 IPMI:	Locate the IPMI system interface in ACPI namespace]
Date: Wed, 18 Nov 2009 13:40:57 -0700
Message-ID: <4B045BD9.8070906@hp.com>
References: <1258363089-26881-1-git-send-email-yakui.zhao@intel.com>	<200911170759.06902.bjorn.helgaas@hp.com>	<1258515715.3813.108.camel@localhost.localdomain> <200911180945.45570.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:41106 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315AbZKRUjI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2009 15:39:08 -0500
In-Reply-To: <200911180945.45570.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: ykzhao <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, Myron Stowe <myron.stowe@hp.com>, "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>

Bjorn Helgaas emitted:

> I think the only reason
> the SPMI table exists at all is to allow an OS to find an IPMI system
> interface during early boot, before the OS is prepared to parse the
> ACPI namespace. 

Correct.  This was driven by HP-UX as an extension to both ACPI and
IPMI specifications.  The HP-UX kernel is "IPMI-aware" (specifically,
writing the SEL) whereas Linux is not.

> Anything described by the SPMI should also be described in the namespace.

I believe that distinction/request/requirement was lost "back in the day".

> Linux does not need to use IPMI during that early boot phase, so I
> think the SPMI detection should be dropped completely, 

I don't know if SPMI caught on with other hardware vendors.  As it is in the
two specifications, dropping it should be given some thought.

Corey, any idea on general SPMI use?

> I have been told that Windows is similar in that it does not use IPMI
> during early boot, and that it does not look at the SPMI table at all,
> so I think relying on the namespace would be fairly safe.

Sounds like a good vote to drop.  Another vote for dropping comes from
incomplete info in the SPMI table regarding interrupt type and polarity.
Relying on SPMI almost forces you to run the driver in polled mode.

Rocky
