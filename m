From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v4 1/3] EDAC, GHES: Remove unused argument to
 ghes_edac_report_mem_error
Date: Sat, 12 May 2018 11:00:33 +0200
Message-ID: <20180512090033.GA27593@pd.tnic>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180430213358.8319-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 30, 2018 at 04:33:50PM -0500, Alexandru Gagniuc wrote:
> The use of the 'ghes' argument was removed in a previous commit, but
> function signature was not updated to reflect this.
> 
> Fixes: 0fe5f281f749 ("EDAC, ghes: Model a single, logical memory controller")
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/acpi/apei/ghes.c | 2 +-
>  drivers/edac/ghes_edac.c | 3 +--
>  include/acpi/ghes.h      | 5 ++---
>  3 files changed, 4 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
