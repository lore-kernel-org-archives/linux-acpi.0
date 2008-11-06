From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH]1/3 intel_menlow:Adding comment for GTHS legal values
Date: Thu, 6 Nov 2008 15:47:33 -0800
Message-ID: <20081106154733.31714e90.akpm@linux-foundation.org>
References: <7D0189F5BE1DF549A570B212D1D5612182AF02@bgsmsx412.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48085 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753924AbYKFXsN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 18:48:13 -0500
In-Reply-To: <7D0189F5BE1DF549A570B212D1D5612182AF02@bgsmsx412.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rui.zhang@intel.com, sujith.thomas@intel.com, len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, 5 Nov 2008 16:15:13 +0530
"Thomas, Sujith" <sujith.thomas@intel.com> wrote:

> Subject: [PATCH]1/3 intel_menlow:Adding comment for GTHS legal values

Please put the "1/3" inside the square brackets.  Because that
numbering is only relevant for this series of emails and should be
stripped out when the patch is merged into another tree.  The way in
which we tell the recipient about text which they should strip out is
to put it in square brackets.

Please put a space after colons.

> Date: Wed, 5 Nov 2008 16:15:13 +0530
> 
> Documentation of legal values for GTHS
> To be patched over Rui's 09/11 bug fix patch
> 
> Signed-off-by: Sujith Thomas <sujith.thomas@intel.com>
> ---
>  drivers/misc/intel_menlow.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> Index: linux-2.6.27/drivers/misc/intel_menlow.c
> ===================================================================
> --- linux-2.6.27.orig/drivers/misc/intel_menlow.c
> +++ linux-2.6.27/drivers/misc/intel_menlow.c
> @@ -52,6 +52,11 @@ MODULE_LICENSE("GPL");
>  #define MEMORY_ARG_CUR_BANDWIDTH 1
>  #define MEMORY_ARG_MAX_BANDWIDTH 0
>  
> +/*
> + * GTHS returning 'n' would mean that [0,n-1] states are supported
> + * In that case max_cstate would be n-1
> + * GTHS returning '0' would mean that no bandwidth control states are
> supported
> + */
>  static int memory_get_int_max_bandwidth(struct thermal_cooling_device
> *cdev,

The patches were quite badly wordwrapped by your email client.


