From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH ] IPMI: Locate the IPMI system interface in ACPI
	namespace
Date: Wed, 18 Nov 2009 11:41:55 +0800
Message-ID: <1258515715.3813.108.camel@localhost.localdomain>
References: <1258363089-26881-1-git-send-email-yakui.zhao@intel.com>
	 <200911161051.33492.bjorn.helgaas@hp.com>
	 <1258419550.3813.30.camel@localhost.localdomain>
	 <200911170759.06902.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12663 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbZKRDom (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Nov 2009 22:44:42 -0500
In-Reply-To: <200911170759.06902.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "minyard@acm.org" <minyard@acm.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-11-17 at 22:59 +0800, Bjorn Helgaas wrote:
> On Monday 16 November 2009 05:59:10 pm ykzhao wrote:
> > On Tue, 2009-11-17 at 01:51 +0800, Bjorn Helgaas wrote:
> > > On Monday 16 November 2009 02:18:09 am yakui.zhao@intel.com wrote:
> > > > From: Zhao Yakui <yakui.zhao@intel.com>
> > > 
> > > In fact, I gave you detailed feedback on previous versions of this
> > > patch, and you've ignored it all.
> > 
> > Understand what you said. You feedback contains two points.
> > a. Load the Pnp device driver to detect the IPMI device so that we can
> > use the IO/memory resource parse mechanism of PNP device. 
> > b. Load a ACPI device driver to detect the IPMI device
> 
> Yes, you're right.  I'm sorry I forgot that you *did* respond to
> those.  You didn't agree, and that's fine.  I'll post a sample
> patch to make my suggestion more concrete.
Hi, Bjorn
    It is not meaningless to explain viewpoint again. And my explanation
can't make you accept my viewpoint.
    In fact this patch set contains two parts. 
   a. One is to add the support of detection IPMI system interface in
ACPI namespace, which is a complement of ACPI SPMI detection.(SPMI is
the abbreviation of Service Process Management Interface). In my patch I
use the acpi_walk_namepsace directly to detect the IPMI system interface
in ACPI namespace. I try to make two ACPI detection method depend on one
ACPI subsystem instead of the PNP subsystem or other subsystem. If you
think that this is not accepted, you can try to using other mechanism.
   b. make it possible to communicate between ACPI aml code and IPMI
subsystem so that the ACPI AML code can access the IPMI system
interface. 

    The first part belongs to the IPMI subsystem. And the second belongs
to ACPI subsystem. As this patch set belongs to the two different
subsystem, we can't assure that they are merged into upstream kernel at
the same time. In such case we will have to assure that the two patches
can work independently. 
   In my test the two patches can work well on one server with the IPMI
system interface defined ACPI namespace. And even when any patch is
applied, the system still can work.(Without the second patch the IPMI
system interface is also detected and registered correctly.  Without the
first patch it is still possible that ACPI AML code can communicate with
the IPMI subsystem.). Even when I add the boot option of "pnpacpi=off",
it still can work.

Hi, Bjorn
   If you think that you can't accept the detection mechanism in my
patch, you can go ahead.
   But you had better not touch the second patch. It is only to do the
communication between the ACPI AML code and IPMI system interface. And
it has no relationship with the IPMI system interface detection.

Thanks. 
   Yakui
> 
> Bjorn
> 
> 

