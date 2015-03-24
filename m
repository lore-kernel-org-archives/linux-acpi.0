From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: Re: [PATCH] ACPI: Adjust the return value of _REV on x86
Date: Tue, 24 Mar 2015 00:50:47 -0500
Message-ID: <5510FB37.6030808@dell.com>
References: <1426150247-18309-1-git-send-email-matthew.garrett@nebula.com> <1426363131-14530-1-git-send-email-jason.ekstrand@intel.com> <CAOFGe95CiLcHtzD3Vv-KJoCXfeHCyGa55OBkzHSZMWwdOyLnfg@mail.gmail.com> <20150323120331.GA3007@codeblueprint.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150323120331.GA3007@codeblueprint.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Fleming <matt@codeblueprint.co.uk>, Jason Ekstrand <jason@jlekstrand.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Bard Liao <bardliao@realtek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-acpi@vger.kernel.org, lenb@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org


On 03/23/2015 07:04 AM, Matt Fleming wrote:
> On Mon, 16 Mar, at 04:21:51PM, Jason Ekstrand wrote:
> Sadly no, Dell are not doing something useful. Their use of _REV is
> entirely misguided for the same reasons using _OSI(Linux) is discouraged
> in drivers/acpi/osl.c; namely that working around kernel bugs in the
> BIOS is a terrible solution.
Aside from the mistake that was made in A01 ( which has been corrected for the recently released A02 ), the goal of this workaround is to be able to provide a more functional audio solution across a wider user-base.  Supporting HDA audio for Linux means that users from older kernels will still have a mostly working solution and not need to wait for the entire set of I2S kernel and userspace patches to land in their distro of choice.  We can't expect everyone to run the latest kernel just to have working audio.

The entire I2S experience is maturing (thanks Bard), but even in 4.0-rc5 there are still gaps.
>
> Non-Windows BIOS code paths are not validated to the same degree as
> those traversed by running Windows, which is exactly why we try so hard
> to emulate Windows whenever we interact with the BIOS.
To be clear - this codepath is activating the Windows 7 audio experience even when Windows 8.1 is detected (Windows 2013 _OSI responds True).  It's still a Windows BIOS codepath and it's still heavily validated.  There are 3 values you'll find in a decompiled DSDT to achieve this in the _REV test block.  2 of them are used to provide inputs into the EC to toggle HDA or I2S mode.  The other modifies what ACPI audio device is presented to the system.  There isn't a special OS type to represent Linux here.  The selected OSTP corresponds to the Windows 7 OS type.

To my knowledge this is the only platform that we have so far introduced this HDA/I2S design.  It's also the only platform we have used _REV to change something for Linux specifically.  It was a calculated change.  This, among other things that have been found will be considered for upcoming designs.
> The real way to fix this is to add the necessary support and bug fixes
> to the kernel, exactly as Bard (Cc'd) has been doing.
I believe a majority of the kernel work is complete, but from some off kernel mailing list discussions I understand that pulseaudio doesn't understand the control interface that gets used for I2S for jack detection.  UCM can't be used for it.  This leads to a really confusing mixer design that needs a variety of toggles manually changed when headphones or a headset get plugged in.  There have also been some stability problem with audio reported after a few days usage.
>
> P.S If Dell XPS13 owners try this patch and audio isn't magically
> detected, make sure you perform *two* cold boots. There appears to be some
> level of caching going where the last read _REV value is used.
>
In any case, if the _REV patch does land in the kernel, I think (we) Dell will still be mostly happy with the results.  Anything older than 4.x won't contain the the _REV patch and will run in HDA mode. If someone runs a kernel with the _REV patch included, it will likely have most of the more important I2S patches landed at the same time it runs in I2S mode.
