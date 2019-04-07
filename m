From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH -next] acpi/hmat: fix an uninitialized memory_target
Date: Sun, 7 Apr 2019 11:51:09 +0530
Message-ID: <561c18b5-9bb5-3d25-b172-f1f29910de8e@codeaurora.org>
References: <20190407011222.38963-1-cai@lca.pw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190407011222.38963-1-cai@lca.pw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Qian Cai <cai@lca.pw>, gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, keith.busch@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


On 4/7/2019 6:42 AM, Qian Cai wrote:
> The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
> memory") introduced an uninitialized "struct memory_target" that could
> cause an incorrect branching.
>
> drivers/acpi/hmat/hmat.c:385:6: warning: variable 'target' is used
> uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>          if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/hmat/hmat.c:392:6: note: uninitialized use occurs here
>          if (target && p->flags & ACPI_HMAT_PROCESSOR_PD_VALID) {
>              ^~~~~~
> drivers/acpi/hmat/hmat.c:385:2: note: remove the 'if' if its condition
> is always true
>          if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/hmat/hmat.c:369:30: note: initialize the variable 'target'
> to silence this warning
>          struct memory_target *target;
>                                      ^
>                                       = NULL
>
> Signed-off-by: Qian Cai <cai@lca.pw>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/acpi/hmat/hmat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index c9b8abcf012c..6653dba3b377 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -366,7 +366,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>   					      const unsigned long end)
>   {
>   	struct acpi_hmat_proximity_domain *p = (void *)header;
> -	struct memory_target *target;
> +	struct memory_target *target = NULL;
>   
>   	if (p->header.length != sizeof(*p)) {
>   		pr_notice("HMAT: Unexpected address range header length: %d\n",
