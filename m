From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: SPCR: Use access width to determine mmio usage
Date: Mon, 3 Jul 2017 20:56:04 +0200
Message-ID: <CAJZ5v0gLxoS2Tu-DO_8yEWMm2b273U3PdQx31otcYe8as-fEXA@mail.gmail.com>
References: <1493910330-17913-1-git-send-email-jon.mason@broadcom.com>
 <4e11bb2b-7cec-6a7b-ca2b-88be31a98b7d@redhat.com> <CAPw-ZTkF2KnC2TWwxWLTKoM5LPkipHvJeQGaBp30JjDNQ76VEA@mail.gmail.com>
 <f122adfb-872e-9ee6-db61-b55c75903b63@redhat.com> <CAPw-ZTnu+YvBN8PAZfMEKuY_3xTPDgr4qmNqi0JOCPXH_k0SDg@mail.gmail.com>
 <CAC3K-4oK9FF_7QfoQCBvgBCoprk+VbRVD-YvC9fm7aRT8Uo+rQ@mail.gmail.com>
 <CAPw-ZTkwwuwCSw0Q=8W53e7t5FDEF-hKshOoWvdJ7QhCTRvuqA@mail.gmail.com>
 <20170508212347.GA3601@broadcom.com> <CAPw-ZT=+WjtMLFPmw5q7qJkH9AAJcxPUt9KCn5wvxN-1MA68rg@mail.gmail.com>
 <CAPw-ZT=rbM05RBxL8Ym8yZiF6C+8PxJx_xi8rCC1byrcAgfuVA@mail.gmail.com>
 <CAC3K-4rAt0CZ2=45uJyR5PPJctxVzL0_wKv9j+1UTE+BWVx5uw@mail.gmail.com>
 <CAJZ5v0jDiOUNYz-iZ0dox1SRbVLYoRVtzaTUivyCEwVHE2jD1Q@mail.gmail.com> <CAPw-ZTmK7bwbKG+nFuq9tcbyJDrMKpf3itt1WogApfK5-jsoBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPw-ZTmK7bwbKG+nFuq9tcbyJDrMKpf3itt1WogApfK5-jsoBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Loc Ho <lho@apm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jon Mason <jon.mason@broadcom.com>, Jon Masters <jcm@redhat.com>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 3, 2017 at 8:27 PM, Loc Ho <lho@apm.com> wrote:
