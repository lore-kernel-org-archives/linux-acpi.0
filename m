From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] ACPI: Adjust the return value of _REV on x86
Date: Tue, 24 Mar 2015 12:22:18 -0500
Message-ID: <55119D4A.5050809@dell.com>
References: <1426150247-18309-1-git-send-email-matthew.garrett@nebula.com> <1426363131-14530-1-git-send-email-jason.ekstrand@intel.com> <CAOFGe95CiLcHtzD3Vv-KJoCXfeHCyGa55OBkzHSZMWwdOyLnfg@mail.gmail.com> <20150323120331.GA3007@codeblueprint.co.uk> <5510FB37.6030808@dell.com> <20150324152412.GA4706@codeblueprint.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150324152412.GA4706@codeblueprint.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Jason Ekstrand <jason@jlekstrand.net>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Bard Liao <bardliao@realtek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org


On 03/24/2015 10:24 AM, Matt Fleming wrote:
> On Tue, 24 Mar, at 12:50:47AM, Mario Limonciello wrote:
> Running a recent kernel is the tradeoff to be paid for using brand new
> hardware. I certainly don't expect to be able to install a 4-year old
> version of Fedora on a laptop released this year and have it work
> flawlessly.
Yes, of course older kernels won't include everything, but there are plenty of people out there that don't use (or know how to use) a newer kernel in their distro.  There's enough customers that our support staff will deal with mandate particular (older) kernel versions or particular distros.  Some stuff can certainly be backported into stable and come in the form of updates to those older kernels, but it is indeed a tradeoff.
> Besides, distributions aggressively backport patches for new hardware
> support anyway and you should work with the distribution developers to
> ensure that happens for your hardware. Preferably before it gets
> released.
With the XPS 13 (2015) in particular, we've been working with Canonical for a very long time in planning and development.  Long enough that when the plans w/ our IHV's for the audio to be HDA in Linux were made before this commit even landed:
https://github.com/torvalds/linux/commit/faae404ebdc6bba744919d82e64c16448eb24a36#diff-aa93b5317c200560767b97a9d9301bd8

At that time rt286 I2S wasn't even in the kernel.  Bard didn't start to land it until later that year (https://github.com/torvalds/linux/commit/07cf7cbadb4d97a78be61119a406de8fe446467e). Was it really that crazy to plan Linux to take HDA mode?
> Because, fundamentally, when you make these decisions about Linux in the
> BIOS you're pitting the BIOS and kernel development models against each
> other. What is going to happen when i2s/i2c finally works correctly in
> the kernel and distros? It would seem unlikely that a BIOS update would
> be available to switch everyone to that mode.
>
Once all this I2S development spun up specific to the XPS 13, that's exactly the plan that we had discussed.  Try to get the major distros on board with all the patches that were needed and issue a BIOS update to adjust the behavior.
> I'm sure the audio folks would love to hear about them.
Liam is aware of the details here.  Other than one issue, it optimistically sounds like a majority of the issues will be sorted in the next few weeks on both the kernel and user-space side.
>
> Unless the patch gets backported to stable kernel versions older than
> 4.x. Which is likely.
>
I would like to respectfully ask that this patch not be added to older stable kernel versions.  It will knowingly cause a regression with hardware in the field.  If this isn't an appropriate criteria for avoiding to backport a patch to stable, what is?
