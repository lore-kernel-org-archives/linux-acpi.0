From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sat, 21 Mar 2009 15:32:30 +0900
Message-ID: <20090321063229.GE3834@kamineko.org>
References: <20090319212123.GA24700@srcf.ucam.org> <20090320085213.GC4743@kamineko.org> <20090320140004.GA4882@srcf.ucam.org> <20090321040010.GD3834@kamineko.org> <20090321043513.GA20519@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:55223
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbZCUGch (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Mar 2009 02:32:37 -0400
Content-Disposition: inline
In-Reply-To: <20090321043513.GA20519@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On Sat, Mar 21, 2009 at 04:35:13AM +0000, Matthew Garrett wrote:
> On Sat, Mar 21, 2009 at 01:00:10PM +0900, Mattia Dongili wrote:
> > On Fri, Mar 20, 2009 at 02:00:04PM +0000, Matthew Garrett wrote:
> > > I had one machine where ECON seemed to need to be called explicitly, but 
> > > I can't remember the details now. Calling it probably wouldn't hurt 
> > > anything.
> > 
> > seems to be a TT and Z specific thing though. The DSDT on other models
> > doesn't provide the ECON method.
> 
> Yeah. As I said, I don't think there's any harm in causing it - I think 
> I was getting more promising results from hotkey events in the Z when I 
> called ECON, but I don't have access to that machine right now and never 
> got it finished off.

Sounds reasonable.

> > > The numbers correspond to enabling all events. I couldn't think of any 
> > > reason why we'd only want to enable a subset. The current nc setup code 
> > > seems to enable some events and then disable them again, which I don't 
> > > really understand.
> > 
> > Well, the current sequence was taken from a trace in windows on a Vaio C
> > Type, then it demonstrated to be helpful on other models as well.
> > The SN07[1] method is very different from the Z and TT type to the AR, C,
> > FE, FZ and N so I'm starting to suspect that we're just seeing a new
> > generation of SNC based models. I'll see if some users with older models
> > can give the new sequence a go.
> 
> Looking through, the implementation seems quite different but the 
> functionality seems the same - the newer machines seem to return values 
> directly, whereas older ones tended to trap into SMM. The wireless 
> control (at least, the enumeration call I make) seems to be a noop on 
> these older machines. It /looks/ like we can probably get some sort of 
> versioning information about the interface by calling SN00. I think that 
> would probably be a better approach than using DMI for this.

sure, that DMI whitelist is already annoying in its current shape.
Getting the ACPI tables to tell us what SNC version we are looking at
would be so much better.
I just grepped the DSDTs I have here and this is what I got:
DSDT.c1s.dsl:                    Name (SNI4, 0x344A0001)
DSDT.c71bw.dsl:                    Name (SNI4, 0x344A0001)
DSDT.fe21b.dsl:                    Name (SNI4, 0x334A0000)
DSDT.fe31m.dsl:                    Name (SNI4, 0x334A0000)
DSDT.fe41z.dsl:                    Name (SNI4, 0x334A0000)
DSDT.fe830fe.dsl:                    Name (SNI4, 0x334A0000)
DSDT.fz15.dsl:                    Name (SNI4, 0x374A0000)
DSDT.fz180e.dsl:                    Name (SNI4, 0x374A0000)
DSDT.n370e.dsl:                    Name (SNI4, 0x344A0001)
DSDT.tt11lnb.dsl:                        Store (0x344D0000, Index (CFGI, 0x04))
DSDT.z11awn.dsl:                        Store (0x334D0000, Index (CFGI, 0x04))
DSDT.z11vn.dsl:                        Store (0x334D0000, Index (CFGI, 0x04))
DSDT.z26gn.dsl:                        Store (0x334D0000, Index (CFGI, 0x04))
DSDT.z90s.dsl:                        Store (0x334D0000, Index (CFGI, 0x04))
VGN-AR31S-R0200J6.dsl:                    Name (SNI4, 0x364A0000)
VGN-AR370E-R0200J6.dsl:                    Name (SNI4, 0x364A0000)
VGN-C1S.dsl:                    Name (SNI4, 0x344A0001)
VGN-C1ZB-R0034J4.dsl:                    Name (SNI4, 0x344A0001)
VGN-C240E-R0080J4.dsl:                    Name (SNI4, 0x344A0001)
VGN-C2S-R0080J4.dsl:                    Name (SNI4, 0x344A0001)
VGN-C2Z-R0080J4.dsl:                    Name (SNI4, 0x344A0001)
VGN-FE11H-R0072J3.dsl:                    Name (SNI4, 0x334A0000)
VGN-FE11H-R0074J3.dsl:                    Name (SNI4, 0x334A0000)
VGN-FE11M-R0172J3.dsl:                    Name (SNI4, 0x334A0000)
VGN-FE21M-R0130J3.dsl:                    Name (SNI4, 0x334A0000)
VGN-FE31M.dsl:                    Name (SNI4, 0x334A0000)
VGN-FE41E-R0190J3.dsl:                    Name (SNI4, 0x334A0000)
VGN-FE41M-R0190J3.dsl:                    Name (SNI4, 0x334A0000)
VGN-FE41Z-R0200J3.dsl:                    Name (SNI4, 0x334A0000)
VGN-FE550G-R0074J3.dsl:                    Name (SNI4, 0x334A0000)
VGN-FE590P-R0072J3.dsl:                    Name (SNI4, 0x334A0000)
VGN-FE660G-R0133J3.dsl:                    Name (SNI4, 0x334A0000)
VGN-FE770G-R0173J3.dsl:                    Name (SNI4, 0x334A0000)
VGN-FE830.dsl:                    Name (SNI4, 0x334A0000)
VGN-FE880EH-R0200J3.dsl:                    Name (SNI4, 0x334A0000)
VGN-N130G-R0020J4.dsl:                    Name (SNI4, 0x344A0001)
VGN-N230E-R0070J4.dsl:                    Name (SNI4, 0x344A0001)

SNI4 or CFGI+0x04 is the only differing number and is returned with
SN00(4).

> I've put this into rawhide, so I suspect we'll hear complaints if it 
> breaks things for anybody.

want to try to push your patch to mainline or would you prefer to wait?
IMO pushing it and eventually fixing support for 0x344a000[10] models is
fine. After all your snc_setup code could be easily plugged into the DMI
list for the time being and Z and TT users would be happy.
-- 
mattia
:wq!
