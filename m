From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH]: ACPI: Skip the first two elements in the _BCL package
Date: Wed, 04 Feb 2009 14:06:44 +0800
Message-ID: <1233727604.3684.67.camel@localhost.localdomain>
References: <1233545621.3715.42.camel@localhost.localdomain>
	 <200902031456.39680.trenn@suse.de>
	 <1233712213.3684.46.camel@localhost.localdomain>
	 <alpine.LFD.2.00.0902032319280.5607@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42879 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbZBDFzT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Feb 2009 00:55:19 -0500
In-Reply-To: <alpine.LFD.2.00.0902032319280.5607@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

On Wed, 2009-02-04 at 12:25 +0800, Len Brown wrote:
> 
> --
> Len Brown, Intel Open Source Technology Center
> 
> On Wed, 4 Feb 2009, yakui_zhao wrote:
> 
> > On Tue, 2009-02-03 at 21:56 +0800, Thomas Renninger wrote:
> > > On Monday 02 February 2009 04:33:41 yakui_zhao wrote:
> > > > Subject: ACPI: Skip the first two elements in the _BCL package
> > > > From: Zhao Yakui <yakui.zhao@intel.com>
> > > >    According to the Spec the first two elements in the _BCL package won't
> > > > be regarded as the available brightness level. The first is the brightness
> > > > when full power is connected to the box(It means that the AC adapter is
> > > > plugged). The second is the brightness level when the box is on battery.
> > > >     If the first two elements are still used while finding the next
> > > > brightness level, it will fall back to the lowest level when keeping on
> > > > pressing hotkey. (On some boxes the brightness will be changed twice when
> > > > hotkey is pressed once. One is in the ACPI video driver. The other is
> > > > changed by sys I/F. In the ACPI video driver the first two elements will be
> > > > used while changing the brightness. But the first two elements is skipped
> > > > while using sys I/F. In such case there exists the inconsistency).
> > > >     So he first two elements had better be skipped while showing the
> > > > available brightness or finding the next brightness level.
> > > I remember that Rui pointed me to a brightness level list, which included
> > > a value in AC/battery values which was not in the rest of the list.
> > > I expect simply ignoring battery/AC values is not right.
> 
> > Understand what you said. On some boxes the AC/battery level is not
> > included by the rest brightness level. 
> > From the spec the rest are treated as the list of levels OSPM can cycle
> > through when user toggles(via keystroke) the brightness level of the
> > display. 
> >     If so, the first two elements should be excluded in the available
> > brightness levels for hotkey.
> 
> maybe, maybe not.
> 
> Thomas,
> Do we have an example?
Name (PBCL, Package (0x07)
                        {
                            0x50,
                            0x32,
                            0x14,
                            0x28,
                            0x3C,
                            0x50,
                            0x64
                        })
Method (_BCL, 0, NotSerialized)
 {
       Return (PBCL)
}
> the above info is found in the bug 11166
Of course there exist the same issue on the bug 12037/12450.

> 
> I suspect that users will prever to be able to get to the ac/dc
> brightness via hotkeys rather than having to generate an ac/dc
> event to get to them...
> 
> >     And the first two elements are only used for that the power is
> > switched between AC and battery.  
> >     Right?
> > > I posted a patch a while ago which did:
> > >   - Go through the brightness values and extract from all (including
> > >     AC and battery) unique values
> > >   - Sort them
> > >   - Create a with the data a new list.
> > > Not sure whether this would have worked, but something is still
> > > missing. Currently we do not use battery/AC values, but what if we want
> > > do that, e.g. exporting them to userspace?
> 
> >      In current driver the BIOS flag of the _DOD input argument is zero,
> 
> you mean _DOS bit 2?
Yes. 
> 
> > which means that the BIOS will automatically control the brightness of
> > level when the power is switched between AC and DC. 
> >      
> >      If we expect to change the brightness when switching power between
> > AC and DC, it is necessary to export them to user space. 
> 
> per my previous e-mail, i would recommend that if we export them
> to user-space, that we allow user-space to override them
> and have the kernel simply consume them.  That way things
> would work normall even if user-space is ignorant.
> 
> >      Can we still use the brightness sys I/F to change the brightness
> > for AC/DC? The current sys I/F only exports the available brightness
> > level that can be changed via hotkey. Maybe we should use another I/F to
> > change the brightness for AC/DC.
> 

> yes, i think we'd need to extend the I/F.
> 
It will be harmless that the brightness is changed even when the
_DOS=0(Of course it will be redundant). 
> But the real question is if we want to keep using _DOS=0
> or if we want to try _DOS=4
> If we stick with _DOS=0, then the user-space I/F thing is moot.
> Howver, adding (potentially) missing ac/dc values to the toggle
> list applies in both cases.

> 
> thanks,
> -Len
> 

