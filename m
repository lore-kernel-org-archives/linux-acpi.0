From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2] acpi: apei: fix the wrongly iterate generic error
 status block
Date: Tue, 15 Aug 2017 18:13:43 +0200
Message-ID: <20170815161342.jxxf4rndqbs7t5rr@pd.tnic>
References: <1502795713-20945-1-git-send-email-gengdongjiu@huawei.com>
 <CAMj-D2CXOurgPGGGbC7qHX-uWZeMYwh9EfLOS3p3hm+=BvPq7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMj-D2CXOurgPGGGbC7qHX-uWZeMYwh9EfLOS3p3hm+=BvPq7w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gengdongjiu <gengdj.1984@gmail.com>, tbaicar@codeaurora.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, shameerali.kolothum.thodi@huawei.com, jonathan.cameron@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 15, 2017 at 10:16:20PM +0800, gengdongjiu wrote:
> 2017-08-15 19:15 GMT+08:00, Dongjiu Geng <gengdongjiu@huawei.com>:
> > The revision 0x300 generic error data entry is different
> > from the old version, but currently iterating through the
> > GHES estatus blocks does not take into account this difference.
> > This will lead to failure to get the right data entry if GHES
> > has revision 0x300 error data entry.
> >
> > Update the GHES estatus iteration to properly increment using
> > acpi_hest_get_next, and correct the iteration termination condition
> > because the status block data length only includes error data length.
> > Clear the CPER estatus printing iteration logic to use same macro.
> >
> > Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> > CC: Tyler Baicar <tbaicar@codeaurora.org>

...

> > diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> > index 48a8f69da42a..dff454321160 100644
> > --- a/drivers/firmware/efi/cper.c
> > +++ b/drivers/firmware/efi/cper.c
> > @@ -606,7 +606,6 @@ void cper_estatus_print(const char *pfx,
> >  			const struct acpi_hest_generic_status *estatus)
> >  {
> >  	struct acpi_hest_generic_data *gdata;
> > -	unsigned int data_len;
> >  	int sec_no = 0;
> >  	char newpfx[64];
> >  	__u16 severity;
> > @@ -617,14 +616,10 @@ void cper_estatus_print(const char *pfx,
> >  		       "It has been corrected by h/w "
> >  		       "and requires no further action");
> >  	printk("%s""event severity: %s\n", pfx, cper_severity_str(severity));
> > -	data_len = estatus->data_length;
> > -	gdata = (struct acpi_hest_generic_data *)(estatus + 1);
> >  	snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
> >
> > -	while (data_len >= acpi_hest_get_size(gdata)) {
> > +	apei_estatus_for_each_section(estatus, gdata) {
> >  		cper_estatus_print_section(newpfx, gdata, sec_no);
> > -		data_len -= acpi_hest_get_record_size(gdata);
> > -		gdata = acpi_hest_get_next(gdata);
> >  		sec_no++;

This one looks cleaner to me because it gets rid of all those
variables...

> >  	}
> >  }
> > diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> > index 9f26e01186ae..9061c5c743b3 100644
> > --- a/include/acpi/ghes.h
> > +++ b/include/acpi/ghes.h
> > @@ -113,6 +113,11 @@ static inline void *acpi_hest_get_next(struct
> > acpi_hest_generic_data *gdata)
> >  	return (void *)(gdata) + acpi_hest_get_record_size(gdata);
> >  }
> >
> > +#define apei_estatus_for_each_section(estatus, section)			\
> > +	for (section = (struct acpi_hest_generic_data *)(estatus + 1);	\
> > +	     (void *)section - (void *)(estatus + 1) < estatus->data_length; \
> > +	     section = acpi_hest_get_next(section))

... and uses that accessor.

Tyler?

I'd prefer if you guys merge your two patches, Tyler's from
https://marc.info/?l=linux-acpi&m=150179595323038&w=2 and this one into
a single one.

How does that sound?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
