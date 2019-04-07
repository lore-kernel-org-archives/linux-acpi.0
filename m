From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH -next] acpi/hmat: fix an uninitialized memory_target
Date: Sun, 7 Apr 2019 04:22:38 -0700
Message-ID: <20190407112238.GA30750@archlinux-ryzen>
References: <20190407011222.38963-1-cai@lca.pw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190407011222.38963-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
To: Qian Cai <cai@lca.pw>
Cc: gregkh@linuxfoundation.org, rjw@rjwysocki.net, lenb@kernel.org, keith.busch@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Apr 06, 2019 at 09:12:22PM -0400, Qian Cai wrote:
> The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
> memory") introduced an uninitialized "struct memory_target" that could
> cause an incorrect branching.
> 
> drivers/acpi/hmat/hmat.c:385:6: warning: variable 'target' is used
> uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>         if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/hmat/hmat.c:392:6: note: uninitialized use occurs here
>         if (target && p->flags & ACPI_HMAT_PROCESSOR_PD_VALID) {
>             ^~~~~~
> drivers/acpi/hmat/hmat.c:385:2: note: remove the 'if' if its condition
> is always true
>         if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/hmat/hmat.c:369:30: note: initialize the variable 'target'
> to silence this warning
>         struct memory_target *target;
>                                     ^
>                                      = NULL
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/acpi/hmat/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index c9b8abcf012c..6653dba3b377 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -366,7 +366,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>  					      const unsigned long end)
>  {
>  	struct acpi_hmat_proximity_domain *p = (void *)header;
> -	struct memory_target *target;
> +	struct memory_target *target = NULL;
>  
>  	if (p->header.length != sizeof(*p)) {
>  		pr_notice("HMAT: Unexpected address range header length: %d\n",
> -- 
> 2.17.2 (Apple Git-113)
> 
