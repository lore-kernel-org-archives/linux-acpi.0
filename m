From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [git pull request] ACPI and driver patches for 2.6.33.merge
Date: Wed, 23 Dec 2009 08:56:37 +0800
Message-ID: <20091223005637.GA16783@sli10-desk.sh.intel.com>
References: <alpine.LFD.2.00.0912161453480.10371@localhost.localdomain>
 <86802c440912171728s27dd7108k85a0f1563660c95b@mail.gmail.com>
 <20091218022112.GA30333@sli10-desk.sh.intel.com>
 <20091218051457.GB417@elte.hu>
 <4B309AB9.7030208@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751835AbZLWA4n@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B309AB9.7030208@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, "Barnes, Jesse" <jesse.barnes@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 22, 2009 at 06:08:57PM +0800, Yinghai Lu wrote:
> Ingo Molnar wrote:
> > * Shaohua Li <shaohua.li@intel.com> wrote:
> > 
> >> On Fri, Dec 18, 2009 at 09:28:50AM +0800, Yinghai Lu wrote:
> >>> On Wed, Dec 16, 2009 at 12:06 PM, Len Brown <lenb@kernel.org> wrote:
> >>>> Hi Linus,
> >>>>
> >>>> please pull from:
> >>>>
> >>>> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> >>>>
> >>> ;..
> >>>> Shaohua Li (3):
> >>>> ? ? ?ACPI: Add a generic API for _OSC -v2
> >>>> ? ? ?ACPI: cleanup pci_root _OSC code.
> >>>> ? ? ?ACPI: Add platform-wide _OSC support.
> >>> it seems these three patches broke the _OSC on my intel new systems.
> >>>
> >>> revert them fix the problem with AER and pciehp and etc
> >> can you give more details? I just cleaned up the _OSC code for AER and 
> >> pciehp, no function changes.
> > 
> > Famous last words ;-)
> > 
> > Yinghai, i suspect Shaohua needs the kind of info you'd need if you tried to 
> > fix it: acpidump, before/after debug boot log, a description of what goes bad, 
> > etc.
> 
> the so called clean up, change the ret length checking.
> 
> -       if (!output.length)
> -               return AE_NULL_OBJECT;
> -
> 
> +       /* return buffer should have the same length as cap buffer */
> +       if (context->ret.length != context->cap.length)
> +               return AE_NULL_OBJECT;
Wield BIOS. ACPI spec does mention the return buffer have the same length.
Does changing the check back make the issue go away?

Thanks,
Shaohua
