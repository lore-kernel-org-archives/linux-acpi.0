From: Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [RFC PATCH V2 1/2] ACPI/PCI: Match PCI config space accessors
 against platfrom specific ECAM quirks
Date: Tue, 14 Jun 2016 17:45:55 +0800
Message-ID: <575FD253.3070508@huawei.com>
References: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
 <1465822923-33599-2-git-send-email-liudongdong3@huawei.com>
 <575ED57F.6050503@codeaurora.org>
 <CADaLNDkfKxxXWmG3eAawH1H=B+4ia6ZYh41anjTuOdTWGbhfNg@mail.gmail.com>
 <575F9B4D.8080501@huawei.com>
 <CADaLND=esW9rwrfdKtAvkyPhCs4F9hMH9LDY4DWTpOv0ZgoT9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:14369 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbcFNJr1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jun 2016 05:47:27 -0400
In-Reply-To: <CADaLND=esW9rwrfdKtAvkyPhCs4F9hMH9LDY4DWTpOv0ZgoT9w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Duc Dang <dhdang@apm.com>
Cc: Christopher Covington <cov@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Rafael Wysocki <rafael@kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, okaya@codeaurora.org, Jayachandran C <jchandra@broadcom.com>, Tomasz Nowicki <tn@semihalf.com>, robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>, Liviu Dudau <Liviu.Dudau@arm.com>, David Daney <ddaney@caviumnetworks.com>, Yijing Wang <wangyijing@huawei.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linaro-acpi@lists.li

Hi Duc

=E5=9C=A8 2016/6/14 17:00, Duc Dang =E5=86=99=E9=81=93:
> On Mon, Jun 13, 2016 at 10:51 PM, Dongdong Liu <liudongdong3@huawei.c=
om> wrote:
>> Hi Duc
>>
>> =E5=9C=A8 2016/6/14 4:57, Duc Dang =E5=86=99=E9=81=93:
>>>
>>> On Mon, Jun 13, 2016 at 8:47 AM, Christopher Covington
>>> <cov@codeaurora.org> wrote:
>>>>
>>>> Hi Dongdong,
>>>>
>>>> On 06/13/2016 09:02 AM, Dongdong Liu wrote:
>>>>>
>>>>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>>>>> index d3c3e85..49612b3 100644
>>>>> --- a/drivers/acpi/pci_mcfg.c
>>>>> +++ b/drivers/acpi/pci_mcfg.c
>>>>> @@ -22,6 +22,10 @@
>>>>>    #include <linux/kernel.h>
>>>>>    #include <linux/pci.h>
>>>>>    #include <linux/pci-acpi.h>
>>>>> +#include <linux/pci-ecam.h>
>>>>> +
>>>>> +/* Root pointer to the mapped MCFG table */
>>>>> +static struct acpi_table_mcfg *mcfg_table;
>>>>>
>>>>>    /* Structure to hold entries from the MCFG table */
>>>>>    struct mcfg_entry {
>>>>> @@ -35,6 +39,38 @@ struct mcfg_entry {
>>>>>    /* List to save mcfg entries */
>>>>>    static LIST_HEAD(pci_mcfg_list);
>>>>>
>>>>> +extern struct pci_cfg_fixup __start_acpi_mcfg_fixups[];
>>>>> +extern struct pci_cfg_fixup __end_acpi_mcfg_fixups[];
>>>>> +
>>>>> +struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *root=
)
>>>>> +{
>>>>> +     int bus_num =3D root->secondary.start;
>>>>> +     int domain =3D root->segment;
>>>>> +     struct pci_cfg_fixup *f;
>>>>> +
>>>>> +     if (!mcfg_table)
>>>>> +             return &pci_generic_ecam_ops;
>>>>> +
>>>>> +     /*
>>>>> +      * Match against platform specific quirks and return corres=
ponding
>>>>> +      * CAM ops.
>>>>> +      *
>>>>> +      * First match against PCI topology <domain:bus> then use O=
EM ID
>>>>> and
>>>>> +      * OEM revision from MCFG table standard header.
>>>>> +      */
>>>>> +     for (f =3D __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fi=
xups;
>>>>> f++) {
>>>>> +             if ((f->domain =3D=3D domain || f->domain =3D=3D
>>>>> PCI_MCFG_DOMAIN_ANY) &&
>>>>> +                 (f->bus_num =3D=3D bus_num || f->bus_num =3D=3D
>>>>> PCI_MCFG_BUS_ANY) &&
>>>>> +                 (!strncmp(f->oem_id, mcfg_table->header.oem_id,
>>>>> +                           ACPI_OEM_ID_SIZE)) &&
>>>>> +                 (!strncmp(f->oem_table_id,
>>>>> mcfg_table->header.oem_table_id,
>>>>> +                           ACPI_OEM_TABLE_ID_SIZE)))
>>>>
>>>>
>>>> This would just be a small convenience, but if the character count=
 used
>>>> here were
>>>>
>>>> min(strlen(f->oem_id), ACPI_OEM_ID_SIZE)
>>>>
>>>> then the parameters to DECLARE_ACPI_MCFG_FIXUP macro could be subs=
trings
>>>> and
>>>> wouldn't need to be padded out to the full length.
>>>>
>>>>> +                     return f->ops;
>>>>> +     }
>>>>> +     /* No quirks, use ECAM */
>>>>> +     return &pci_generic_ecam_ops;
>>>>> +}
>>>>
>>>>
>>>>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>>>>> index 7d63a66..088a1da 100644
>>>>> --- a/include/linux/pci-acpi.h
>>>>> +++ b/include/linux/pci-acpi.h
>>>>> @@ -25,6 +25,7 @@ static inline acpi_status
>>>>> pci_acpi_remove_pm_notifier(struct acpi_device *dev)
>>>>>    extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle han=
dle);
>>>>>
>>>>>    extern phys_addr_t pci_mcfg_lookup(u16 domain, struct resource
>>>>> *bus_res);
>>>>> +extern struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_roo=
t
>>>>> *root);
>>>>>
>>>>>    static inline acpi_handle acpi_find_root_bridge_handle(struct =
pci_dev
>>>>> *pdev)
>>>>>    {
>>>>> @@ -72,6 +73,25 @@ struct acpi_pci_root_ops {
>>>>>         int (*prepare_resources)(struct acpi_pci_root_info *info)=
;
>>>>>    };
>>>>>
>>>>> +struct pci_cfg_fixup {
>>>>> +     struct pci_ecam_ops *ops;
>>>>> +     char *oem_id;
>>>>> +     char *oem_table_id;
>>>>> +     int domain;
>>>>> +     int bus_num;
>>>>> +};
>>>>> +
>>>>> +#define PCI_MCFG_DOMAIN_ANY  -1
>>>>> +#define PCI_MCFG_BUS_ANY     -1
>>>>> +
>>>>> +/* Designate a routine to fix up buggy MCFG */
>>>>> +#define DECLARE_ACPI_MCFG_FIXUP(ops, oem_id, oem_table_id, dom, =
bus) \
>>>>> +     static const struct pci_cfg_fixup                          =
     \
