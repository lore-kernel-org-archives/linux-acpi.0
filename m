From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] x86, amd: factor out MMCONFIG discovery
Date: Thu, 12 Jan 2012 06:56:15 -0700
Message-ID: <CAErSpo4C13Q_S6RiycmEf642Ogv0TCVZSw3XfrWE2E=zzT=8ig@mail.gmail.com>
References: <20120105212719.3965.40406.stgit@bhelgaas.mtv.corp.google.com> <1326351173.2741.3.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44924 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753548Ab2ALN4j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jan 2012 08:56:39 -0500
Received: by lago2 with SMTP id o2so894809lag.19
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jan 2012 05:56:38 -0800 (PST)
In-Reply-To: <1326351173.2741.3.camel@edumazet-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <borislav.petkov@amd.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Wed, Jan 11, 2012 at 11:52 PM, Eric Dumazet <eric.dumazet@gmail.com>=
 wrote:
> Le jeudi 05 janvier 2012 =E0 14:27 -0700, Bjorn Helgaas a =E9crit :
>> This factors out the AMD native MMCONFIG discovery so we can use it
>> outside amd_bus.c.
>>
>> amd_bus.c reads AMD MSRs so it can remove the MMCONFIG area from the
>> PCI resources. =A0We may also need the MMCONFIG information to work
>> around BIOS defects in the ACPI MCFG table.
>>
>> Cc: Borislav Petkov <borislav.petkov@amd.com>
>> Cc: Yinghai Lu <yinghai@kernel.org>
>> Cc: stable@kernel.org =A0 =A0 =A0 # 2.6.34+
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>> =A0arch/x86/include/asm/amd_nb.h | =A0 =A02 ++
>> =A0arch/x86/kernel/amd_nb.c =A0 =A0 =A0| =A0 31 ++++++++++++++++++++=
++++++++++
>> =A0arch/x86/pci/amd_bus.c =A0 =A0 =A0 =A0| =A0 42 +++++++++++-------=
-----------------------
>> =A03 files changed, 44 insertions(+), 31 deletions(-)
>
>> =A0/**
>> @@ -85,6 +57,9 @@ static int __init early_fill_mp_bus_info(void)
>> =A0 =A0 =A0 u64 val;
>> =A0 =A0 =A0 u32 address;
>> =A0 =A0 =A0 bool found;
>> + =A0 =A0 struct resource fam10h_mmconf_res, *fam10h_mmconf;
>> + =A0 =A0 u64 fam10h_mmconf_start;
>> + =A0 =A0 u64 fam10h_mmconf_end;
>>
>> =A0 =A0 =A0 if (!early_pci_allowed())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> @@ -211,12 +186,17 @@ static int __init early_fill_mp_bus_info(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 subtract_range(range, RANGE_NUM, 0, end)=
;
>>
>> =A0 =A0 =A0 /* get mmconfig */
>> - =A0 =A0 get_pci_mmcfg_amd_fam10h_range();
>> + =A0 =A0 fam10h_mmconf =3D amd_get_mmconfig_range(&fam10h_mmconf_re=
s);
>> =A0 =A0 =A0 /* need to take out mmconf range */
>
> This adds following link error if "# CONFIG_CPU_SUP_AMD is not set"
>
> =A0LD =A0 =A0 =A0.tmp_vmlinux1
> arch/x86/pci/built-in.o: In function `early_fill_mp_bus_info':
> /opt/src/linux/arch/x86/pci/amd_bus.c:189: undefined reference to
> `amd_get_mmconfig_range'
> make: *** [.tmp_vmlinux1] Error 1

I posted a fix for this, but looks like it hasn't been merged yet:
http://marc.info/?l=3Dlinux-pci&m=3D132614917932150&w=3D2

I'll resend it.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
