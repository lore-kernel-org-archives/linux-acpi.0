From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 17/25] ACPI / APEI: Pass ghes and estatus separately
 to avoid a later copy
Date: Mon, 21 Jan 2019 14:35:40 +0100
Message-ID: <20190121133539.GH29166@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-18-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
Content-Disposition: inline
In-Reply-To: <20181203180613.228133-18-james.morse@arm.com>
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>, Fan Wu <wufan@codeaurora.org>, linux-mm@kvack.org, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 03, 2018 at 06:06:05PM +0000, James Morse wrote:
> The NMI-like notifications scribble over ghes->estatus, before
> copying it somewhere else. If this interrupts the ghes_probe() code
> calling ghes_proc() on each struct ghes, the data is corrupted.
> 
> All the NMI-like notifications should use a queued estatus entry
> from the beginning, instead of the ghes version, then copying it.
> To do this, break up any use of "ghes->estatus" so that all
> functions take the estatus as an argument.
> 
> This patch just moves these ghes->estatus dereferences into separate

s/This patch just moves/Move/

> arguments, no change in behaviour. struct ghes becomes unused in
> ghes_clear_estatus() as it only wanted ghes->estatus, which we now
> pass directly. This is removed.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
