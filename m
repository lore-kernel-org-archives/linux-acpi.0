From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 13/18] ACPI / APEI: Don't update struct ghes' flags in
 read/clear estatus
Date: Fri, 12 Oct 2018 19:14:39 +0200
Message-ID: <20181012171439.GF580@zn.tnic>
References: <20180921221705.6478-1-james.morse@arm.com>
 <20180921221705.6478-14-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
Content-Disposition: inline
In-Reply-To: <20180921221705.6478-14-james.morse@arm.com>
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

On Fri, Sep 21, 2018 at 11:17:00PM +0100, James Morse wrote:
> ghes_read_estatus() sets a flag in struct ghes if the buffer of
> CPER records needs to be cleared once the records have been
> processed. This global flags value is a problem if a struct ghes
> can be processed concurrently, as happens at probe time if an
> NMI arrives for the same error source.
> 
> The GHES_TO_CLEAR flags was only set at the same time as
> buffer_paddr, which is now owned by the caller and passed to
> ghes_clear_estatus(). Use this as the flag.
> 
> A non-zero buf_paddr returned by ghes_read_estatus() means
> ghes_clear_estatus() will clear this address. ghes_read_estatus()
> already checks for a read of error_status_address being zero,
> so we can never get CPER records written at zero.
> 
> After this ghes_clear_estatus() no longer needs the struct ghes.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 26 ++++++++++++--------------
>  include/acpi/ghes.h      |  1 -
>  2 files changed, 12 insertions(+), 15 deletions(-)

Nice.

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