>>>>> +     __mcfg_fixup_##oem_id##oem_table_id##dom##bus              =
     \
>>>>
>>>>
>>>> I'm not entirely sure that this is the right fix--I'm pretty blind=
ly
>>>> following a GCC documentation suggestion [1]--but removing the fir=
st two
>>>> preprocessor concatenation operators "##" solved the following bui=
ld
>>>> error
>>>> for me.
>>>>
>>>> include/linux/pci-acpi.h:90:2: error: pasting "__mcfg_fixup_" and
>>>> ""QCOM"" does not give a valid preprocessing token
>>>>     __mcfg_fixup_##oem_id##oem_table_id##dom##bus   \
>>>
>>>
>>> I think the problem is gcc is not happy with quoted string when
>>> processing these tokens
>>> (""QCOM"", the extra "" are added by gcc). So should we not concat
>>> string tokens and
>>> use the fixup definition in v1 of this RFC:
>>> /* Designate a routine to fix up buggy MCFG */
>>> #define DECLARE_ACPI_MCFG_FIXUP(ops, oem_id, rev, dom, bus)        =
     \
>>>           static const struct pci_cfg_fixup
>>> __mcfg_fixup_##system##dom##bus\
>>>            __used __attribute__((__section__(".acpi_fixup_mcfg"),  =
       \
>>>                                   aligned((sizeof(void *))))) =3D  =
         \
