From: Pingfan Liu <kernelfans@gmail.com>
Subject: Re: [PATCHv2 1/7] x86/mm: concentrate the code to memblock allocator enabled
Date: Tue, 15 Jan 2019 15:06:10 +0800
Message-ID: <CAFgQCTsV13JSH_S2kSQGeUa3K0s_n4LeGqhrHwBEW9DWeCWgcA@mail.gmail.com>
References: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
 <1547183577-20309-2-git-send-email-kernelfans@gmail.com> <96233c0c-940d-8d7c-b3be-d8863c026996@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <96233c0c-940d-8d7c-b3be-d8863c026996@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>, Tejun Heo <tj@kernel.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>, Baoquan He <bhe@redhat.com>, Juergen Gross <jgross@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, x86@kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 15, 2019 at 7:07 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/10/19 9:12 PM, Pingfan Liu wrote:
> > This patch identifies the point where memblock alloc start. It has no
> > functional.
>
> It has no functional ... what?  Effects?
>
During re-organize the code, it takes me a long time to figure out why
memblock_set_bottom_up(true) is added here, and how far can it be
deferred. And finally, I realize that it only takes effect after
e820__memblock_setup(), the point where memblock allocator can work.
So I concentrate the related code, and hope this patch can classify
this truth.

> > -     memblock_set_current_limit(ISA_END_ADDRESS);
> > -     e820__memblock_setup();
> > -
> >       reserve_bios_regions();
> >
> >       if (efi_enabled(EFI_MEMMAP)) {
> > @@ -1113,6 +1087,8 @@ void __init setup_arch(char **cmdline_p)
> >               efi_reserve_boot_services();
> >       }
> >
> > +     memblock_set_current_limit(0, ISA_END_ADDRESS, false);
> > +     e820__memblock_setup();
>
> It looks like you changed the arguments passed to
> memblock_set_current_limit().  How can this even compile?  Did you mean
> that this patch is not functional?
>
Sorry that during rebasing, merge trivial fix by mistake. I will build
against each patch.

Best regards,
Pingfan
