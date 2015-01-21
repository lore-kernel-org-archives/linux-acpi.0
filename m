From: Parth Dixit <parth.dixit@linaro.org>
Subject: Re: [PATCH v7 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
 and pass acpi=force to enable ACPI
Date: Wed, 21 Jan 2015 15:13:36 +0530
Message-ID: <CABy3MNn-E+CHiHe_wjsoWv=T+Kqf4ZkqGwykh5hAW4rigqy2gA@mail.gmail.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
	<1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
	<20150119114255.GF11835@e104818-lin.cambridge.arm.com>
	<CAKv+Gu8vPKAdsNg7QC7xW+i8_BemWEx4mvBx6NrnAHi8Y+bNtw@mail.gmail.com>
	<20150119135144.GI11835@e104818-lin.cambridge.arm.com>
	<20150119151350.21B65C40948@trevor.secretlab.ca>
	<54BD3803.6020307@redhat.com>
	<20150119175233.GK11835@e104818-lin.cambridge.arm.com>
	<20150119180122.GJ21553@leverpostej>
	<54BE1FEA.5040109@linaro.org>
	<alpine.DEB.2.02.1501201901190.12653@kaball.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52391 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbbAUJnh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Jan 2015 04:43:37 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so21350485wid.5
        for <linux-acpi@vger.kernel.org>; Wed, 21 Jan 2015 01:43:36 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1501201901190.12653@kaball.uk.xensource.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Will Deacon <Will.Deacon@arm.com>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Timur Tabi <timur@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>

On 21 January 2015 at 00:50, Stefano Stabellini
<stefano.stabellini@eu.citrix.com> wrote:
> On Tue, 20 Jan 2015, Hanjun Guo wrote:
>> On 2015=E5=B9=B401=E6=9C=8820=E6=97=A5 02:01, Mark Rutland wrote:
>> > On Mon, Jan 19, 2015 at 05:52:33PM +0000, Catalin Marinas wrote:
>> > > On Mon, Jan 19, 2015 at 04:59:47PM +0000, Jon Masters wrote:
>> > > > On 01/19/2015 10:13 AM, Grant Likely wrote:
>> > > > > On Mon, 19 Jan 2015 13:51:45 +0000
>> > > > > , Catalin Marinas <catalin.marinas@arm.com>
>> > > > >   wrote:
>> > > > > > On Mon, Jan 19, 2015 at 11:55:32AM +0000, Ard Biesheuvel w=
rote:
>> > > > > > > On 19 January 2015 at 11:42, Catalin Marinas
>> > > > > > > <catalin.marinas@arm.com> wrote:
>> > > > > > > > On Wed, Jan 14, 2015 at 03:04:52PM +0000, Hanjun Guo w=
rote:
>> > > > > > > > > From: Al Stone <al.stone@linaro.org>
>> > > > > > > > >
>> > > > > > > > > Introduce one early parameters "off" and "force" for=
 "acpi",
>> > > > > > > > > acpi=3Doff
>> > > > > > > > > will be the default behavior for ARM64, so introduce
>> > > > > > > > > acpi=3Dforce to
>> > > > > > > > > enable ACPI on ARM64.
>> > > > > > > > >
>> > > > > > > > > Disable ACPI before early parameters parsed, and ena=
ble it to
>> > > > > > > > > pass
>> > > > > > > > > "acpi=3Dforce" if people want use ACPI on ARM64. Thi=
s ensures DT
>> > > > > > > > > be
>> > > > > > > > > the prefer one if ACPI table and DT both are provide=
d at this
>> > > > > > > > > moment.
>> > > > > > > > [...]
>> > > > > > > > > --- a/arch/arm64/kernel/setup.c
>> > > > > > > > > +++ b/arch/arm64/kernel/setup.c
>> > > > > > > > > @@ -62,6 +62,7 @@
>> > > > > > > > >   #include <asm/memblock.h>
>> > > > > > > > >   #include <asm/psci.h>
>> > > > > > > > >   #include <asm/efi.h>
>> > > > > > > > > +#include <asm/acpi.h>
>> > > > > > > > >
>> > > > > > > > >   unsigned int processor_id;
>> > > > > > > > >   EXPORT_SYMBOL(processor_id);
>> > > > > > > > > @@ -388,6 +389,8 @@ void __init setup_arch(char **cm=
dline_p)
>> > > > > > > > >        early_fixmap_init();
>> > > > > > > > >        early_ioremap_init();
>> > > > > > > > >
>> > > > > > > > > +     disable_acpi();
>> > > > > > > > > +
>> > > > > > > > >        parse_early_param();
>> > > > > > > > >
>> > > > > > > > >        /*
>> > > > > > > >
>> > > > > > > > Did we get to any conclusion here? DT being the prefer=
red one is
>> > > > > > > > fine
>> > > > > > > > when both DT and ACPI are present but do we still want=
 the
>> > > > > > > > kernel to
>> > > > > > > > ignore ACPI altogether if DT is not present? It's a bi=
t harder
>> > > > > > > > to detect
>> > > > > > > > the presence of DT at this point since the EFI_STUB ad=
ded one
>> > > > > > > > already. I
>> > > > > > > > guess we could move the "acpi=3Dforce" argument passin=
g to
>> > > > > > > > EFI_STUB if no
>> > > > > > > > DT is present at boot.
>> > > > > > >
>> > > > > > > Since the EFI stub populates the /chosen node in DT, I w=
ould
>> > > > > > > prefer
>> > > > > > > for it to add a property there to indicate whether it cr=
eated the
>> > > > > > > DT
>> > > > > > > from scratch rather than adding ACPI specific stuff in t=
here (even
>> > > > > > > if
>> > > > > > > it is just a string to concatenate)
>> > > > > >
>> > > > > > This works for me. So we could pass "acpi=3Dforce" in EFI =
stub if it
>> > > > > > created the DT from scratch *and* ACPI tables are present =
(can it
>> > > > > > detect
>> > > > > > the latter? And maybe it could print something if none are
>> > > > > > available).
>> > > > > > If that works, the actual kernel can assume that ACPI need=
s to be
>> > > > > > explicitly enabled via acpi=3Dforce, irrespective of how m=
uch
>> > > > > > information
>> > > > > > it has in DT.
>> > > > >
>> > > > > Ditto for me. I think this is a fine solution. And, yes, the=
 stub can
>> > > > > easily detect the presence of ACPI by looking in the UEFI co=
nfig
>> > > > > table.
>> > > >
>> > > > I get the point behind doing this, but could we not have it pa=
ss in a
>> > > > different parameter than =3Dforce? Perhaps something new? I'd =
like to
>> > > > separate out the case that it was enabled automatically vs exp=
licitly
>> > > > forced on by a user wanting to use ACPI on a system with both =
tables.
>> > >
>> > > Ard had a point, so we should probably not pass acpi=3Dforce fro=
m EFI stub
>> > > (especially since a user may explicitly pass acpi=3Doff irrespec=
tive of DT
>> > > presence). Some other property in the chosen node? It's not even=
 an ABI
>> > > since that's a contract between EFI stub and the rest of the ker=
nel, so
>> > > an in-kernel only interface.
>> >
>> > Not strictly true once kexec is in place. Then it becomes a stub -=
>
>> > kernel -> kernel -> kernel -> ... interface, alnog with the rest o=
f the
>> > properties the stub puts in the DTB.
>> >
>> > Having something like /chosen/linux,uefi-stub-generated-dtb sounds=
 sane
>> > regardless.
>>
>> How about the patch (just RFC, maybe it is horrible :) ) below:
>>
>> When system supporting both DT and ACPI but firmware providing
>> no dtb, we can use this linux,uefi-stub-generated-dtb property
>> to let kernel know that we can try ACPI configuration data.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/chosen.txt | 19 ++++++++++++++++
>>  arch/arm64/kernel/setup.c                    | 34
>> +++++++++++++++++++++++++++-
>>  drivers/firmware/efi/libstub/fdt.c           |  6 +++++
>>  3 files changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/chosen.txt
>> b/Documentation/devicetree/bindings/chosen.txt
>> index ed838f4..18776b9 100644
>> --- a/Documentation/devicetree/bindings/chosen.txt
>> +++ b/Documentation/devicetree/bindings/chosen.txt
>> @@ -44,3 +44,22 @@ Implementation note: Linux will look for the prop=
erty
>> "linux,stdout-path" or
>>  on PowerPC "stdout" if "stdout-path" is not found.  However, the
>>  "linux,stdout-path" and "stdout" properties are deprecated. New pla=
tforms
>>  should only use the "stdout-path" property.
>> +
>> +
>> +linux,uefi-stub-generated-dtb property
>> +--------------------------------------
>> +
>> +UEFI stub will generate this property in the chosen node to let lin=
ux kernel
>> +know that there is no DTB provided by firmware.
>> +
>> +There is a use case for system supporting both DT and ACPI, when fi=
rmware
>> +doesn't provide DT, we can try ACPI configration data to boot the s=
ystem.
>> +
>> +Usage:
>> +
>> +linux,uefi-stub-generated-dtb =3D "true" means that it is true that=
 the dtb
>> +is generated by uefi stub
>> +
>> +or
>> +
>> +linux,uefi-stub-generated-dtb =3D "false" is the reverse.
>
> I am sorry to have to make the discussion even more complex than alre=
ady
> is, however we have one more use case to consider: Linux booting on X=
en
> as Dom0.
>
> When booting as Dom0 on ACPI hardware, Linux doesn't have access to t=
he
> UEFI firmware (no EFI stub). Xen passes a small device tree blob with
> a chosen node, memory information and a pointer to the ACPI tables.
> It looks similar to the DTB passed to Linux by the EFI stub but it is
> generated by Xen instead.
>
> See also Christoffer's explanation:
>
> http://marc.info/?l=3Dlinux-arm-kernel&m=3D142169977401658&w=3D2
>
> The actual patches haven't been posted to the list yet, but Linaro se=
ems
> to have an internal prototype working already. We really need to
> document this interface properly soon if we expect future Linux and X=
en
> to adhere to it (hint hint).
>
> In the Dom0 case Linux should parse the small device tree binary, the=
n
> enable acpi.
>
> Maybe we could generalize the concept of this uefi-stub-generated-dtb
> variable and call it instead "enable_acpi", optionally exporting the
> RDSP, like Parth's patches to Xen are doing (I haven't seen the code =
yet
> so I don't know the details).
>
> Do you think that would work for you?
Here is the actual patch for booting linux on xen without uefi,

https://git.linaro.org/people/parth.dixit/xen-acpi-support/leg-kernel.g=
it/commitdiff/0b9ca47a801d6f63e6fbf1885962b7d6b9910d1d?hp=3D380ad5d8817=
a03204e6a92d0ad1450ec32886d80

it is working and we are able to boot to linux from xen.
We are doing this by passing RSDP pointer in skeleton device tree to li=
nux
and reading it as part of early boot initialization.
As explained by stefano and christoffer we are not exposing UEFI
so the EFI stub based approach will not work for us.
Also we need to describe the memory in device tree
as ACPI does not contain that information.
Is it possible that we don't tie up EFI with ACPI ?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
