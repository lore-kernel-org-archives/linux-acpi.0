From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 18:16:31 +0000
Message-ID: <20091115181631.GB3013@srcf.ucam.org>
References: <cone.1258203372.445001.1633.1000@eeekiste> <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258285991.924736.2588.1000@eeekiste> <4AFFF7B8.2070508@tuffmail.co.uk> <20091115160201.GC1019@srcf.ucam.org> <4B00283C.3040807@tuffmail.co.uk> <20091115161458.GA1653@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39307 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbZKOSQ3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 13:16:29 -0500
Content-Disposition: inline
In-Reply-To: <20091115161458.GA1653@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: andrej.gelenberg@udo.edu, Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net

On Sun, Nov 15, 2009 at 04:14:58PM +0000, Matthew Garrett wrote:
> On Sun, Nov 15, 2009 at 04:11:40PM +0000, Alan Jenkins wrote:
> 
> > We don't really look at the device though.  What we look at is the value  
> > of WLDG.
> >
> > Stray notifications on either of the _other_ 2 pcie ports would then  
> > cause us to toggle them based on WLDG.
> >
> > I see a _Lxx handler in my DSDT which looks like it notifies on _all_  
> > the pcie ports.  So I think it's a bit tricky.
> 
> We could be smarter about that. WLDG is handy but not required - at the 
> most basic level we could do a pci configuration space access and see if 
> we get back 0xff or a value.

Though, thinking about it, you're right - we still need to know whether 
it was a wifi device so we know whether to update the rfkill status. Do 
Atheros devices still have their PCI class set to ethernet rather than 
wireless?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
