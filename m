From: Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH] acpi / apei: fix NULL deref during init
Date: Fri, 14 Dec 2018 10:43:25 -0800
Message-ID: <641b4a9d-4eb8-5ba2-ac3b-bd0dd25fb7a6@redhat.com>
References: <20181214181514.29891-1-tst@schoebel-theuer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214181514.29891-1-tst@schoebel-theuer.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Schoebel-Theuer <tst@schoebel-theuer.de>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

(adding some more people, please remember to run get_maintainer.pl
to get the full list in the future)
On 12/14/18 10:15 AM, Thomas Schoebel-Theuer wrote:
> Since commit commit d91525eb8ee6 ("ACPI, EINJ: Enhance error injection
> tolerance level"), starting with kernel 4.0, the following happens during
> boot of a specific old hardware:
> 
> APEI: Can not request [mem 0x0009c2f2-0x0009c2fc] for APEI ERST registers
> BUG: unable to handle kernel NULL pointer dereference at           (null)
> IP: [<ffffffff81343d8e>] __list_del_entry+0x5c/0x98
> PGD 0
> Oops: 0000 [#1] SMP
> Modules linked in:
> CPU: 0 PID: 1 UID: 0 Comm: swapper/0 Not tainted 4.4.0-ui18344.004-uiabi1-infong-amd64 #1
> Hardware name: IBM IBM eServer BladeCenter HS12 -[8028Z5S]-/Server Blade, BIOS -[N1E150AUS-1.11]- 11/04/2010
> task: ffff88021fe4e040 ti: ffff88021fe7c000 task.ti: ffff88021fe7c000
> RIP: 0010:[<ffffffff81343d8e>]  [<ffffffff81343d8e>] __list_del_entry+0x5c/0x98
> RSP: 0000:ffff88021fe7fd18  EFLAGS: 00010207
> RAX: 0000000000000000 RBX: ffff88021fe7fde0 RCX: ffff88021fe7fde0
> RDX: ffffffff819bd040 RSI: dead000000000200 RDI: ffff88021fe7fde0
> RBP: ffff88021fe7fd18 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff816ce240 R11: 0000000000000001 R12: ffffffff819bd040
> R13: ffff88021fe7fda0 R14: ffff88021d2cd840 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88022fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 00000000019b6000 CR4: 0000000000040670
> Stack:
>   ffff88021fe7fd30 ffffffff81343dd7 ffff88021fe7fde0 ffff88021fe7fd58
>   ffffffff813931c0 ffff88021fe7fda0 ffff88021fe7fe00 ffff88021d2cd840
>   ffff88021fe7fd70 ffffffff813931e5 00000000ffffffea ffff88021fe7fdf0
> Call Trace:
>   [<ffffffff81343dd7>] list_del+0xd/0x25
>   [<ffffffff813931c0>] apei_res_clean+0x1f/0x37
>   [<ffffffff813931e5>] apei_resources_fini+0xd/0x19
>   [<ffffffff81393948>] apei_resources_request+0x24f/0x268
>   [<ffffffff8139301d>] ? apei_exec_for_each_entry+0x77/0x8e
>   [<ffffffff81b0f729>] ? setup_erst_disable+0x12/0x12
>   [<ffffffff81b0f816>] erst_init+0xed/0x2ca
>   [<ffffffff810003b2>] ? do_one_initcall+0x8c/0x174
>   [<ffffffff81b0f729>] ? setup_erst_disable+0x12/0x12
>   [<ffffffff81b0f729>] ? setup_erst_disable+0x12/0x12
>   [<ffffffff8100040f>] do_one_initcall+0xe9/0x174
>   [<ffffffff8105df00>] ? parse_args+0x161/0x296
>   [<ffffffff81ad6070>] kernel_init_freeable+0x169/0x1f6
>   [<ffffffff81ad579b>] ? do_early_param+0x88/0x88
>   [<ffffffff81663202>] ? rest_init+0x79/0x79
>   [<ffffffff8166320b>] kernel_init+0x9/0xd5
>   [<ffffffff816683f5>] ret_from_fork+0x55/0x80
>   [<ffffffff81663202>] ? rest_init+0x79/0x79
> Code: 02 00 00 00 00 ad de 48 39 f0 75 1f 49 89 c0 48 c7 c2 38 de 8e 81 be 38 00 00 00 48 c7 c7 13 dd 8e 81 31 c0 e8 94 36 d0 ff eb 3a <48> 8b 30 48 39 fe 74 11 49 89 f0 48 c7 c2 6c de 8e 81 be 3b 00
> RIP  [<ffffffff81343d8e>] __list_del_entry+0x5c/0x98
>   RSP <ffff88021fe7fd18>
> CR2: 0000000000000000
> ---[ end trace 3610e544cef27e81 ]---
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
> 
> Reason is a conditional initialization of variable arch_res, which happens
> only under a specific precondition. When the condition is false, the
> variable remains uninitialized.
> 
> This may later trigger a splat, e.g. when some error path is taken.
> 
> Solution: do the initialisation unconditionally. Also as a safeguard.
> 
> Fixes: d91525eb8ee6a622ce476955fe1a2530ade87c83
> Signed-off-by: Thomas Schoebel-Theuer <tst@schoebel-theuer.de>
> ---
>   drivers/acpi/apei/apei-base.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index da370e1d31f4..ef931b8a0b11 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -494,8 +494,8 @@ int apei_resources_request(struct apei_resources *resources,
>   	if (rc)
>   		goto nvs_res_fini;
>   
> +	apei_resources_init(&arch_res);
>   	if (arch_apei_filter_addr) {
> -		apei_resources_init(&arch_res);
>   		rc = apei_get_arch_resources(&arch_res);
>   		if (rc)
>   			goto arch_res_fini;
> 
