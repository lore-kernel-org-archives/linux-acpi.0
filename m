From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: fix oops when a
	module parameter has no value
Date: Mon, 19 Nov 2007 16:10:19 -0500
Message-ID: <200711191610.19493.lenb@kernel.org>
References: <1193773585-17202-1-git-send-email-hmh@hmh.eng.br>
	<200711051432.27840.lenb@kernel.org>
	<20071118111829.GA19189@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20071118111829.GA19189-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

applied

thanks,
-len

On Sunday 18 November 2007 06:18, Henrique de Moraes Holschuh wrote:
> set_ibm_param() could OOPS with a NULL pointer derreference if one did not give
> any values for a module parameter it handles.  This would, of course, cause all
> sort of trouble for future modprobing and require a reboot to clean up
> properly.
> 
> Fix it by returning -EINVAL if no values are given for the parameter, and also
> avoid any nastyness from BUG_ON while at it.
> 
> How to reproduce: modprobe thinkpad-acpi brightness
> 
> Error report by Mike Kershaw.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
> Tested-by: Mike Kershaw <dragorn-8I8a9W+rkIX1ZkIrOfZKgqxOck334EZe@public.gmane.org>
> ---
>  drivers/misc/thinkpad_acpi.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> Len,
> 
> This one is also needed for 2.6.24-rc.  As soon as it hits mainline, I will
> also send it to -stable (for 2.6.22.y and 2.6.23.y).  It fixes a really,
> really annoying OOPS.
> 
> Please send it to Linus along with the other patches for 2.6.24-rc.
> 
> diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
> index 8c94307..ab23a32 100644
> --- a/drivers/misc/thinkpad_acpi.c
> +++ b/drivers/misc/thinkpad_acpi.c
> @@ -4817,9 +4817,15 @@ static int __init set_ibm_param(const char *val, struct kernel_param *kp)
>  	unsigned int i;
>  	struct ibm_struct *ibm;
>  
> +	if (!kp || !kp->name || !val)
> +		return -EINVAL;
> +
>  	for (i = 0; i < ARRAY_SIZE(ibms_init); i++) {
>  		ibm = ibms_init[i].data;
> -		BUG_ON(ibm == NULL);
> +		WARN_ON(ibm == NULL);
> +
> +		if (!ibm || !ibm->name)
> +			continue;
>  
>  		if (strcmp(ibm->name, kp->name) == 0 && ibm->write) {
>  			if (strlen(val) > sizeof(ibms_init[i].param) - 2)
> -- 
> 1.5.3.4
> 
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
