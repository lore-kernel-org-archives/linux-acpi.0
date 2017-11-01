From: Borislav Petkov <bp@suse.de>
Subject: Re: [RFC/RFT PATCH 4/6] ACPI / APEI: Remove ghes_ioremap_area
Date: Wed, 1 Nov 2017 14:47:57 +0100
Message-ID: <20171101134757.ivd2czbip64qulwf@pd.tnic>
References: <20171031153832.17746-1-james.morse@arm.com>
 <20171031153832.17746-5-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171031153832.17746-5-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>, torvalds@linux-foundation.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 31, 2017 at 03:38:30PM +0000, James Morse wrote:
> Now that nothing is using the ghes_ioremap_area pages, rip them out.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 39 ++-------------------------------------
>  1 file changed, 2 insertions(+), 37 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
