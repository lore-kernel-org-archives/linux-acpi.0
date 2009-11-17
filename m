From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH ] IPMI: Locate the IPMI system interface in ACPI namespace
Date: Tue, 17 Nov 2009 08:59:06 -0600
Message-ID: <200911170759.06902.bjorn.helgaas@hp.com>
References: <1258363089-26881-1-git-send-email-yakui.zhao@intel.com> <200911161051.33492.bjorn.helgaas@hp.com> <1258419550.3813.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0187.atlanta.hp.com ([15.193.32.64]:21401 "EHLO
	g6t0187.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbZKQO7D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2009 09:59:03 -0500
In-Reply-To: <1258419550.3813.30.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "minyard@acm.org" <minyard@acm.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Monday 16 November 2009 05:59:10 pm ykzhao wrote:
> On Tue, 2009-11-17 at 01:51 +0800, Bjorn Helgaas wrote:
> > On Monday 16 November 2009 02:18:09 am yakui.zhao@intel.com wrote:
> > > From: Zhao Yakui <yakui.zhao@intel.com>
> > 
> > In fact, I gave you detailed feedback on previous versions of this
> > patch, and you've ignored it all.
> 
> Understand what you said. You feedback contains two points.
> a. Load the Pnp device driver to detect the IPMI device so that we can
> use the IO/memory resource parse mechanism of PNP device. 
> b. Load a ACPI device driver to detect the IPMI device

Yes, you're right.  I'm sorry I forgot that you *did* respond to
those.  You didn't agree, and that's fine.  I'll post a sample
patch to make my suggestion more concrete.

Bjorn


