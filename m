From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 2/2] ACPI: Store NVS state even when entering suspend
 to RAM
Date: Wed, 02 Jun 2010 13:15:35 +0300
Message-ID: <1275473735.11579.25.camel@maxim-laptop>
References: <1275078735-1866-1-git-send-email-mjg@redhat.com>
	 <1275078735-1866-2-git-send-email-mjg@redhat.com>
	 <1275230404.14907.11.camel@maxim-laptop>
	 <20100530145142.GA32078@srcf.ucam.org>
	 <20100602033225.GA6511@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:64811 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793Ab0FBKPp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 06:15:45 -0400
In-Reply-To: <20100602033225.GA6511@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 2010-06-02 at 00:32 -0300, Henrique de Moraes Holschuh wrote: 
> On Sun, 30 May 2010, Matthew Garrett wrote:
> > On Sun, May 30, 2010 at 05:40:04PM +0300, Maxim Levitsky wrote:
> > > Just one note, I am sure somebody will ask for s3_no_nvs option, just
> > > like s4_no_nvs.
> > 
> > I'd be surprised. Better to add the option when we think it's needed.
> 
> Do _all_ Windows versions restore NVS over S3 suspend/resume?

This is very good question, I test it in future (if Matthew Garrett
doesn't beat me to it...)

I have a copy of XP,Vista,Win7, all obtained for free through
Microsoft's  "first dose is always free" university program.


Best regards,
Maxim Levitsky

