From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 09/18] ACPI / APEI: Let the notification helper
 specify the fixmap slot
Date: Fri, 12 Oct 2018 13:14:08 +0200
Message-ID: <20181012111408.GC580@zn.tnic>
References: <20180921221705.6478-1-james.morse@arm.com>
 <20180921221705.6478-10-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
Content-Disposition: inline
In-Reply-To: <20180921221705.6478-10-james.morse@arm.com>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: James Morse <james.morse@arm.com>
Cc: jonathan.zhang@cavium.com, Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 21, 2018 at 11:16:56PM +0100, James Morse wrote:
> ghes_copy_tofrom_phys() uses a different fixmap slot depending on in_nmi().
> This doesn't work when we have multiple NMI-like notifications, that
> can interrupt each other.
> 
> As with the locking, move the chosen fixmap_idx to the notification helper.
> This only matters for NMI-like notifications, anything calling
> ghes_proc() can use the IRQ fixmap slot as its already holding an irqsave
> spinlock.
> 
> This lets us collapse the ghes_ioremap_pfn_*() helpers.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> 
> The fixmap-idx and vaddr are passed back to ghes_unmap()
> to allow ioremap() to be used in process context in the
> future.
> ---
>  drivers/acpi/apei/ghes.c | 76 ++++++++++++++--------------------------
>  1 file changed, 27 insertions(+), 49 deletions(-)

Nice.

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