> Hi Rafael,
>
>>>>> >> >>>>>> The current SPCR code does not check the access width of the mmio, and
>>>>> >> >>>>>> uses a default of 8bit register accesses.  This prevents devices that
>>>>> >> >>>>>> only do 16 or 32bit register accesses from working.  By simply checking
>>>>> >> >>>>>> this field and setting the mmio string appropriately, this issue can be
>>>>> >> >>>>>> corrected.  To prevent any legacy issues, the code will default to 8bit
>>>>> >> >>>>>> accesses if the value is anything but 16 or 32.
>>>>> >> >>>>>
>>>>> >> >>>>> Thanks for this. Just as an FYI I've a running discussion with Microsoft
>>>>> >> >>>>> about defining additional UART subtypes in the DBG2 for special case
>>>>> >> >>>>> UARTs. Specifically, I want to address AppliedMicro's special 8250 dw IP
>>>>> >> >>>>> that also has a non-standard clock. At this time, there is general
>>>>> >> >>>>> agreement to use the access width for some cases rather than defining
>>>>> >> >>>>> yet more subtypes - so your patch is good.
>>>>> >> >>>>>
>>>>> >> >>>>> Loc/Applied: please track this thread, incorporate feedback, and also
>>>>> >> >>>>> track the other general recent discussions of 8250 dw from this week.
>>>>> >> >>>>
>>>>> >> >>>> Thanks for forward me this patch. This patch does not work with X-Gene
>>>>> >> >>>> v1 and v2 SoC's. As BIOS SPCR encodes these info as:
>>>>> >> >>>>
>>>>> >> >>>> Bit Width: 32
>>>>> >> >>>> Bit Offset: 0
>>>>> >> >>>> Encoded Access Width: 01 (Byte Access)
>>>>> >> >>>>
>>>>> >> >>>> With this patch, it would use the "mmio" instead the "mmio32" as with
>>>>> >> >>>> this patch - https://patchwork.kernel.org/patch/9460959
>>>>> >> >>>
>>>>> >> >>> I think this is why we need the DBG2 subtype for Applied X-Gene1. I'm
>>>>> >> >>> hoping the update to the SPCR/DBG2 spec is done soon.
>>>>> >> >>
>>>>> >> >> We can't rely on the BIOS change to support this new subtype as we
>>>>> >> >> have system that is already in production deployment. When these
>>>>> >> >> system upgrade to new version of the OS (stock, RHELSA, or whatever),
>>>>> >> >> they will break. We need the patch from
>>>>> >> >> https://patchwork.kernel.org/patch/9460959/ rolled upstream.
>>>>> >> >
>>>>> >> > There is no reason why the patch you reference cannot co-exist with
>>>>> >> > the one I am submitting here.  In this case, my patch would set it to
>>>>> >> > mmio, then the patch you link above would reset it to mmio32.
>>>>> >> > Personally, I would recommend a big, fat comment on why this extra
>>>>> >> > step is necessary, but it should work as desired.  Alternatively, we
>>>>> >> > could add some kind of quirk library (similar to
>>>>> >> > qdf2400_erratum_44_present) where the OEM/OEM Table ID is referenced
>>>>> >> > and workaround applied.  Thoughts?
>>>>> >>
>>>>> >> That's was my first version but after seeing both versions, I think
>>>>> >> they are better solution as it works for more SoC's than just our. As
>>>>> >> you had suggested, we should apply your patch and
>>>>> >> https://patchwork.kernel.org/patch/9460959. The third patch -
>>>>> >> https://patchwork.kernel.org/patch/9462183/ - conflicts with your.
>>>>> >>
>>>>> >> Summary:
>>>>> >> 1. Applied your - https://lkml.org/lkml/2017/5/4/450
>>>>> >> 2. Applied this one - https://patchwork.kernel.org/patch/9460959/
>>>>> >>
>>>>> >> -Loc
>>>>> >
>>>>> > What if we simply applied the following (100% untested) patch to add
>>>>> > the quirk framework I was suggesting?  It can be applied on top of the
>>>>> > patch I submitted previously.
>>>>>
>>>>> It is a bit more complex that this simple patch. How about this one
>>>>> (my original version). As for Jon Master question on McDivitt, not
>>>>> sure what they use for the ACPI table for SPCR. If they used our
>>>>> reference, then this might work for them too. This version would limit
>>>>> to just the existent firmware or until the SPCR table gets changed.
>>>>>
>>>>>
>>>>> tty: 8250: Workaround for APM X-Gene 8250 UART 32-alignment errata
>>>>>
>>>>> APM X-Gene verion 1 and 2 have an 8250 UART with its register
>>>>> aligned to 32-bit. The SPCR always assumes fully compatible
>>>>> 8250. This causes no console with ACPI boot as the console
>>>>> will not match X-Gene UART port due to the lack of mmio32
>>>>> option.
>>>>>
>>>>> Signed-off-by: Loc Ho <lho@apm.com>
>>>>> ---
>>>>>  drivers/acpi/spcr.c | 21 +++++++++++++++++++++
>>>>>  1 file changed, 21 insertions(+)
>>>>>
>>>>> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
>>>>> index 3afa8c1..77b45a0 100644
>>>>> --- a/drivers/acpi/spcr.c
>>>>> +++ b/drivers/acpi/spcr.c
>>>>> @@ -36,6 +36,25 @@ static bool qdf2400_erratum_44_present(struct
>>>>> acpi_table_header *h)
>>>>>         return false;
>>>>>  }
>>>>>
>>>>> +/*
>>>>> + * APM X-Gene v1 and v2 UART hardware is an 16550 like device but has its
>>>>> + * register aligned to 32-bit. This function detects this errata condition.
>>>>> + */
>>>>> +static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
>>>>> +{
>>>>> +       if (tb->interface_type != ACPI_DBG2_16550_COMPATIBLE)
>>>>> +               return false;
>>>>> +
>>>>> +       if (memcmp(tb->header.oem_id, "APMC0D", ACPI_OEM_ID_SIZE))
>>>>> +               return false;
>>>>> +
>>>>> +       if (!memcmp(tb->header.oem_table_id, "XGENESPC",
>>>>> +                   ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revision == 0)
>>>>> +               return true;
>>>>> +
>>>>> +       return false;
>>>>> +}
>>>>> +
>>>>>  /**
>>>>>   * parse_spcr() - parse ACPI SPCR table and add preferred console
>>>>>   *
>>>>> @@ -115,6 +134,8 @@ int __init parse_spcr(bool earlycon)
>>>>>
>>>>>         if (qdf2400_erratum_44_present(&table->header))
>>>>>                 uart = "qdf2400_e44";
>>>>> +       if (xgene_8250_erratum_present(table))
>>>>> +               iotype = "mmio32";
>>>>>
>>>>>         snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iotype,
>>>>>                  table->serial_port.address, baud_rate);
>>>>>
>>>>
>>>> I didn't see a follow up email on this. What was the conclusion to
>>>> this patch series?
>>>
>>> I have not received an ack, nack, or gtfo from any of the maintainers
>>> of this file.  Per
>>> ./scripts/get_maintainer.pl drivers/acpi/spcr.c
>>> "Rafael J. Wysocki" <rjw@rjwysocki.net> (supporter:ACPI)
>>> Len Brown <lenb@kernel.org> (supporter:ACPI)
>>> linux-acpi@vger.kernel.org (open list:ACPI)
>>> linux-kernel@vger.kernel.org (open list)
>>>
>>> Is there someone else I should be directing this patch through?
>>
>> Generally, whoever is going to be affected by this change.
>>
>> git seems to tell me that the spcr.c file went in through the tty tree
>> and Aleksey introduced it.
>>
>> I can apply it if no one has any objections.
>
> I think this is on the mailing list long enough and I don't see anyone
> follow up with any objection. Would you applies Jon Mason patch and my
> patch on May 8 or inline below? If you need a more formal patch email
> for the below patch, I can send one to this email list as well.

Yes, I do.

Actually, please send both patches as a series with CCs to Greg and
Aleksey.  You can add your sign off to the resend of the Jon's patch.

Thanks,
Rafael
