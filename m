From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v8 08/21] dt / chosen: Add linux,uefi-stub-generated-dtb property
Date: Wed, 11 Feb 2015 14:53:21 +0800
Message-ID: <CAKv+Gu_uXs7tto3JdEOoEfqFpjUKdwFo4dSN3X3399uc+sJKrQ@mail.gmail.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
	<1422881149-8177-9-git-send-email-hanjun.guo@linaro.org>
	<20150202134033.GR4278@bivouac.eciton.net>
	<20150202135051.GA3825@xora-haswell.xora.org.uk>
	<20150202163253.GG21175@leverpostej>
	<CAGCh1+nL7YMXYp42ekWAqmw_m5cy=s_7NszLDAXj=bUr2aZVig@mail.gmail.com>
	<54D5884A.6050009@linaro.org>
	<CAKv+Gu-oDRjYPC3SxSDVZ7rV7eG9DCct=kNS0xBVd28YoV5fSg@mail.gmail.com>
	<20150209114624.GD4250@leverpostej>
	<CAKv+Gu-fnpxr-3T9RPuf4de2DGVE6xkDEcfFyzYp5KJCJH_fzw@mail.gmail.com>
	<alpine.DEB.2.02.1502110607250.29696@kaball.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1502110607250.29696@kaball.uk.xensource.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Mark Langsdorf <mlangsdo@redhat.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Jonathan Corbet <corbet@lwn.net>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@l>
List-Id: linux-acpi@vger.kernel.org

On 11 February 2015 at 14:33, Stefano Stabellini
<stefano.stabellini@eu.citrix.com> wrote:
> On Wed, 11 Feb 2015, Ard Biesheuvel wrote:
>> On 9 February 2015 at 19:46, Mark Rutland <mark.rutland@arm.com> wro=
te:
>> > On Sat, Feb 07, 2015 at 05:03:44AM +0000, Ard Biesheuvel wrote:
>> >> On 7 February 2015 at 03:36, Hanjun Guo <hanjun.guo@linaro.org> w=
rote:
>> >> > On 2015=E5=B9=B402=E6=9C=8806=E6=97=A5 18:34, G Gregory wrote:
>> >> > [...]
>> >> >
>> >> >>>>>>
>> >> >>>>>> ----------------------------------------------------------=
----------------------
>> >> >>>>>>   linux,uefi-stub-kern-ver  | string | Copy of linux_banne=
r from
>> >> >>>>>> build.
>> >> >>>>>>
>> >> >>>>>> ----------------------------------------------------------=
----------------------
>> >> >>>>>> +linux,uefi-stub-generated-dtb  | bool | Indication for no=
 DTB
>> >> >>>>>> provided by
>> >> >>>>>> +                        |      | firmware.
>> >> >>>>>>
>> >> >>>>>> +---------------------------------------------------------=
-----------------------
>> >> >>>>>
>> >> >>>>>
>> >> >>>>> Apologies for the late bikeshedding, but the discussion on =
this topic
>> >> >>>>> previsously was lively enough that I thought I'd let it die=
 down a bit
>> >> >>>>> before seeing if I had anything to add.
>> >> >>>>>
>> >> >>>>> That, and I just realised something:
>> >> >>>>> One alternative to this added DT entry is that we could tre=
at the
>> >> >>>>> absence of a registered UEFI configuration table as the ind=
ication
>> >> >>>>> that no HW description was provided from firmware, since th=
e stub does
>> >> >>>>> not call InstallConfigurationTable() on the DT it generates=
=2E This does
>> >> >>>>> move the ability to detect to after efi_init(), but this sh=
ould be
>> >> >>>>> fine for ACPI-purposes.
>> >> >>>>>
>> >> >>>> That would not work as expected in the kexec/Xen use case th=
ough as they
>> >> >>>> may genuinely boot with DT from an ACPI host without UEFI.
>> >> >>>
>> >> >>>
>> >> >>> I'm a little concerned by this case. How do we intend to pass=
 stuff from
>> >> >>> Xen to the kernel in this case? When we initially discussed t=
he stub
>> >> >>> prior to merging, we weren't quite sure if ACPI without UEFI =
was
>> >> >>> entirely safe.
>> >> >>>
>> >> >>> The linux,uefi-stub-kern-ver property was originally intended=
 as a
