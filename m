From: Terence Ripperda <tripperda@nvidia.com>
Subject: Re: patch for video.c driver
Date: Fri, 13 Mar 2009 12:36:04 -0500
Message-ID: <20090313173604.GB13342@hygelac>
References: <20090312154741.GA1055@hygelac> <1236910092.2807.103.camel@rzhang-dt> <20090313030030.GA23571@srcf.ucam.org>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.112.145]:4004 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbZCMRlK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Mar 2009 13:41:10 -0400
Content-Disposition: inline
In-Reply-To: <20090313030030.GA23571@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Terence Ripperda <TRipperda@nvidia.com>, "lenb@kernel.org" <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, Mar 12, 2009 at 08:00:30PM -0700, mjg59@srcf.ucam.org wrote:
> On Fri, Mar 13, 2009 at 10:08:12AM +0800, Zhang Rui wrote:
> > On Thu, 2009-03-12 at 23:47 +0800, Terence Ripperda wrote:
> > >  The intent was to follow the same architecture that the
> > > video.ko driver already follows and to make the support generic enough for
> > > many different users. For example, above I mentioned that both NVIDIA and
> > > other vendors have ACPI extension methods, the support we're adding would be
> > > usable by all such vendors.
> > 
> > Makes sense, although the other vendors usually offers a platform
> > specific device rather than a platform specific control method.
> 
> Mm. I don't see any reason for video output switching to be handled in 
> kernel. It's fundamentally behaviour that depends on the user's 
> preferences, so the logical way to handle this is for the event to be 
> sent to userland (as it is currently) and for a userspace agent to then 
> turn this into an xrandr event. The only thing that currently prevents 
> this from working with the binary nvidia drivers is the fact that they 
> don't appear to support xrandr for output control. I'd prefer it if we 
> didn't work around X driver shortcomings by adding interfaces to the 
> kernel.

agreed, but that misunderstands the intent of this patch.

I consider hotkeys as 3 pieces:
- delivery of system event to a control mechanism (sbios/acpi/video.ko)
- control mechanism logic (to decide what to do) (userspace daemon)
- display change actions (xrandr support)

although the later 2 pieces can be common to all platforms, unfortunately
notebook vendors tend to be extremely customized, meaning mechanisms vary
greatly between vendors and even products of a single vendor. in a perfect
world, all vendors would follow the basic mechanism the video.c driver
implements (many do). unfortunately, we don't live in that world.

in the case I'm trying to fix here, a vendor is using the NVIF ACPI
extensions, rather than the DGS/DCS methods. not all vendors use these, but for
the ones that do, there's no other way to get the hotkey information. our fix
here is to update the video.c driver to acknowledge the NVIF methods and pass
the methods on to the userspace daemon.

we were attempting to make the patch more generic than just NVIF. no additional
kernel patches would be necessary. userspace logic to write the method name to
the video.ko is needed (the intent here is that the method name could be NVIF on
nvidia or something else for other vendors). if an NVIF specific approach is
desired, we could clean up the patch to specifically enable NVIF methods.


in terms of the higher level logic layers,

currently the nvidia X driver handles the control logic and display change
actions on our boards. this was written a couple of years ago and due to nothing
else in place at the time. we'd prefer to switch to a more generic mechanism in
line with what the community is working on. my understanding is that there is
work on a daemon that relies on X RandR 1.2. I would like nvidia to get involved
in and support that effort. (and I admit nvidia is behind on getting our X RandR
support up to 1.2)

even once that's done, you'd still need the patch (or a similar patch) I'm
suggesting for this infrastructure to work on NVIF-based platforms. userspace
logic for parsing the NVIF methods would also be needed; I'm working on getting
sign-off to release that IP for general linux support.



> 
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
