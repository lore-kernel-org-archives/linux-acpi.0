From: Ben Widawsky <ben@bwidawsk.net>
Subject: Re: Sluggish performance after resume//Re: Bug Report -
 [Acer Aspire V5-122P] Unable to adjust screen brightness
Date: Tue, 10 Jun 2014 15:54:57 -0700
Message-ID: <20140610225457.GB12721@bwidawsk.net>
References: <5382D5C6.5080001@intel.com>
 <CADNzsyNwvGeeLzM54_CkA4tWCYnNVoRyewuqXx0vXH3t4shWHw@mail.gmail.com>
 <CADNzsyMEi-e6d=zLET6YAtJxsyPmUdWRs6rEDt9xrf9R63uW0Q@mail.gmail.com>
 <5383E68C.9030000@intel.com>
 <CADNzsyMmEtvPeoKgsRyeNrxY2hH8ZJ_xhH5nLmVTtey3ad=jSg@mail.gmail.com>
 <538D2359.4080102@intel.com>
 <CADNzsyPQFwYwfPkFDX5BtpiGBGJM75KK-AJPE-O6YYWehGxUow@mail.gmail.com>
 <539698BF.2010406@intel.com> <20140610165816.GA24290@bwidawsk.net>
 <CADNzsyOZEAitYd5CPAn6eSgRso9ezPFP14ojpsB81LcYn4J96A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CADNzsyOZEAitYd5CPAn6eSgRso9ezPFP14ojpsB81LcYn4J96A@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Lewis Toohey <lewis@toohey.co.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Aaron Lu <aaron.lu@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 10, 2014 at 08:59:32PM +0100, Lewis Toohey wrote:
> On 10 June 2014 17:58, Ben Widawsky <ben@bwidawsk.net> wrote:
> > On Tue, Jun 10, 2014 at 01:33:51PM +0800, Aaron Lu wrote:
> >> +Ben Widawsky & Daniel Vetter
> >>
> >> On 06/09/2014 03:38 PM, Lewis Toohey wrote:
> >> > On 3 June 2014 02:22, Aaron Lu <aaron.lu@intel.com> wrote:
> >> >> On 05/30/2014 09:12 PM, Lewis Toohey wrote:
> >> >>> Aaron
> >> >>>
> >> >>> I am in the process of performing this bisection, however, I need a
> >> >>> bit of advice.
> >> >>>
> >> >>> I have got a mix of results following suspend right through from (i)
> >> >>> system reboot; (ii) "low graphics mode" error; (iii) restore but
> >> >>> sluggish performance; and (iv) restore but *very* sluggish
> >> >>> performance.
> >> >>
> >> >> Is the sluggish performance experienced with a GUI environment?
> >> >>
> >> >>>
> >> >>> What should qualify as a bad commit? Anything other than a "perfect" restore?
> >> >>
> >> >> I think ii/iii/iv all qualify as bad, if there is no such problem
> >> >> in previous kernels. And yes, a perfect restore is expected, assume
> >> >> the system is able to do a perfect restore with old kernels.
> >> >>
> >> >> Thanks,
> >> >> Aaron
> >> >>
> >> >>>
> >> >>> Many thanks
> >> >>>
> >> >
> >> > Hi Aaron
> >> >
> >> > Firstly, yes the sluggish performance I was referring to is
> >> > experienced in the GUI environment. Jerky graphics and CPU fan appears
> >> > to max out and stay there. Old kernels (e.g. the Ubuntu default
> >> > kernel) do not do this and just restore perfectly.
> >> >
> >> > I have completed the bisect as requested. Please find the full log
> >> > below. I am slightly unconvinced, as building the previous commit in
> >> > the log still seems to have the same problem, however, that commit is
> >> > a "merge" and I don't really know what this means.
> >> >
> >> > Many thanks
> >> >
> >> > Bisect Log:
> >> > git bisect start
> >> > # good: [455c6fdbd219161bd09b1165f11699d6d73de11c] Linux 3.14
> >> > git bisect good 455c6fdbd219161bd09b1165f11699d6d73de11c
> >> > # bad: [c9eaa447e77efe77b7fa4c953bd62de8297fd6c5] Linux 3.15-rc1
> >> > git bisect bad c9eaa447e77efe77b7fa4c953bd62de8297fd6c5
> >> > # good: [cd6362befe4cc7bf589a5236d2a780af2d47bcc9] Merge
> >> > git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
> >> > git bisect good cd6362befe4cc7bf589a5236d2a780af2d47bcc9
> >> > # good: [d2b150d0647e055d7a71b1c33140280550b27dd6] Merge tag 'sh-3.15'
> >> > of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
> >> > git bisect good d2b150d0647e055d7a71b1c33140280550b27dd6
> >> > # good: [5fb6b953bb7aa86a9c8ea760934982cedc45c52b]
> >> > include/linux/syscalls.h: add sys_renameat2() prototype
> >> > git bisect good 5fb6b953bb7aa86a9c8ea760934982cedc45c52b
> >> > # bad: [ffddc5fd19b219f557fd4a81168ce8784a4faced] fs/ncpfs/dir.c: fix
> >> > indenting in ncp_lookup()
> >> > git bisect bad ffddc5fd19b219f557fd4a81168ce8784a4faced
> >> > # bad: [978c6050165bba52eab7ef3581d447eb215def77] Merge branch
> >> > 'drm-docs' of ssh://people.freedesktop.org/~danvet/drm into drm-next
> >> > git bisect bad 978c6050165bba52eab7ef3581d447eb215def77
> >> > # bad: [262de1453184f65e5ccfe45790f93d41f7339d49] drm/i915: Directly
> >> > return the vma from bind_to_vm
> >> > git bisect bad 262de1453184f65e5ccfe45790f93d41f7339d49
> >> > # bad: [031994ee8dedfa69d3a7caa43e93f3c282bc38f9] drm/i915: Implement
> >> > WaIncreaseL3CreditsForVLVB0:vlv
> >> > git bisect bad 031994ee8dedfa69d3a7caa43e93f3c282bc38f9
> >> > # bad: [f72d21eddfa900bfa2674195dcc0203e18d0cc62] drm/i915: Place the
> >> > Global GTT VM first in the list of VM
> >> > git bisect bad f72d21eddfa900bfa2674195dcc0203e18d0cc62
> >> > # bad: [d6660add648d10e7e35085d8c7d2653e0f9f61b7] drm/i915: Generalize
> >> > PPGTT init
> >> > git bisect bad d6660add648d10e7e35085d8c7d2653e0f9f61b7
> >> > # bad: [b731d33d05dd5ce6b387cbadb0d9d24cb3732b40] drm/i915: relax
> >> > context alignment
> >> > git bisect bad b731d33d05dd5ce6b387cbadb0d9d24cb3732b40
> >> > # bad: [a7b910789f77afa40ae0816d22339e9d25723c6e] drm/i915: Add vm to
> >> > error BO capture
> >> > git bisect bad a7b910789f77afa40ae0816d22339e9d25723c6e
> >> > # bad: [6e164c3382314a1f63526fa7a4322a17318d0e32] drm/i915: Allow ggtt
> >> > lookups to not WARN
> >> > git bisect bad 6e164c3382314a1f63526fa7a4322a17318d0e32
> >> > # bad: [6f425321e02a1b6c5e90b70f8fab7c140fcaeefb] drm/i915: Don't
> >> > unconditionally try to deref aliasing ppgtt
> >> > git bisect bad 6f425321e02a1b6c5e90b70f8fab7c140fcaeefb
> >> > # bad: [e178f7057b81c87a7ceaae0ca204487b6f7eedcf] drm/i915: Provide
> >> > PDP updates via MMIO
> >> > git bisect bad e178f7057b81c87a7ceaae0ca204487b6f7eedcf
> >> > # first bad commit: [e178f7057b81c87a7ceaae0ca204487b6f7eedcf]
> >> > drm/i915: Provide PDP updates via MMIO
> >> >
> >>
> >> The commit looks like related, I've added the commit author.
> >>
> >> Ben,
> >> Do you have any suggestions? Does the above commit have any chance of
> >> causing sluggish performance problem after a resume?
> >>
> >> Thanks,
> >> Aaron
> >
> > What this comment actually does is use MMIO writes for the page tables
> > after a GPU hang/reset. (What a poorly named commit message).
> >
> > Can you please provide the full dmesg with the drm.debug=0x2?
> >
> 
> Hi Ben
> 
> Thank you for responding.
> 
> Just to verify that I have done this correctly, I added
> "drm.debug=0x2" to the kernel command line (in Grub), booted,
> suspended and resumed, and then ran Dmesg.
> 
> I wasn't sure exactly where to put it, so please find a copy of the output here:
> http://www.toohey.co.uk/dmesg
> 
> I hope that is helpful. If you need any further information please let me know.
> 
> Many thanks
> 
> 
> 

I only see radeon stuff in that dmesg. But you did the right thing to
grub.

-- 
Ben Widawsky, Intel Open Source Technology Center
