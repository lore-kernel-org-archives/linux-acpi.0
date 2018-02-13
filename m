From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/acpi: check rsdp address received via bootparams to
 be valid
Date: Tue, 13 Feb 2018 17:32:44 +0100
Message-ID: <20180213163244.j2zuxyhs4kbfhwgj@gmail.com>
References: <20180116135730.19216-1-jgross@suse.com>
 <20180116154630.ke53suvokynj73qd@gmail.com>
 <432c21ab-24d8-1e70-a471-ad8a14357d4e@suse.com>
 <20180116163529.rc5j23oqmwk45rp5@gmail.com>
 <4a8b0233-9bb8-3c95-0a08-93a5ceffc231@suse.com>
 <20180117153404.qnv3tjf6jhk4xijs@gmail.com>
 <a0a790b4-069b-8c99-e898-368fce01c632@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a0a790b4-069b-8c99-e898-368fce01c632@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com
List-Id: linux-acpi@vger.kernel.org


* Juergen Gross <jgross@suse.com> wrote:

> So what about the following:
> 
> From version 0x020e on (current version without my patches is 0x020d)
> the boot loader will write its supported version or'ed with 0x8000 into
> the same version field. So we can be sure any added fields are filled
> with real data or the information has been evaluated by the boot loader,
> if the returned version included that field. If the boot loader finds
> the kernel supports a version < 0x020e it won't return its supported
> version.

This seems like a usable workaround to me, as long as everyone involved
agrees with it.

I've removed the patches for the time being.

Thanks,

	Ingo
