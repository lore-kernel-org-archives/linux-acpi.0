From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPI/APEI: Clear GHES block_status before panic()
Date: Thu, 20 Dec 2018 20:24:47 +0100
Message-ID: <20181220192447.GG31403@zn.tnic>
References: <1545238252-79630-1-git-send-email-darcari@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545238252-79630-1-git-send-email-darcari@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Arcari <darcari@redhat.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Lenny Szubowicz <lszubowi@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>
List-Id: linux-acpi@vger.kernel.org

+ James.

On Wed, Dec 19, 2018 at 11:50:52AM -0500, David Arcari wrote:
> From: Lenny Szubowicz <lszubowi@redhat.com>
> 
> In __ghes_panic() clear the block status in the APEI generic
> error status block for that generic hardware error source before
> calling panic() to prevent a second panic() in the crash kernel
> for exactly the same fatal error.
> 
> Otherwise ghes_probe(), running in the crash kernel, would see
> an unhandled error in the APEI generic error status block and
> panic again, thereby precluding any crash dump.
> 
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/acpi/apei/ghes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 02c6fd9..f008ba7 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -691,6 +691,8 @@ static void __ghes_panic(struct ghes *ghes)
>  {
>  	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
>  
> +	ghes_clear_estatus(ghes);
> +
>  	/* reboot to log the error! */
>  	if (!panic_timeout)
>  		panic_timeout = ghes_panic_timeout;
> -- 

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
