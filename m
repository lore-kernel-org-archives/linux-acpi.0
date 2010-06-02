From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] ACPI: Store NVS state even when entering suspend
	to RAM
Date: Wed, 2 Jun 2010 12:47:09 +0100
Message-ID: <20100602114709.GA32247@srcf.ucam.org>
References: <1275078735-1866-1-git-send-email-mjg@redhat.com> <1275078735-1866-2-git-send-email-mjg@redhat.com> <1275230404.14907.11.camel@maxim-laptop> <20100530145142.GA32078@srcf.ucam.org> <20100602033225.GA6511@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54955 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab0FBLrT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 07:47:19 -0400
Content-Disposition: inline
In-Reply-To: <20100602033225.GA6511@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, Jun 02, 2010 at 12:32:25AM -0300, Henrique de Moraes Holschuh wrote:
> On Sun, 30 May 2010, Matthew Garrett wrote:
> > On Sun, May 30, 2010 at 05:40:04PM +0300, Maxim Levitsky wrote:
> > > Just one note, I am sure somebody will ask for s3_no_nvs option, just
> > > like s4_no_nvs.
> > 
> > I'd be surprised. Better to add the option when we think it's needed.
> 
> Do _all_ Windows versions restore NVS over S3 suspend/resume?

XP does regardless of whether any OSI strings are presented, and we have 
systems that break unless it's done, so I think it's a safe bet.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
