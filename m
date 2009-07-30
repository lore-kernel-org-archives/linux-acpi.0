From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] ACPI: bind workqueues to CPU 0 to avoid SMI corruption
Date: Thu, 30 Jul 2009 11:06:48 -0600
Message-ID: <200907301106.48593.bjorn.helgaas@hp.com>
References: <20090729215425.23674.80263.stgit@bob.kio> <20090730024300.GA30451@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:29625 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbZG3RGu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jul 2009 13:06:50 -0400
In-Reply-To: <20090730024300.GA30451@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wednesday 29 July 2009 08:43:00 pm Shaohua Li wrote:
> On Thu, Jul 30, 2009 at 05:54:25AM +0800, Bjorn Helgaas wrote:
> > On some machines, a software-initiated SMI causes corruption unless the
> > SMI runs on CPU 0.  An SMI can be initiated by any AML, but typically it's
> > done in GPE-related methods that are run via workqueues, so we can avoid
> > the known corruption cases by binding the workqueues to CPU 0.
> > 
> > References:
> >     http://bugzilla.kernel.org/show_bug.cgi?id=13751
> >     https://bugs.launchpad.net/bugs/157171
> >     https://bugs.launchpad.net/bugs/157691
> Good job! Since any AML code can invoke a SMI, I wonder if all ACPICA should be
> limited to run on CPU 0?

I did look into doing that, but I didn't see an easy way to do it.

My first thought was that we could do a set_cpus_allowed() in
acpi_ex_enter_interpreter() and restore in acpi_ex_exit_interpreter().
But of course, those are ACPI CA functions, so to do it without an
ACPI CA change would mean some kind of hook in acpi_os_wait_semaphore(),
and there, we don't know *which* semaphore means "enter interpreter".

So I gave up for now.  But if somebody has a smarter idea, I agree
that it would be nice to at least have the option to run all AML on
CPU 0.

Bjorn
