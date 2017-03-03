From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: Detect duplicate SSDT tables
Date: Fri, 3 Mar 2017 02:50:12 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE44EC5@SHSMSX101.ccr.corp.intel.com>
References: <20170227093432.3308-1-hdegoede@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE430EF@SHSMSX101.ccr.corp.intel.com>
 <d2552299-d658-af67-44f1-7e528133cfaf@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE43ED5@SHSMSX101.ccr.corp.intel.com>
 <a2cdcf07-055c-6cb2-a0f2-b179a128f845@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE446CB@SHSMSX101.ccr.corp.intel.com>
 <edd79f72-2c06-5cb7-a676-3bd940ca5b4d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:44273 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751148AbdCCCzj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Mar 2017 21:55:39 -0500
In-Reply-To: <edd79f72-2c06-5cb7-a676-3bd940ca5b4d@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

Hi,

> From: Hans de Goede [mailto:hdegoede@redhat.com]
> Subject: Re: [PATCH] ACPICA: Detect duplicate SSDT tables
> 
> Hi,
> 
> On 02-03-17 02:59, Zheng, Lv wrote:
> > Hi,
> >
> >> From: Hans de Goede [mailto:hdegoede@redhat.com]
> >> Subject: Re: [PATCH] ACPICA: Detect duplicate SSDT tables
> >>
> >> Hi,
> >>
> >> On 01-03-17 04:21, Zheng, Lv wrote:
> >>> Hi,
> >>>
> >>>> From: Hans de Goede [mailto:hdegoede@redhat.com]
> >>>> Subject: Re: [PATCH] ACPICA: Detect duplicate SSDT tables
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 28-02-17 06:19, Zheng, Lv wrote:
> >>>>> Hi,
> >>>>>
> >>>>>> From: Hans de Goede [mailto:hdegoede@redhat.com]
> >>>>>> Subject: [PATCH] ACPICA: Detect duplicate SSDT tables
> >>>>>>
> >>>>>> Some machines have the exact (byte for byte) same SSDT tables multiple
> >>>>>> times in the root_table_list.
> 
> <snip>
> 
> >>>>>> Detect this and silently skip the duplicates
> >>>>>> rather then printing a scary looking set of errors.
> 
> <snip>
> 
> >>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>>>> ---
> >>>>>>  drivers/acpi/acpica/tbxfload.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> >>>>>>  1 file changed, 40 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
> >>>>>> index 82019c0..1971cd7 100644
> >>>>>> --- a/drivers/acpi/acpica/tbxfload.c
> >>>>>> +++ b/drivers/acpi/acpica/tbxfload.c
> >>>>>> @@ -125,6 +125,44 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_load_tables)
> >>>>>>
> >>>>>>  /*******************************************************************************
> >>>>>>   *
> >>>>>> + * FUNCTION:    acpi_tb_find_duplicate_ssdt
> >>>>>> + *
> >>>>>> + * PARAMETERS:  table         - validated acpi_table_desc of table to check
> >>>>>> + *              index         - index of table to find a duplicate of
> >>>>>> + *
> >>>>>> + * RETURN:      TRUE if a duplicate is found, FALSE if not
> >>>>>> + *
> >>>>>> + * DESCRIPTION: Private helper function for acpi_tb_load_namespace to
> >>>>>> + *              avoid trying to load duplicate ssdt tables
> >>>>>> + *
> >>>>>> + ******************************************************************************/
> >>>>>> +static u8 acpi_tb_find_duplicate_ssdt(struct acpi_table_desc *table, u32 index)
> >
> > If you really want to add this.
> > My suggestion is:
> > Invoke this function in acpi_tb_verify_temp_table().
> > This is the function we use to verify if a table is OK.
> > Otherwise it won't be installed to the global table list.
> >
> > And the name should contain "aml_table" or "aml" rather than "ssdt" according to your check below.
> 
> Ok, when I've some time I will do a new version moving the functionality
> to acpi_tb_verify_temp_table(). I will post a v2 with this change when
> it is ready. I will also just compare the headers then as suggested in
> other replies in this thread.

If you wish, I can offer help here.
It actually won't take me much time to generate such a change.

Thanks and best regards
Lv
