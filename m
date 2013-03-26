From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI/APEI: fix error status check condition for CPER
Date: Tue, 26 Mar 2013 14:35:10 +0100
Message-ID: <2538346.HX0LdEgg3N@vostro.rjw.lan>
References: <1363675687-7839-1-git-send-email-gong.chen@linux.intel.com> <1363743416.11204.14.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43084 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932367Ab3CZN1p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Mar 2013 09:27:45 -0400
In-Reply-To: <1363743416.11204.14.camel@yhuang-dev>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Chen Gong <gong.chen@linux.intel.com>, tony.luck@intel.com, linux-acpi@vger.kernel.org

On Wednesday, March 20, 2013 09:36:56 AM Huang Ying wrote:
> On Tue, 2013-03-19 at 02:48 -0400, Chen Gong wrote:
> > In Table 18-289, ACPI5.0 SPEC, the error data length in CPER
> > Generic Error Data Entry can be 0, which means this generic
> > error data entry can have only one header. So fix the check
> > conditon for it.
> > 
> > Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
> 
> Good catch!
> 
> Reviewed-by: Huang Ying <ying.huang@intel.com>

Applied.  I'm going to push it for 3.9.

Thanks,
Rafael


> > ---
> >  drivers/acpi/apei/cper.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/apei/cper.c b/drivers/acpi/apei/cper.c
> > index 1e5d8a4..fefc2ca 100644
> > --- a/drivers/acpi/apei/cper.c
> > +++ b/drivers/acpi/apei/cper.c
> > @@ -405,7 +405,7 @@ int apei_estatus_check(const struct acpi_hest_generic_status *estatus)
> >  		return rc;
> >  	data_len = estatus->data_length;
> >  	gdata = (struct acpi_hest_generic_data *)(estatus + 1);
> > -	while (data_len > sizeof(*gdata)) {
> > +	while (data_len >= sizeof(*gdata)) {
> >  		gedata_len = gdata->error_data_length;
> >  		if (gedata_len > data_len - sizeof(*gdata))
> >  			return -EINVAL;
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
