From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 3/3] acpi: Split out custom_method functionality into
 an own driver
Date: Wed, 30 Mar 2011 09:53:32 +0100
Message-ID: <20110330085332.GA28247@srcf.ucam.org>
References: <1301401990-35469-1-git-send-email-trenn@suse.de>
 <1301401990-35469-4-git-send-email-trenn@suse.de>
 <1301450628.31460.116.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39873 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab1C3Ixr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2011 04:53:47 -0400
Content-Disposition: inline
In-Reply-To: <1301450628.31460.116.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, "lenb@kernel.org" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Mar 30, 2011 at 10:03:48AM +0800, Zhang Rui wrote:
> On Tue, 2011-03-29 at 20:33 +0800, Thomas Renninger wrote:
> > With /sys/kernel/debug/acpi/custom_method root can write
> > to arbitrary memory and increase his priveleges, even if
> > these are restricted.
> > 
> Sorry, I don't quite understand.
> 
> This interface just allocates a new piece of memory, copy the asl code
> from user space and then attach it to ACPI namespace.
> 
> can you give more details about how it is misused to increase root's
> privileges please?

Identify the lid switch GPE. Start a shell, and identify the address of 
that processes's capabilities structure. Write some ASL that includes an 
opregion that covers that structure and a GPE handler that writes new 
values to it. Insert via custom_method. Close lid.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
