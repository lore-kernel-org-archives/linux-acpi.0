From: Holger Macht <hmacht@suse.de>
Subject: Re: [patch 6/6] acpi dock: terminate eject request is the dock is
 not present
Date: Sun, 11 Jan 2009 17:14:58 +0100
Message-ID: <1231690498.16665.0.camel@homac.suse>
References: <200901092017.n09KHEqd015005@imap1.linux-foundation.org>
	 <alpine.LFD.2.00.0901091607200.16697@localhost.localdomain>
	 <49685167.7050804@mydatex.cz>
Reply-To: hmacht@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58138 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbZAKQPh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Jan 2009 11:15:37 -0500
In-Reply-To: <49685167.7050804@mydatex.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Smolik <marvin@mydatex.cz>
Cc: Len Brown <lenb@kernel.org>, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, rui.zhang@intel.com, shaohua.li@intel.com, stable@kernel.org

Am Samstag, den 10.01.2009, 08:42 +0100 schrieb Daniel Smolik:
> Len Brown napsal(a):
> > The bug report suggest that this patch is not a complete fix for the 
> > issue, so I'd prefer we get a resolution, or at least a better
> > understanding of the failure, before sending patches upstream
> > for this issue.
> >   
> Hi,
> you are right I don't  understand how it works. I only diff dock.c from 
> 2.6.26 to .26.28 and search differences.
> But I apply this patch  5 days ago and dock and undock witout problems 
> as with 2.6.26.

You also tried to eject/insert your bay with this patch applied. This
cannot work, at least not in a clean way.

I'm currently debugging and seem to get the idea what's going wrong. Stay
tuned...

Regards,
	Holger

> 
> Regards
>                       Dan Smolik
> 
> 
> > thanks
> > Len Brown, Intel Open Source Technology Center
> >
> > On Fri, 9 Jan 2009, akpm@linux-foundation.org wrote:
> >
> >   
> >> From: Daniel Smolik <marvin@mydatex.cz>
> >>
> >> Taken from http://bugzilla.kernel.org/show_bug.cgi?id=12360
> >>
> >> nfi if it's right - I merged it so it wouldn't get lost.
> >>
> >> Cc: Zhang Rui <rui.zhang@intel.com>
> >> Cc: Len Brown <lenb@kernel.org>
> >> Cc: "Li, Shaohua" <shaohua.li@intel.com>
> >> Cc: <hmacht@suse.de>
> >> Cc: <stable@kernel.org>		[2.6.26.x, 2.6.27.x, 2.6.28.x]
> >> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >> ---
> >>
> >>  drivers/acpi/dock.c |    3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff -puN drivers/acpi/dock.c~acpi-dock-terminate-eject-request-is-the-dock-is-not-present drivers/acpi/dock.c
> >> --- a/drivers/acpi/dock.c~acpi-dock-terminate-eject-request-is-the-dock-is-not-present
> >> +++ a/drivers/acpi/dock.c
> >> @@ -668,6 +668,9 @@ EXPORT_SYMBOL_GPL(unregister_hotplug_doc
> >>   */
> >>  static int handle_eject_request(struct dock_station *ds, u32 event)
> >>  {
> >> +	if (!dock_present(ds))
> >> +		return -ENODEV;
> >> +
> >>  	if (dock_in_progress(ds))
> >>  		return -EBUSY;
> >>  
> >> _
> >>
> >>     
> 

