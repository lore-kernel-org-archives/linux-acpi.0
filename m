From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [patch 4/8] acpi: get_throttling_state() cannot be larger than
	state_count
Date: Mon, 16 Mar 2009 13:27:42 +0800
Message-ID: <1237181262.3640.29.camel@localhost.localdomain>
References: <200903041955.n24JtRIO027997@imap1.linux-foundation.org>
	 <alpine.LFD.2.00.0903152336100.30317@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50352 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbZCPF0n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Mar 2009 01:26:43 -0400
In-Reply-To: <alpine.LFD.2.00.0903152336100.30317@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "roel.kluin@gmail.com" <roel.kluin@gmail.com>

On Mon, 2009-03-16 at 11:36 +0800, Len Brown wrote:
> 
> --
> Len Brown, Intel Open Source Technology Center
> 
> On Wed, 4 Mar 2009, akpm@linux-foundation.org wrote:
> 
> > From: Roel Kluin <roel.kluin@gmail.com>
> > 
> > With for(i = 0; i < n; i++) { ... } i reaches n.
> > 
> > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> > Acked-by: <yakui.zhao@intel.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > 
> >  drivers/acpi/processor_throttling.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff -puN drivers/acpi/processor_throttling.c~acpi-get_throttling_state-cannot-be-larger-state_count drivers/acpi/processor_throttling.c
> > --- a/drivers/acpi/processor_throttling.c~acpi-get_throttling_state-cannot-be-larger-state_count
> > +++ a/drivers/acpi/processor_throttling.c
> > @@ -785,7 +785,7 @@ static int acpi_get_throttling_state(str
> >  		if (tx->control == value)
> >  			break;
> >  	}
> > -	if (i > pr->throttling.state_count)
> > +	if (i >= pr->throttling.state_count)
> >  		i = -1;
> >  	return i;
> >  }
> > _
> > 
> 
> how about simply...
It is OK to me.
> 
> diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
> index d278381..5f09901 100644
> --- a/drivers/acpi/processor_throttling.c
> +++ b/drivers/acpi/processor_throttling.c
> @@ -783,11 +783,9 @@ static int acpi_get_throttling_state(struct acpi_processor *pr,
>  		    (struct acpi_processor_tx_tss *)&(pr->throttling.
>  						      states_tss[i]);
>  		if (tx->control == value)
> -			break;
> +			return i;
>  	}
> -	if (i > pr->throttling.state_count)
> -		i = -1;
> -	return i;
> +	return -1;
>  }
>  
>  static int acpi_get_throttling_value(struct acpi_processor *pr,

