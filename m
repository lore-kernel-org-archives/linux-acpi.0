From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 1/2] ACPI/tables: Correct the wrong count increasing
Date: Tue, 16 Aug 2016 16:21:31 +0800
Message-ID: <20160816082131.GD26981@x1.redhat.com>
References: <1470697311-1292-1-git-send-email-bhe@redhat.com>
 <20160809003006.GF16660@x1.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E883BC0E417@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BC0E417@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 08/16/16 at 02:26am, Zheng, Lv wrote:
> Hi,
> 
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Baoquan
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > index 9f0ad6e..34d45bb 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -281,7 +281,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
> >  			     proc[i].handler(entry, table_end))
> >  				return -EINVAL;
> > 
> > -			proc->count++;
> > +			proc[i].count++;
> 
> Do we have code using acpi_subtable_proce.count?
> I think the answer is yes because of:
> [Patch] x86, ACPI: Fix the wrong assignment when Handle apic/x2apic entries
> 
> So why don't you put these 2 patches together into a single series?
> And help to validate if there are problems in other acpi_subtable_proce.count users.

Thanks for comments. I hesitated to put them into one patch or two
patches when I post. Later I decided to post them in two patches because
they are in two components, one is x86, the other is ACPI. And though
very simple fix I worry they can't be described well in one patch log.

Anyway, change related to patch 1/2 had been included in Al Stone's
patchset posted earlier. So this one has to be NACKed.

> 
> Thanks
> Lv
> 
> >  			break;
> >  		}
> >  		if (i != proc_num)
> > --
> > 2.5.5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