>> >> >>> sanity-check feature to ensure nothing (including Xen) masque=
raded as
>> >> >>> the stub, but for some reason the actual sanity check was nev=
er
>> >> >>> implemented.
>> >> >>>
>> >> >>>>> If that is deemed undesirable, I would still prefer Catalin=
's
>> >> >>>>> suggested name ("linux,bare-dtb"), which describes the stat=
e rather
>> >> >>>>> than the route we took to get there.
>> >> >>>>>
>> >> >>>> I agree.
>> >> >>>
>> >> >>>
>> >> >>> I guess this would be ok, though it would be nice to know whi=
ch agent
>> >> >>> generated the DTB.
>> >> >>>
>> >> >>
>> >> >> The most obvious scheme then is
>> >> >>
>> >> >> linux,bare-dtb =3D "uefi-stub";
>> >> >>
>> >> >> otherwise we generate a new binding for every component in the=
 boot path.
>> >> >
>> >> >
>> >> > Leif, Mark, any comments on this?
>> >> >
>> >>
>> >> As far as I remember, we did not finalize the decision to go with=
 a
>> >> stub generated property instead of some other means to infer that=
 the
>> >> device tree is not suitable for booting and ACPI should be prefer=
red.
>> >>
>> >> We will be discussing the 'stub<->kernel interface as a boot prot=
ocol'
>> >> topic this week at Connect, so let's discuss it in that context b=
efore
>> >> signing off on patches like these.
>> >
>> > As some of us (at least myself) aren't at connect, it would be nic=
e if
>> > those discussions could be at least mirrored on the mailing list. =
I have
>> > some concerns regarding how this is going to work long-term, and I=
'd
>> > like to make sure we don't get stuck with something that limits wh=
at we
>> > can do long-term.
>> >
>> > Is there a session set aside for this, or is this a hallway track =
topic?
>> >
>>
>> Hello all,
>>
>> (added team-Xen to cc)
>>
>> We had our meeting yesterday: allow me to summarize what we discusse=
d,
>> and we can proceed with the discussion on-list if desired.
>>
>> Present:
>> Grant Likely
>> Al Stone
>> Hanjun Guo
>> Leif Lindholm
>> Roy Franz
>> Ard Biesheuvel
>>
>> Topic #1: booting the arm64 kernel with ACPI but no UEFI
>>
>> We have identified Xen as the only use case: there is a need to boot
>> dom0 using the host's ACPI tables but without allowing the dom0 kern=
el
>> to interface directly with the UEFI firmware. There may be other val=
id
>> use cases, though, so this use case should be addressed generically
>> regardless.
>>
>> First, it was proposed to allow the ACPI root pointer to be added to=
 a
>> /chosen node property, and the kernel would use this property instea=
d
>> of going through the UEFI tables.
>> However, there is a similar case that could be made for SMBIOS: unli=
ke
>> x86, where there is a 'legacy' method to locate either table by
>> scanning some special physical memory regions, the respective
>> specifications only provide a single method to perform table
>> discovery, which is through UEFI. This means that passing the ACPI
>> root pointer to the kernel using a property in the /chosen node
>> doesn't scale well, as we would need to do the same for SMBIOS at
>> least, and potentially other tables in the future.
>
> TBH there are no other tables and even if there were, this method wou=
ld
> still scale linearly with the number of tables, that is not bad in my
> view.
>

=46air enough

>
>> There are two other concerns related to passing the ACPI root pointe=
r directly:
>> - the actual discovery occurs in core code, and we are reluctant to
>> change it to accommodate arm64 specific behavior
>> - it would create separate paths through the early boot code which
>> complicates testing and validation
>
> OK
>
>
>> So instead, we think it is reasonable to mandate a minimal subset of
>> the UEFI environment to be present, either natively or emulated/mock=
ed
>> up by Xen, kexec etc.
>
> No emulation please :-)
>

Well, perhaps 'emulated' is not the right term to use here. It is just
about presenting a couple of data items in the same way that UEFI
presents them

