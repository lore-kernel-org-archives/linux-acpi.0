From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / APEI: fix error return code in einj_init()
Date: Wed, 12 Jun 2013 00:26:29 +0200
Message-ID: <4984765.hSvoDJCYAH@vostro.rjw.lan>
References: <CAPgLHd-uB=hWRNCgoUhzFzsjQiPj1cuedUk0ttu1g7UXAx=3=Q@mail.gmail.com> <20130605025927.GD27550@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34471 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756417Ab3FKWRW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Jun 2013 18:17:22 -0400
In-Reply-To: <20130605025927.GD27550@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, lenb@kernel.org, tony.luck@intel.com, yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org

On Tuesday, June 04, 2013 10:59:27 PM Chen Gong wrote:
> On Wed, Jun 05, 2013 at 10:17:35AM +0800, Wei Yongjun wrote:
> > Date: Wed, 5 Jun 2013 10:17:35 +0800
> > From: Wei Yongjun <weiyj.lk@gmail.com>
> > To: lenb@kernel.org, rjw@sisk.pl, gong.chen@linux.intel.com,
> >  tony.luck@intel.com
> > Cc: yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org
> > Subject: [PATCH] ACPI / APEI: fix error return code in einj_init()
> > 
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> > 
> > Fix to return -ENOMEM in the debugfs_create_xxx() error handling
> > case instead of 0, as done elsewhere in this function.
> > 
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> > ---
> >  drivers/acpi/apei/einj.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> > index 9a47d85..9d60bdd 100644
> > --- a/drivers/acpi/apei/einj.c
> > +++ b/drivers/acpi/apei/einj.c
> > @@ -732,6 +732,7 @@ static int __init einj_init(void)
> >  	if (rc)
> >  		goto err_release;
> >  
> > +	rc = -ENOMEM;
> >  	einj_param = einj_get_parameter_address();
> >  	if ((param_extension || acpi5) && einj_param) {
> >  		fentry = debugfs_create_x64("param1", S_IRUSR | S_IWUSR,
> > 
> OK to me.
> 
> Reviewed-by: Chen Gong <gong.chen@linux.intel.com>

Queued up for 3.11.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
