From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 1/4] ACPI: Fix up _PLD methods
Date: Mon, 12 Mar 2012 20:27:43 +0000
Message-ID: <20120312202743.GB22751@srcf.ucam.org>
References: <1331596735-3690-1-git-send-email-mjg@redhat.com>
 <20120312201735.GB24904@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46888 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379Ab2CLU1r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Mar 2012 16:27:47 -0400
Content-Disposition: inline
In-Reply-To: <20120312201735.GB24904@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, lenb@kernel.org

On Mon, Mar 12, 2012 at 01:17:35PM -0700, Greg KH wrote:
> On Mon, Mar 12, 2012 at 07:58:52PM -0400, Matthew Garrett wrote:
> > _PLD is defined as returning a package of buffers, but many implementations
> > simply return a buffer. Fix this up.
> > 
> > (Original patch by Bob Moore <robert.moore@intel.com>)
> > 
> > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > ---
> >  drivers/acpi/acpica/nsrepair.c |   15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> I think this series depends on your previous USB core patch, right?  If
> so, I'd be glad to take all of these through the USB tree if I get an
> ack from Len for the acpi portions.

They do, so probably best for you to take them as long as Len approves.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
