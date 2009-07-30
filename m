From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH] ACPI: bind workqueues to CPU 0 to avoid SMI corruption
Date: Thu, 30 Jul 2009 10:43:00 +0800
Message-ID: <20090730024300.GA30451@sli10-desk.sh.intel.com>
References: <20090729215425.23674.80263.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:27588 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457AbZG3CnB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jul 2009 22:43:01 -0400
Content-Disposition: inline
In-Reply-To: <20090729215425.23674.80263.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Jul 30, 2009 at 05:54:25AM +0800, Bjorn Helgaas wrote:
> On some machines, a software-initiated SMI causes corruption unless the
> SMI runs on CPU 0.  An SMI can be initiated by any AML, but typically it's
> done in GPE-related methods that are run via workqueues, so we can avoid
> the known corruption cases by binding the workqueues to CPU 0.
> 
> References:
>     http://bugzilla.kernel.org/show_bug.cgi?id=13751
>     https://bugs.launchpad.net/bugs/157171
>     https://bugs.launchpad.net/bugs/157691
Good job! Since any AML code can invoke a SMI, I wonder if all ACPICA should be
limited to run on CPU 0?
