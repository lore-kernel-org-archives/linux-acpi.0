From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 11/12] PCI PM: Run-time callbacks for PCI bus type (rev.
 2)
Date: Wed, 6 Jan 2010 14:06:06 -0800
Message-ID: <20100106140606.0bd3e4fd@jbarnes-piketon>
References: <200912272057.10443.rjw@sisk.pl>
	<200912272108.25145.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-29.bluehost.com ([69.89.17.211]:40945 "HELO
	outbound-mail-29.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756286Ab0AFWGM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2010 17:06:12 -0500
In-Reply-To: <200912272108.25145.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Oliver Neukum <oliver@neukum.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Shaohua Li <shaohua.li@intel.com>, Francois Romieu <romieu@fr.zoreil.com>

On Sun, 27 Dec 2009 21:08:24 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Introduce run-time PM callbacks for the PCI bus type.  Make the new
> callbacks work in analogy with the existing system sleep PM
> callbacks, so that the drivers already converted to struct dev_pm_ops
> can use their suspend and resume routines for run-time PM without
> modifications.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

Looks good.

-- 
Jesse Barnes, Intel Open Source Technology Center
