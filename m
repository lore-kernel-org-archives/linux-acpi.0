From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 2/4] ACPICA: Tables: Add mechanism to allow to balance
 late stage acpi_get_table() independently
Date: Thu, 4 May 2017 08:45:23 -0700
Message-ID: <CAPcyv4hhshAGaVJh74GSgB1iD6NbHUa5eXJVsRhaqbjgZ=LSUw@mail.gmail.com>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
 <89693a14ceb97e3d1fa7cc098b15c73f5b176863.1493357251.git.lv.zheng@intel.com>
 <3915288.8qJPC28FTg@aspire.rjw.lan> <1AE640813FDE7649BE1B193DEA596E886CE9D136@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE9D136@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, May 4, 2017 at 12:18 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi, Rafael
>
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Rafael J.
>> Wysocki
>> Subject: Re: [PATCH v3 2/4] ACPICA: Tables: Add mechanism to allow to balance late stage
>> acpi_get_table() independently
>>
>> On Friday, April 28, 2017 01:30:20 PM Lv Zheng wrote:
>> > For all frequent late stage acpi_get_table() clone invocations, we should
>> > only fix them altogether, otherwise, excessive acpi_put_table() could
>> > unexpectedly unmap the table used by the other users. Thus the current plan
>> > is to fix all acpi_get_table() clones together or to fix none of them.
>>
>> I honestly don't think that fixing none of them is a valid option here.
>
> That's just exactly the old behavior, maybe shouldn't be called as "fix".
> Should say "change to use the new behavior together" all stay unchanged.
>
> I actually want to make the change from ACPICA side.
> But it's costly to persuade ACPICA upstream to take both the "acpi_get_table_with_size()/early_acpi_os_unmap_memory() divergence reduction" change and the "table map on-demand" change.
>
> So we just made 2 things separated, and did 1 thing once.
>
>>
>> > This prevents kernel developers from improving the late stage code quality
>> > without waiting for the ACPICA upstream to improve first.
>> >
>> > This patch adds a mechanism to stop decrementing validation count to
>> > prevent the table unmapping operations so that acpi_put_table() balance
>> > fixes can be done independently to each others.
>> >
>> > Cc: Dan Williams <dan.j.williams@intel.com>
>> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>> > ---
>> >  drivers/acpi/acpica/tbutils.c | 10 ++++++++--
>> >  1 file changed, 8 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
>> > index 7abe665..b517bd0 100644
>> > --- a/drivers/acpi/acpica/tbutils.c
>> > +++ b/drivers/acpi/acpica/tbutils.c
>> > @@ -445,12 +445,18 @@ void acpi_tb_put_table(struct acpi_table_desc *table_desc)
>> >
>> >     ACPI_FUNCTION_TRACE(acpi_tb_put_table);
>> >
>> > -   if (table_desc->validation_count == 0) {
>> > +   if ((table_desc->validation_count + 1) == 0) {
>>
>> This means that validation_count has reached the maximum value, right?
>>
>> >             ACPI_WARNING((AE_INFO,
>> > -                         "Table %p, Validation count is zero before decrement\n",
>> > +                         "Table %p, Validation count is about to expire, decrement is unsafe\n",
>> >                           table_desc));
>>
>> So why is it unsafe to decrement it?
>
> Considering this case:
> A program opens a sysfs table file 65535 times: validation_count = 65535.
> Load opcode is invoked by the AML interpreter, but it cannot increase the validation count, see acpi_tb_get_table(): validation_count = 65535.
> Now the program closes the sysfs table file: validation_count = 0, which triggers table unmap.
> But it is likely that the AML code is still accessing the namespace objects provided by this table.
> A kernel crash then can be seen.
>
> So after applying this patch, 65535 now is the threshold.
> When it is reached, validation_count will remain 65535 from then on (see both acpi_tb_get_table()/acpi_tb_put_table()).
> When it is reached, the 65535 validation count ensures "the old behavior" - for late stage;
> When it is not reached, the 65535 validation count ensures "the new behavior" - for early stage.
>
> Then you can see, if there's no acpi_put_table() invoked for such old behavior dependent users, the validation count can also remain 65535.
> That's why I said PATCH 3 is actually breaking things.
>
> IMO, if we really want the acpi_put_table() balance work proceeded without waiting for the ACPICA upstream to change.
> We need this commit.
>
> I actually generated this commit once.
> But hesitated to send it to ACPICA upstream as it didn't look like a good idea to increase communication cost to upstream a commit that hadn't been determined to be used by ACPICA.
>
> However if other driver maintainers want to make their acpi_get_table() invocations balanced like what Dan did here.
> This commit is required.
>

Why do we need validation_count at all? I would think you would only
need that if tables can be hot-removed and you need to wait for all
active users to drain. Most tables don't have that behavior, right?
Should we instead be reference counting the few tables that might be
removed and leave the rest statically allocated?
