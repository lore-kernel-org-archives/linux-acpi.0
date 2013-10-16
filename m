From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH v2 1/9] ACPI, APEI,
 CPER: Fix status check during error printing
Date: Wed, 16 Oct 2013 13:53:32 -0300
Message-ID: <20131016135332.0884f535@samsung.com>
References: <1381935366-11731-1-git-send-email-gong.chen@linux.intel.com>
 <1381935366-11731-2-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1381935366-11731-2-git-send-email-gong.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, bp@alien8.de, joe@perches.com, naveen.n.rao@linux.vnet.ibm.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Wed, 16 Oct 2013 10:55:58 -0400
"Chen, Gong" <gong.chen@linux.intel.com> escreveu:

> Commit aaf9d93 only catches condition check before print,
> but the similar check is needed during printing CPER error
> sections.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> Reviewed-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Mauro Carvalho Chehab <m.chehab@samsung.com>

> ---
>  drivers/acpi/apei/cper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/cper.c b/drivers/acpi/apei/cper.c
> index 33dc6a0..f827f02 100644
> --- a/drivers/acpi/apei/cper.c
> +++ b/drivers/acpi/apei/cper.c
> @@ -353,7 +353,7 @@ void apei_estatus_print(const char *pfx,
>  	       cper_severity_str(severity));
>  	data_len = estatus->data_length;
>  	gdata = (struct acpi_hest_generic_data *)(estatus + 1);
> -	while (data_len > sizeof(*gdata)) {
> +	while (data_len >= sizeof(*gdata)) {
>  		gedata_len = gdata->error_data_length;
>  		apei_estatus_print_section(pfx, gdata, sec_no);
>  		data_len -= gedata_len + sizeof(*gdata);


-- 

Cheers,
Mauro