>>>           { ops, oem_id, rev, dom, bus };
>>
>>
>> V1 fixup exist the redefinition error when compiling mutiple
>> DECLARE_ACPI_MCFG_FIXUP
>> with the same PCI_MCFG_DOMAIN_ANY and PCI_MCFG_BUS_ANY.
>>
>> #define EFI_ACPI_HISI_OEM_ID "HISI"
>> #define EFI_ACPI_HISI_D02_OEM_TABLE_ID "HISI-D02"
>> #define EFI_ACPI_HISI_D03_OEM_TABLE_ID "HISI-D03"
>>
>> DECLARE_ACPI_MCFG_FIXUP(&hisi_pcie_ecam_ops, EFI_ACPI_HISI_OEM_ID,
>>         EFI_ACPI_HISI_D02_OEM_TABLE_ID, PCI_MCFG_DOMAIN_ANY,
>> PCI_MCFG_BUS_ANY);
>>
>> DECLARE_ACPI_MCFG_FIXUP(&hisi_pcie_ecam_ops, EFI_ACPI_HISI_OEM_ID,
>>         EFI_ACPI_HISI_D03_OEM_TABLE_ID, PCI_MCFG_DOMAIN_ANY,
>> PCI_MCFG_BUS_ANY);
>>
>> In file included from drivers/pci/host/pcie-hisi-acpi.c:15:0:
>> include/linux/pci-acpi.h:98:43: error: redefinition of
>> '__mcfg_fixup_systemPCI_MCFG_DOMAIN_ANYPCI_MCFG_BUS_ANY'
>>           static const struct pci_cfg_fixup __mcfg_fixup_##system##d=
om##bus\
>>                                             ^
>> drivers/pci/host/pcie-hisi-acpi.c:215:1: note: in expansion of macro
>> 'DECLARE_ACPI_MCFG_FIXUP'
>>   DECLARE_ACPI_MCFG_FIXUP(&hisi_pcie_ecam_ops, EFI_ACPI_HISI_OEM_ID,
>>   ^
>> include/linux/pci-acpi.h:98:43: note: previous definition of
>> '__mcfg_fixup_systemPCI_MCFG_DOMAIN_ANYPCI_MCFG_BUS_ANY' was here
>>           static const struct pci_cfg_fixup __mcfg_fixup_##system##d=
om##bus\
>>                                             ^
>> drivers/pci/host/pcie-hisi-acpi.c:212:1: note: in expansion of macro
>> 'DECLARE_ACPI_MCFG_FIXUP'
>>
>>
>> V2 fixup can resolve the redefinition error, but need to use macro.
>> We can see that the name of macro is not replace with it's value in
>> "__mcfg_fixup_EFI_ACPI_HISI_OEM_IDEFI_ACPI_HISI_D03_OEM_TABLE_IDPCI_=
MCFG_DOMAIN_ANYPCI_MCFG_BUS_ANY".
>>
>> Any good idea is appreciated.
> Hmmm.
>
> I was testing # op and using min_t to get the min-len when doing
> strncmp similar to Chris' suggestion (using min_t avoids type
> warnings)
>
> /* Designate a routine to fix up buggy MCFG */
> #define DECLARE_ACPI_MCFG_FIXUP(ops, oem_id, oem_table_id, rev, dom, =
bus) \
>          static const struct pci_cfg_fixup
> __mcfg_fixup##oem_id##oem_table_id##rev##dom##bus\
>           __used __attribute__((__section__(".acpi_fixup_mcfg"),     =
    \
>                                  aligned((sizeof(void *))))) =3D     =
      \

