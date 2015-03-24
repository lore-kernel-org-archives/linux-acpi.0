From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Adjust the return value of _REV on x86
Date: Tue, 24 Mar 2015 21:02:33 +0100
Message-ID: <3241492.O6brgYIrX9@vostro.rjw.lan>
References: <1426150247-18309-1-git-send-email-matthew.garrett@nebula.com> <5510FB37.6030808@dell.com> <20150324152412.GA4706@codeblueprint.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150324152412.GA4706@codeblueprint.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Mario Limonciello <mario_limonciello@dell.com>, Jason Ekstrand <jason@jlekstrand.net>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Bard Liao <bardliao@realtek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, March 24, 2015 03:24:12 PM Matt Fleming wrote:
> On Tue, 24 Mar, at 12:50:47AM, Mario Limonciello wrote:
> >
> > Aside from the mistake that was made in A01 ( which has been corrected
> > for the recently released A02 ), the goal of this workaround is to be
> > able to provide a more functional audio solution across a wider
> > user-base.  Supporting HDA audio for Linux means that users from older
> > kernels will still have a mostly working solution and not need to wait
> > for the entire set of I2S kernel and userspace patches to land in
> > their distro of choice.  We can't expect everyone to run the latest
> > kernel just to have working audio.
> 
> Running a recent kernel is the tradeoff to be paid for using brand new
> hardware. I certainly don't expect to be able to install a 4-year old
> version of Fedora on a laptop released this year and have it work
> flawlessly.
> 
> Besides, distributions aggressively backport patches for new hardware
> support anyway and you should work with the distribution developers to
> ensure that happens for your hardware. Preferably before it gets
> released.
> 
> Because, fundamentally, when you make these decisions about Linux in the
> BIOS you're pitting the BIOS and kernel development models against each
> other. What is going to happen when i2s/i2c finally works correctly in
> the kernel and distros? It would seem unlikely that a BIOS update would
> be available to switch everyone to that mode.
> 
> > The entire I2S experience is maturing (thanks Bard), but even in
> > 4.0-rc5 there are still gaps.
> 
> I'm sure the audio folks would love to hear about them.
> 
> > >Non-Windows BIOS code paths are not validated to the same degree as
> > >those traversed by running Windows, which is exactly why we try so hard
> > >to emulate Windows whenever we interact with the BIOS.
> >
> > To be clear - this codepath is activating the Windows 7 audio
> > experience even when Windows 8.1 is detected (Windows 2013 _OSI
> > responds True).  It's still a Windows BIOS codepath and it's still
> > heavily validated.  There are 3 values you'll find in a decompiled
> > DSDT to achieve this in the _REV test block.  2 of them are used to
> > provide inputs into the EC to toggle HDA or I2S mode.  The other
> > modifies what ACPI audio device is presented to the system.  There
> > isn't a special OS type to represent Linux here.  The selected OSTP
> > corresponds to the Windows 7 OS type.
>  
> Thanks, that is clearer and it does address my concerns about Linux-only
> code paths in the BIOS. But the use of _REV is still only exists to
> detect Linux (or more accurately an ACPICA OS), and that's a big issue.
> 
> > In any case, if the _REV patch does land in the kernel, I think (we)
> > Dell will still be mostly happy with the results.  Anything older than
> > 4.x won't contain the the _REV patch and will run in HDA mode.
> 
> Unless the patch gets backported to stable kernel versions older than
> 4.x. Which is likely.

While I agree in general, one comment.

We haven't decided about the patch yet.  We may decide to bump up the _REV
to 6 when ACPI 6 is out instead.

That said the whole using of _REV to special case Linux is broken by design
and should be stopped immediately.  Especially when it is done by comparing
the return value of _REV to a specific number (like 5 or 3).

Rafael
