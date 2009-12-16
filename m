From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Resend PATCH] ACPI: Add the IPMI opregion driver to enable ACPI to access BMC controller
Date: Wed, 16 Dec 2009 08:51:58 -0700
Message-ID: <200912160851.59524.bjorn.helgaas@hp.com>
References: <1260323925-25701-1-git-send-email-yakui.zhao@intel.com> <200912150827.52420.bjorn.helgaas@hp.com> <1260925710.3732.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:14893 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbZLPPwB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 10:52:01 -0500
In-Reply-To: <1260925710.3732.8.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>

On Tuesday 15 December 2009 06:08:30 pm ykzhao wrote:
> On Tue, 2009-12-15 at 23:27 +0800, Bjorn Helgaas wrote:

> > If we want the opregion code only for ACPI devices, the easiest way
> > to accomplish this is to set it up when we discover the ACPI device.
> > It's much harder to do it later, because you have to look through all
> > the IPMI interfaces and figure out which ones are ACPI devices.
> 
> To discover the ACPI device happens very early. So it is inappropriate
> to install the IPMI opregion space handler for ACPI in the phase of
> discovering the ACPI device. 
> 
> But We can put the ACPI detection mechanism in the first order and we
> can record which IPMI smi_info is registered by ACPI mechanism. Then we
> can install the IPMI opregion space handler for the corresponding IPMI
> device.

ipmi_pnp_probe() does not happen very early.  If ipmi_si_intf.c is built
statically, it happens during driver init; otherwise it happens when the
module is loaded.

Either way, I think ipmi_si_intf.c will discover the IPI0001 device
after all the Linux/ACPI core stuff is initialized, so I don't see the
problem with installing the opregion handler immediately.  If you see
a specific problem, please point it out.

Bjorn
