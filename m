From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sat, 21 Mar 2009 04:35:13 +0000
Message-ID: <20090321043513.GA20519@srcf.ucam.org>
References: <20090319212123.GA24700@srcf.ucam.org> <20090320085213.GC4743@kamineko.org> <20090320140004.GA4882@srcf.ucam.org> <20090321040010.GD3834@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54283 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbZCUEfS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Mar 2009 00:35:18 -0400
Content-Disposition: inline
In-Reply-To: <20090321040010.GD3834@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

On Sat, Mar 21, 2009 at 01:00:10PM +0900, Mattia Dongili wrote:
> On Fri, Mar 20, 2009 at 02:00:04PM +0000, Matthew Garrett wrote:
> > I had one machine where ECON seemed to need to be called explicitly, but 
> > I can't remember the details now. Calling it probably wouldn't hurt 
> > anything.
> 
> seems to be a TT and Z specific thing though. The DSDT on other models
> doesn't provide the ECON method.

Yeah. As I said, I don't think there's any harm in causing it - I think 
I was getting more promising results from hotkey events in the Z when I 
called ECON, but I don't have access to that machine right now and never 
got it finished off.

> > The numbers correspond to enabling all events. I couldn't think of any 
> > reason why we'd only want to enable a subset. The current nc setup code 
> > seems to enable some events and then disable them again, which I don't 
> > really understand.
> 
> Well, the current sequence was taken from a trace in windows on a Vaio C
> Type, then it demonstrated to be helpful on other models as well.
> The SN07[1] method is very different from the Z and TT type to the AR, C,
> FE, FZ and N so I'm starting to suspect that we're just seeing a new
> generation of SNC based models. I'll see if some users with older models
> can give the new sequence a go.

Looking through, the implementation seems quite different but the 
functionality seems the same - the newer machines seem to return values 
directly, whereas older ones tended to trap into SMM. The wireless 
control (at least, the enumeration call I make) seems to be a noop on 
these older machines. It /looks/ like we can probably get some sort of 
versioning information about the interface by calling SN00. I think that 
would probably be a better approach than using DMI for this.

I've put this into rawhide, so I suspect we'll hear complaints if it 
breaks things for anybody.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
