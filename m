From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI / PM: Move ACPI video resume to a PM notifier
Date: Thu, 4 Mar 2010 00:24:24 +0000
Message-ID: <20100304002424.GA8204@srcf.ucam.org>
References: <201003040125.30091.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45806 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab0CDAY2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2010 19:24:28 -0500
Content-Disposition: inline
In-Reply-To: <201003040125.30091.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Mar 04, 2010 at 01:25:30AM +0100, Rafael J. Wysocki wrote:
> There is a problem with the ACPI video resume routine that it's
> executed before the GPU that may be accessed by it.  To fix this
> issue, move the ACPI video resume to a power management notifier,
> so that it's executed after resuming all devices, including the GPU.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