>
>> - an EFI system table (and a /chosen/linux,uefi-system-table that
>> points to it) containing at least
>>   * a fully populated header with version >=3D 2.0 and correct CRC
>>   * populated fw_vendor string
>>   * configuration table pointer and count, pointing to the ACPI and
>> SMBIOS configuration tables with their respective GUIDs
>>   * NULL runtime services function table pointer
>>
>> - an EFI format memory map (and the /chosen/linux,uefi-mmap-*
>> properties that go with it) covering all of system RAM, with ACPI an=
d
>> SMBIOS reserved regions marked as appropriate
>
> Runtime services actually are going to be available via hypercalls, s=
ee
> drivers/xen/efi.c, but Boot Services are not going to be.
>

I was aware of that, but it does mean that the early UEFI code should
not try to install virtual remappings of the UEFI runtime memory
regions, as all the machinery is either in the kernel or in the
hypervisor. So even if the Xen guest code installs a Runtime Services
dispatch table at some point, the existing code should still be
defused.

In the native UEFI case, the stub calls ExitBootServices() so boot
services are not part of the equation anyway. (They are never
available when running in the kernel proper)

> Given that Dom0 is not booted via EFI but as zImage, how are we going=
 to
> pass the two EFI table pointers to Linux? Via Device Tree? It doesn't
> look like a great improvement to me.
>

The EFI system table and memory map pointers shall be passed to the
kernel in the exact same way as the stub does: via the /chosen node.
This is currently documented in Documentation/arm/uefi.txt but it
should be promoted to a proper binding.

> Generating those two EFI tables shouldn't be a problem though.
>
>

Good.

>> As this basically promotes the stub<->kernel interface to an externa=
l
>> ABI, the current documentation about the /chosen node properties
>> should also be promoted to a proper binding, with the above mandated
>> minimal subset added as well.
>>
>> There are some minimal changes required to the current kernel code t=
o
>> adhere to the above: primarlly to deal with a NULL runtime services
>> pointer, which is arguably an improvement anyway.
>
> This is not needed, if not for the first generation of patches
>
>

It is needed: the UEFI code needs to understand that the runtime
pointer in the EFI system table may be NULL, in which case no virtual
remapping or installation of the runtime services should take place.
Whether Xen ends up installing its own runtime services is a separate
matter.

>> Topic #2: how to identify an 'empty' DTB
>>
>> The proposed policy regarding whether DT or ACPI should be preferred
>> if both methods are available hinges on being able to identify a DTB
>> as containing a platform description or not. One suggested way of
>> doing this is to make the stub add a /chosen node property that
>> indicates that it didn't receive a DTB from the firmware, nor loaded
>> one from the file system, but created an empty one from scratch.
>>
>> Considering the previous topic, i.e., the promotion of the
>> stub<->kernel interface to external ABI, we should not be frivolous
>> about adding new properties, and adding a 'stub-generated-dtb'
>> property should be avoided if there is a better way to deal with thi=
s.
>> Also, e.g., when booting via GRUB, it may in fact be GRUB and not th=
e
>> stub that creates the DTB (when booting with an initrd, for instance=
)
>> so GRUB would have to be modified as well. (If not, simply adding a
>> initrd=3D property to the command line would result in the kernel
>> preferring DT over ACPI all of a sudden, which surely, we all agree =
is
>> undesirable behavior)
>>
>> So instead, we propose to use a heuristic to decide whether a DTB
>> should be considered empty or not:
>> If /chosen is the only level 1 node in the tree, the DTB is empty,
>> otherwise it is not.
>>
>> This can be trivially implemented into the existing EFI early FDT
>> discovery code, and does not require any other changes to the stub o=
r
>> GRUB.
>>
>> Please, could those affected by this comment whether this is feasibl=
e
>> or not? Other comments/remarks also highly appreciated, of course,
>
> Wouldn't it make sense to use the same interface between Xen and Dom0
> and between stub and kernel?

That is exactly the point: the stub communicates the EFI entry points
(system table and memmap) via the device tree. If you are not booting
via UEFI, there is no way you can execute the stub, so Xen needs to
add those properties to the /chosen node directly, and make them point
to data that the UEFI layer can understand.

--=20
Ard.
