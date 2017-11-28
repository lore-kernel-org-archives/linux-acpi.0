From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [Xen-devel] [PATCH 3/3] x86/xen: supply rsdp address in boot
 params for pvh guests
Date: Tue, 28 Nov 2017 10:17:24 +0000
Message-ID: <20171128101724.ol5sufd6x3qzomcc@MacBook-Pro-de-Roger.local>
References: <20171128094400.25955-1-jgross@suse.com>
 <20171128094400.25955-4-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171128094400.25955-4-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, corbet@lwn.net, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, boris.ostrovsky@oracle.com, tglx@linutronix.de, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 28, 2017 at 10:44:00AM +0100, Juergen Gross wrote:
> When booted via the special PVH entry save the RSDP address set in the
> boot information block in struct boot_params. This will enable Xen to
> locate the RSDP at an arbitrary address.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/xen/enlighten_pvh.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
> index 436c4f003e17..0175194f4236 100644
> --- a/arch/x86/xen/enlighten_pvh.c
> +++ b/arch/x86/xen/enlighten_pvh.c
> @@ -71,6 +71,8 @@ static void __init init_pvh_bootparams(void)
>  	 */
>  	pvh_bootparams.hdr.version = 0x212;

Shouldn't this be 0x20e, like it's set in patch 1?

Roger.