>          { ops, #oem_id, #oem_table_id, rev, dom, bus };


This should change to { ops, oem_id, oem_table_id, rev, dom, bus };
=E2=80=98#=E2=80=99 is not need.

>
> My fixup definition:
> DECLARE_ACPI_MCFG_FIXUP(&xgene_pcie_ecam_ops, APM, XGENE, 2,
>                                                 PCI_MCFG_DOMAIN_ANY,
> PCI_MCFG_BUS_ANY);
> My match condition is:
>                 if ((f->domain =3D=3D domain || f->domain =3D=3D PCI_=
MCFG_DOMAIN_ANY) &&
>                     (f->bus_num =3D=3D bus_num || f->bus_num =3D=3D P=
CI_MCFG_BUS_ANY) &&
>                     (!strncmp(f->oem_id, mcfg->header.oem_id,
>                               min_t(size_t, strlen(f->oem_id),
>                                     ACPI_OEM_ID_SIZE))) &&
>                     (!strncmp(f->oem_table_id, mcfg->header.oem_table=
_id,
>                               min_t(size_t, strlen(f->oem_table_id),
>                                     ACPI_OEM_TABLE_ID_SIZE))) &&
>                     (f->oem_revision =3D=3D mcfg->header.oem_revision=
)) {
>                         return f->ops;
>                 }
>
> But this still does not work for your case as having HISI-D02 as
> oem_table_id will cause error.

In my case, I have tested  and it worked ok.
Could you show the detail error information that you met?

Thanks
Dongdong
>
>>
>> Thanks
>> Dongdong
>>
>>>
>>> Regards,
>>> Duc Dang.
>>>
>>>
>>>>     ^
>>>> arch/arm64/kernel/pci.c:225:1: note: in expansion of macro
>>>> =E2=80=98DECLARE_ACPI_MCFG_FIXUP=E2=80=99
>>>>    DECLARE_ACPI_MCFG_FIXUP(&pci_32b_ecam_ops, "QCOM", "QDF2432",
>>>> PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
>>>>    ^
>>>> arch/arm64/kernel/pci.c:225:44: error: pasting ""QCOM"" and ""QDF2=
432""
>>>> does not give a valid preprocessing token
>>>>    DECLARE_ACPI_MCFG_FIXUP(&pci_32b_ecam_ops, "QCOM", "QDF2432",
>>>> PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
>>>>                                               ^
>>>> include/linux/pci-acpi.h:90:17: note: in definition of macro
>>>> =E2=80=98DECLARE_ACPI_MCFG_FIXUP=E2=80=99
>>>>     __mcfg_fixup_##oem_id##oem_table_id##dom##bus   \
>>>>                    ^
>>>> arch/arm64/kernel/pci.c:225:52: error: pasting ""QDF2432"" and
>>>> "PCI_MCFG_DOMAIN_ANY" does not give a valid preprocessi
>>>> ng token
>>>>    DECLARE_ACPI_MCFG_FIXUP(&pci_32b_ecam_ops, "QCOM", "QDF2432",
>>>> PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
>>>>                                                       ^
>>>> include/linux/pci-acpi.h:90:25: note: in definition of macro
>>>> =E2=80=98DECLARE_ACPI_MCFG_FIXUP=E2=80=99
>>>>     __mcfg_fixup_##oem_id##oem_table_id##dom##bus   \
>>>>                            ^
>>>> arch/arm64/kernel/pci.c:225:44: error: expected =E2=80=98=3D=E2=80=
=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or
>>>> =E2=80=98__attribute__=E2=80=99 before string constant
>>>>    DECLARE_ACPI_MCFG_FIXUP(&pci_32b_ecam_ops, "QCOM", "QDF2432",
>>>> PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
>>>>                                               ^
>>>> include/linux/pci-acpi.h:90:17: note: in definition of macro
>>>> =E2=80=98DECLARE_ACPI_MCFG_FIXUP=E2=80=99
>>>>     __mcfg_fixup_##oem_id##oem_table_id##dom##bus   \
>>>>                    ^
>>>> make[1]: *** [arch/arm64/kernel/pci.o] Error 1
>>>> make: *** [arch/arm64/kernel] Error 2
>>>>
>>>> 1. https://gcc.gnu.org/onlinedocs/cpp/Concatenation.html#Concatena=
tion
>>>>
>>>>> +     __used  __attribute__((__section__(".acpi_fixup_mcfg"),    =
     \
>>>>> +                             aligned((sizeof(void *))))) =3D    =
       \
>>>>> +     { ops, oem_id, oem_table_id, dom, bus };
>>>>> +
>>>>>    extern int acpi_pci_probe_root_resources(struct acpi_pci_root_=
info
>>>>> *info);
>>>>>    extern struct pci_bus *acpi_pci_root_create(struct acpi_pci_ro=
ot
>>>>> *root,
>>>>>                                             struct acpi_pci_root_=
ops
>>>>> *ops,
>>>>>
>>>>
>>>> Thanks,
>>>> Cov
>>>>
>>>> --
>>>> Qualcomm Innovation Center, Inc.
>>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>>>> a Linux Foundation Collaborative Project
>>>
>>>
>>> .
>>>
>>
> Regards
> Duc Dang.
>
> .
>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
