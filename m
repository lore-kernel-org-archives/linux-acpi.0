From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 2/2] x86/acpi: Remove the repeated lapic address
 override entry parsing
Date: Fri, 8 Jul 2016 20:56:11 +0800
Message-ID: <20160708125611.GC3125@x1.redhat.com>
References: <1467070896-4186-1-git-send-email-bhe@redhat.com>
 <1467070896-4186-2-git-send-email-bhe@redhat.com>
 <20160630080118.GD7175@x1.redhat.com>
 <20160708122755.GA12413@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160708122755.GA12413@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, Shaohua Li <shli@fb.com>, Viresh Kumar <viresh.kumar@linaro.org>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Juergen Gross <jgross@suse.com>, Joerg Roedel <jroedel@suse.de>, Dave Young <dyoung@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Mark Salter <msalter@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org

On 07/08/16 at 02:27pm, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
> > ACPI MADT has a 32-bit field providing lapic address at which
> > each processor can access its lapic information. MADT also contains
> > an optional entry to provide a 64-bit address to override the 32-bit
> > one. However the current code does the lapic address override entry
> > parsing twice. One is in early_acpi_boot_init() because AMD NUMA need
> > get boot_cpu_id earlier. The other is in acpi_boot_init() which parses
> > all MADT entries.
> > 
> > So in this patch remove the repeated code in the 2nd part. Meanwhile
> > print lapic override entry information like other MADT entry.
> 
> So this patch is not supposed to change behavior (modulo kernel messages), right? 
> If so it would make sense to spell that out explicitly in the changelog.

Yes, it won't. I will mention it in changelog and repost. Thanks for
your reviewing.

Thanks
Baoquan
