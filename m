From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 2/2] ACPI: Store NVS state even when entering suspend
 to RAM
Date: Wed, 02 Jun 2010 16:06:55 +0300
Message-ID: <1275484015.11772.2.camel@maxim-laptop>
References: <1275078735-1866-1-git-send-email-mjg@redhat.com>
	 <1275078735-1866-2-git-send-email-mjg@redhat.com>
	 <1275230404.14907.11.camel@maxim-laptop>
	 <20100530145142.GA32078@srcf.ucam.org>
	 <20100602033225.GA6511@khazad-dum.debian.net>
	 <20100602114709.GA32247@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:59555 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab0FBNHG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 09:07:06 -0400
In-Reply-To: <20100602114709.GA32247@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 2010-06-02 at 12:47 +0100, Matthew Garrett wrote: 
> On Wed, Jun 02, 2010 at 12:32:25AM -0300, Henrique de Moraes Holschuh wrote:
> > On Sun, 30 May 2010, Matthew Garrett wrote:
> > > On Sun, May 30, 2010 at 05:40:04PM +0300, Maxim Levitsky wrote:
> > > > Just one note, I am sure somebody will ask for s3_no_nvs option, just
> > > > like s4_no_nvs.
> > > 
> > > I'd be surprised. Better to add the option when we think it's needed.
> > 
> > Do _all_ Windows versions restore NVS over S3 suspend/resume?
> 
> XP does regardless of whether any OSI strings are presented, and we have 
> systems that break unless it's done, so I think it's a safe bet.
This laptop was shipped with Vista, and since suspend works I guess its
highly likely that vista does restore NVS this way too.

This only leaves W7. I doubt they would break older systems by fixing a
bug....

Best regards,
Maxim Levitsky

