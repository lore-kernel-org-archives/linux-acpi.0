From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH 3/6] acpi cleanup: Use pr_info() instead of printk() in
 arch/x86/mm/srat.c
Date: Fri, 16 Aug 2013 15:58:44 +0800
Message-ID: <520DDBB4.60801@cn.fujitsu.com>
References: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>  <1376636809-10159-4-git-send-email-tangchen@cn.fujitsu.com> <1376637949.1947.3.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376637949.1947.3.camel@joe-AO722>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, rjw@sisk.pl, liwanp@linux.vnet.ibm.com, tj@kernel.org, akpm@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Joe,

On 08/16/2013 03:25 PM, Joe Perches wrote:
> On Fri, 2013-08-16 at 15:06 +0800, Tang Chen wrote:
>> arch/x86/mm/srat.c
>
> I think it'd be better to use pr_fmt
> with the conversions to pr_info and pr_err.
>
> pr_fmt can prefix the appropriate srat: and
> so the format strings do not need it.
>
> Something like:
> ---
>   arch/x86/mm/srat.c | 31 ++++++++++++++++---------------
>   1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
> index cdd0da9..350b4c5 100644
> --- a/arch/x86/mm/srat.c
> +++ b/arch/x86/mm/srat.c
> @@ -9,6 +9,8 @@
>    * are in one chunk. Holes between them will be included in the node.
>    */
>
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

OK, will update the patches.

Thanks. :)
