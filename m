From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v7 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
 and pass acpi=force to enable ACPI
Date: Tue, 20 Jan 2015 17:29:14 +0800
Message-ID: <54BE1FEA.5040109@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org> <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org> <20150119114255.GF11835@e104818-lin.cambridge.arm.com> <CAKv+Gu8vPKAdsNg7QC7xW+i8_BemWEx4mvBx6NrnAHi8Y+bNtw@mail.gmail.com> <20150119135144.GI11835@e104818-lin.cambridge.arm.com> <20150119151350.21B65C40948@trevor.secretlab.ca> <54BD3803.6020307@redhat.com> <20150119175233.GK11835@e104818-lin.cambridge.arm.com> <20150119180122.GJ21553@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:51160 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbbATJ3m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Jan 2015 04:29:42 -0500
Received: by mail-pd0-f171.google.com with SMTP id fp1so20495292pdb.2
        for <linux-acpi@vger.kernel.org>; Tue, 20 Jan 2015 01:29:41 -0800 (PST)
In-Reply-To: <20150119180122.GJ21553@leverpostej>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: "jcm@redhat.com" <jcm@redhat.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Will Deacon <Will.Deacon@arm.com>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Timur Tabi <timur@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 2015=E5=B9=B401=E6=9C=8820=E6=97=A5 02:01, Mark Rutland wrote:
> On Mon, Jan 19, 2015 at 05:52:33PM +0000, Catalin Marinas wrote:
>> On Mon, Jan 19, 2015 at 04:59:47PM +0000, Jon Masters wrote:
>>> On 01/19/2015 10:13 AM, Grant Likely wrote:
>>>> On Mon, 19 Jan 2015 13:51:45 +0000
>>>> , Catalin Marinas <catalin.marinas@arm.com>
>>>>   wrote:
>>>>> On Mon, Jan 19, 2015 at 11:55:32AM +0000, Ard Biesheuvel wrote:
>>>>>> On 19 January 2015 at 11:42, Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>>>>>>> On Wed, Jan 14, 2015 at 03:04:52PM +0000, Hanjun Guo wrote:
>>>>>>>> From: Al Stone <al.stone@linaro.org>
>>>>>>>>
>>>>>>>> Introduce one early parameters "off" and "force" for "acpi", a=
cpi=3Doff
>>>>>>>> will be the default behavior for ARM64, so introduce acpi=3Dfo=
rce to
>>>>>>>> enable ACPI on ARM64.
>>>>>>>>
>>>>>>>> Disable ACPI before early parameters parsed, and enable it to =
pass
>>>>>>>> "acpi=3Dforce" if people want use ACPI on ARM64. This ensures =
DT be
>>>>>>>> the prefer one if ACPI table and DT both are provided at this =
moment.
>>>>>>> [...]
>>>>>>>> --- a/arch/arm64/kernel/setup.c
>>>>>>>> +++ b/arch/arm64/kernel/setup.c
>>>>>>>> @@ -62,6 +62,7 @@
>>>>>>>>   #include <asm/memblock.h>
>>>>>>>>   #include <asm/psci.h>
>>>>>>>>   #include <asm/efi.h>
>>>>>>>> +#include <asm/acpi.h>
>>>>>>>>
>>>>>>>>   unsigned int processor_id;
>>>>>>>>   EXPORT_SYMBOL(processor_id);
>>>>>>>> @@ -388,6 +389,8 @@ void __init setup_arch(char **cmdline_p)
>>>>>>>>        early_fixmap_init();
>>>>>>>>        early_ioremap_init();
>>>>>>>>
>>>>>>>> +     disable_acpi();
>>>>>>>> +
>>>>>>>>        parse_early_param();
>>>>>>>>
>>>>>>>>        /*
>>>>>>>
>>>>>>> Did we get to any conclusion here? DT being the preferred one i=
s fine
>>>>>>> when both DT and ACPI are present but do we still want the kern=
el to
>>>>>>> ignore ACPI altogether if DT is not present? It's a bit harder =
to detect
>>>>>>> the presence of DT at this point since the EFI_STUB added one a=
lready. I
>>>>>>> guess we could move the "acpi=3Dforce" argument passing to EFI_=
STUB if no
>>>>>>> DT is present at boot.
>>>>>>
>>>>>> Since the EFI stub populates the /chosen node in DT, I would pre=
fer
>>>>>> for it to add a property there to indicate whether it created th=
e DT
>>>>>> from scratch rather than adding ACPI specific stuff in there (ev=
en if
>>>>>> it is just a string to concatenate)
>>>>>
>>>>> This works for me. So we could pass "acpi=3Dforce" in EFI stub if=
 it
>>>>> created the DT from scratch *and* ACPI tables are present (can it=
 detect
>>>>> the latter? And maybe it could print something if none are availa=
ble).
>>>>> If that works, the actual kernel can assume that ACPI needs to be
>>>>> explicitly enabled via acpi=3Dforce, irrespective of how much inf=
ormation
>>>>> it has in DT.
>>>>
>>>> Ditto for me. I think this is a fine solution. And, yes, the stub =
can
>>>> easily detect the presence of ACPI by looking in the UEFI config t=
able.
>>>
>>> I get the point behind doing this, but could we not have it pass in=
 a
>>> different parameter than =3Dforce? Perhaps something new? I'd like =
to
>>> separate out the case that it was enabled automatically vs explicit=
ly
>>> forced on by a user wanting to use ACPI on a system with both table=
s.
>>
>> Ard had a point, so we should probably not pass acpi=3Dforce from EF=
I stub
>> (especially since a user may explicitly pass acpi=3Doff irrespective=
 of DT
>> presence). Some other property in the chosen node? It's not even an =
ABI
>> since that's a contract between EFI stub and the rest of the kernel,=
 so
>> an in-kernel only interface.
>
> Not strictly true once kexec is in place. Then it becomes a stub ->
> kernel -> kernel -> kernel -> ... interface, alnog with the rest of t=
he
> properties the stub puts in the DTB.
>
> Having something like /chosen/linux,uefi-stub-generated-dtb sounds sa=
ne
> regardless.

How about the patch (just RFC, maybe it is horrible :) ) below:

When system supporting both DT and ACPI but firmware providing
no dtb, we can use this linux,uefi-stub-generated-dtb property
to let kernel know that we can try ACPI configuration data.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
  Documentation/devicetree/bindings/chosen.txt | 19 ++++++++++++++++
  arch/arm64/kernel/setup.c                    | 34=20
+++++++++++++++++++++++++++-
  drivers/firmware/efi/libstub/fdt.c           |  6 +++++
  3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/chosen.txt=20
b/Documentation/devicetree/bindings/chosen.txt
index ed838f4..18776b9 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -44,3 +44,22 @@ Implementation note: Linux will look for the propert=
y=20
"linux,stdout-path" or
  on PowerPC "stdout" if "stdout-path" is not found.  However, the
  "linux,stdout-path" and "stdout" properties are deprecated. New platf=
orms
  should only use the "stdout-path" property.
+
+
+linux,uefi-stub-generated-dtb property
+--------------------------------------
+
+UEFI stub will generate this property in the chosen node to let linux=20
kernel
+know that there is no DTB provided by firmware.
+
+There is a use case for system supporting both DT and ACPI, when firmw=
are
+doesn't provide DT, we can try ACPI configration data to boot the syst=
em.
+
+Usage:
+
+linux,uefi-stub-generated-dtb =3D "true" means that it is true that th=
e dtb
+is generated by uefi stub
+
+or
+
+linux,uefi-stub-generated-dtb =3D "false" is the reverse.
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 54e39e3..8268c7b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -371,6 +371,31 @@ static void __init request_standard_resources(void=
)
  	}
  }

+int __init dt_scan_chosen(unsigned long node, const char *uname,
+			int depth, void *data)
+{
+	const char *p;
+=09
+	if (depth !=3D 1 || !data ||
+	    (strcmp(uname, "chosen") !=3D 0 && strcmp(uname, "chosen@0") !=3D=
 0))
+		return 0;
+
+	p =3D of_get_flat_dt_prop(node, "linux,uefi-stub-generated-dtb", NULL=
);
+	if (!p && !strcmp(p, "true"))
+		*data =3D true;
+
+	return 1;
+}
+
+static bool __init is_uefi_stub_generated_dtb(void)
+{
+	bool flag =3D false;
+
+	of_scan_flat_dt(dt_scan_chosen, &flag);
+
+	return flag;
+}
+
  u64 __cpu_logical_map[NR_CPUS] =3D { [0 ... NR_CPUS-1] =3D INVALID_HW=
ID };

  void __init setup_arch(char **cmdline_p)
@@ -389,7 +414,14 @@ void __init setup_arch(char **cmdline_p)
  	early_fixmap_init();
  	early_ioremap_init();

-	disable_acpi();
+	/*
+	 * If no dtb provided by firmware, enable ACPI
+	 * and try to boot with ACPI configuration data
+	 */
+	if (is_uefi_stub_generated_dtb())
+		enable_acpi();
+	else
+		disable_acpi();

  	parse_early_param();

diff --git a/drivers/firmware/efi/libstub/fdt.c=20
b/drivers/firmware/efi/libstub/fdt.c
index c846a96..9e2084b 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -154,6 +154,12 @@ efi_status_t update_fdt(efi_system_table_t=20
*sys_table, void *orig_fdt,
  	if (status)
  		goto fdt_set_fail;

+	/* Add a property to show the dtb is generated by uefi stub or not */
+	status =3D fdt_setprop_string(fdt, node, "linux,uefi-stub-generated-d=
tb",
+				orig_fdt ? "false" : "true");
+	if (status)
+		goto fdt_set_fail;
+
  	return EFI_SUCCESS;

  fdt_set_fail:
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
