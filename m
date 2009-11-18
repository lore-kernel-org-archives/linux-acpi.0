From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Openipmi-developer] IPMI device discovery [was Re: [PATCH ] =?iso-8859-1?q?IPMI=3A=09Locate_the_IPMI_system_interface_in_ACPI?=
 =?iso-8859-1?q?_namespace=5D?=
Date: Wed, 18 Nov 2009 14:19:26 -0700
Message-ID: <200911181419.27238.bjorn.helgaas@hp.com>
References: <1258363089-26881-1-git-send-email-yakui.zhao@intel.com> <200911180945.45570.bjorn.helgaas@hp.com> <4B045BD9.8070906@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0187.atlanta.hp.com ([15.193.32.64]:29244 "EHLO
	g6t0187.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbZKRVTW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2009 16:19:22 -0500
In-Reply-To: <4B045BD9.8070906@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rocky Craig <rocky.craig@hp.com>
Cc: ykzhao <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, Myron Stowe <myron.stowe@hp.com>, "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>

On Wednesday 18 November 2009 01:40:57 pm Rocky Craig wrote:
> Bjorn Helgaas emitted:
> 
> > Anything described by the SPMI should also be described in the namespace.
> 
> I believe that distinction/request/requirement was lost "back in the day".

I disagree that this requirement was lost.  The ACPI spec is regrettably
vague, but I think it still contains the very general requirement that
the ACPI namespace should describe everything that cannot be found by a
standard hardware enumeration mechanism.

That requirement allows the OS to use a single coherent device
discovery, driver binding, and resource management scheme to cover
all these devices.  If we had to deal with all these devices piece-
meal, with an SPMI table here, an SPCR table there, we'd go more
mad than we already are.

There may be firmware that has an SPMI but neglects to put the device
in the namespace.  In my opinion, that's clearly a defect.  I think
it's unlikely since Windows relies on the namespace, but it's certainly
a risk.

Bjorn
