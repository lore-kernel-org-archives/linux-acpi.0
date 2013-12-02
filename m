From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: randconfig build error with next-20131202, in arch/x86/pci
Date: Mon, 2 Dec 2013 16:14:32 -0700
Message-ID: <CAErSpo4a2CcEpt6okjTS-wyGCgc7JsHWnGPn7FXrhRfwXqj=oA@mail.gmail.com>
References: <CA+r1ZhiKj_0HXb7s1oDc-Pgm6n63rYNpxzqXfxKDgdKZU27LcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <CA+r1ZhiKj_0HXb7s1oDc-Pgm6n63rYNpxzqXfxKDgdKZU27LcQ@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Jim Davis <jim.epost@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next list <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

[+cc Lv, Rafael, linux-acpi]

Is this fallout related to "ACPI: Cleanup <acpi/acpi.h>,
<acpi/acpi_bus.h> and <acpi/acpi_drivers.h> inclusions"?

On Mon, Dec 2, 2013 at 7:57 AM, Jim Davis <jim.epost@gmail.com> wrote:
> Building with the attached random configuration file,
>
> arch/x86/pci/mmconfig-shared.c:373:1: error: unknown type name =91acp=
i_status=92
>  static acpi_status check_mcfg_resource(struct acpi_resource *res, vo=
id *data)
>  ^
> arch/x86/pci/mmconfig-shared.c:373:47: warning: =91struct acpi_resour=
ce=92
> declared inside parameter list [enabled by default]
>  static acpi_status check_mcfg_resource(struct acpi_resource *res, vo=
id *data)
>                                                ^
> arch/x86/pci/mmconfig-shared.c:373:47: warning: its scope is only thi=
s
> definition or declaration, which is probably not what you want
> [enabled by default]
> arch/x86/pci/mmconfig-shared.c: In function =91check_mcfg_resource=92=
:
> arch/x86/pci/mmconfig-shared.c:376:33: error: storage size of
> =91address=92 isn=92t known
>   struct acpi_resource_address64 address;
>                                  ^
> arch/x86/pci/mmconfig-shared.c:377:2: error: unknown type name =91acp=
i_status=92
>   acpi_status status;
>   ^
> arch/x86/pci/mmconfig-shared.c:379:9: error: dereferencing pointer to
> incomplete type
>   if (res->type =3D=3D ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
>          ^
> arch/x86/pci/mmconfig-shared.c:379:19: error:
> =91ACPI_RESOURCE_TYPE_FIXED_MEMORY32=92 undeclared (first use in this
> function)
>   if (res->type =3D=3D ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
>                    ^
> arch/x86/pci/mmconfig-shared.c:379:19: note: each undeclared
> identifier is reported only once for each function it appears in
> arch/x86/pci/mmconfig-shared.c:381:8: error: dereferencing pointer to
> incomplete type
>     &res->data.fixed_memory32;
>         ^
> arch/x86/pci/mmconfig-shared.c:383:11: error: =91AE_OK=92 undeclared
> (first use in this function)
>     return AE_OK;
>            ^
> arch/x86/pci/mmconfig-shared.c:384:35: error: dereferencing pointer t=
o
> incomplete type
>    if ((mcfg_res->start >=3D fixmem32->address) &&
>                                    ^
> arch/x86/pci/mmconfig-shared.c:385:33: error: dereferencing pointer t=
o
> incomplete type
>        (mcfg_res->end < (fixmem32->address +
>                                  ^
> arch/x86/pci/mmconfig-shared.c:386:19: error: dereferencing pointer t=
o
> incomplete type
>            fixmem32->address_length))) {
>                    ^
> arch/x86/pci/mmconfig-shared.c:388:11: error: =91AE_CTRL_TERMINATE=92
> undeclared (first use in this function)
>     return AE_CTRL_TERMINATE;
>            ^
> arch/x86/pci/mmconfig-shared.c:391:10: error: dereferencing pointer t=
o
> incomplete type
>   if ((res->type !=3D ACPI_RESOURCE_TYPE_ADDRESS32) &&
>           ^
> arch/x86/pci/mmconfig-shared.c:391:20: error:
> =91ACPI_RESOURCE_TYPE_ADDRESS32=92 undeclared (first use in this func=
tion)
>   if ((res->type !=3D ACPI_RESOURCE_TYPE_ADDRESS32) &&
>                     ^
> arch/x86/pci/mmconfig-shared.c:392:10: error: dereferencing pointer t=
o
> incomplete type
>       (res->type !=3D ACPI_RESOURCE_TYPE_ADDRESS64))
>           ^
> arch/x86/pci/mmconfig-shared.c:392:20: error:
> =91ACPI_RESOURCE_TYPE_ADDRESS64=92 undeclared (first use in this func=
tion)
>       (res->type !=3D ACPI_RESOURCE_TYPE_ADDRESS64))
>                     ^
> arch/x86/pci/mmconfig-shared.c:395:2: error: implicit declaration of
> function =91acpi_resource_to_address64=92
> [-Werror=3Dimplicit-function-declaration]
>   status =3D acpi_resource_to_address64(res, &address);
>   ^
> arch/x86/pci/mmconfig-shared.c:396:2: error: implicit declaration of
> function =91ACPI_FAILURE=92 [-Werror=3Dimplicit-function-declaration]
>   if (ACPI_FAILURE(status) ||
>   ^
> arch/x86/pci/mmconfig-shared.c:398:31: error: =91ACPI_MEMORY_RANGE=92
> undeclared (first use in this function)
>      (address.resource_type !=3D ACPI_MEMORY_RANGE))
>                                ^
> arch/x86/pci/mmconfig-shared.c:376:33: warning: unused variable
> =91address=92 [-Wunused-variable]
>   struct acpi_resource_address64 address;
>                                  ^
> arch/x86/pci/mmconfig-shared.c: At top level:
> arch/x86/pci/mmconfig-shared.c:409:1: error: unknown type name =91acp=
i_status=92
>  static acpi_status find_mboard_resource(acpi_handle handle, u32 lvl,
>  ^
> arch/x86/pci/mmconfig-shared.c:409:41: error: unknown type name =91ac=
pi_handle=92
>  static acpi_status find_mboard_resource(acpi_handle handle, u32 lvl,
>                                          ^
> arch/x86/pci/mmconfig-shared.c: In function =91is_acpi_reserved=92:
> arch/x86/pci/mmconfig-shared.c:431:2: error: implicit declaration of
> function =91acpi_get_devices=92 [-Werror=3Dimplicit-function-declarat=
ion]
>   acpi_get_devices("PNP0C01", find_mboard_resource, &mcfg_res, NULL);
>   ^
> arch/x86/pci/mmconfig-shared.c:431:30: error: =91find_mboard_resource=
=92
> undeclared            ^
> jim@krebstar:~$ more errs
> jim@krebstar:~$ cat errs
> arch/x86/pci/mmconfig-shared.c:373:1: error: unknown type name =91acp=
i_status=92
>  static acpi_status check_mcfg_resource(struct acpi_resource *res, vo=
id *data)
>  ^
> arch/x86/pci/mmconfig-shared.c:373:47: warning: =91struct acpi_resour=
ce=92
> declared inside parameter list [enabled by default]
>  static acpi_status check_mcfg_resource(struct acpi_resource *res, vo=
id *data)
>                                                ^
> arch/x86/pci/mmconfig-shared.c:373:47: warning: its scope is only thi=
s
> definition or declaration, which is probably not what you want
> [enabled by default]
> arch/x86/pci/mmconfig-shared.c: In function =91check_mcfg_resource=92=
:
> arch/x86/pci/mmconfig-shared.c:376:33: error: storage size of
> =91address=92 isn=92t known
>   struct acpi_resource_address64 address;
>                                  ^
> arch/x86/pci/mmconfig-shared.c:377:2: error: unknown type name =91acp=
i_status=92
>   acpi_status status;
>   ^
> arch/x86/pci/mmconfig-shared.c:379:9: error: dereferencing pointer to
> incomplete type
>   if (res->type =3D=3D ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
>          ^
> arch/x86/pci/mmconfig-shared.c:379:19: error:
> =91ACPI_RESOURCE_TYPE_FIXED_MEMORY32=92 undeclared (first use in this
> function)
>   if (res->type =3D=3D ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
>                    ^
> arch/x86/pci/mmconfig-shared.c:379:19: note: each undeclared
> identifier is reported only once for each function it appears in
> arch/x86/pci/mmconfig-shared.c:381:8: error: dereferencing pointer to
> incomplete type
>     &res->data.fixed_memory32;
>         ^
> arch/x86/pci/mmconfig-shared.c:383:11: error: =91AE_OK=92 undeclared
> (first use in this function)
>     return AE_OK;
>            ^
> arch/x86/pci/mmconfig-shared.c:384:35: error: dereferencing pointer t=
o
> incomplete type
>    if ((mcfg_res->start >=3D fixmem32->address) &&
>                                    ^
> arch/x86/pci/mmconfig-shared.c:385:33: error: dereferencing pointer t=
o
> incomplete type
>        (mcfg_res->end < (fixmem32->address +
>                                  ^
> arch/x86/pci/mmconfig-shared.c:386:19: error: dereferencing pointer t=
o
> incomplete type
>            fixmem32->address_length))) {
>                    ^
> arch/x86/pci/mmconfig-shared.c:388:11: error: =91AE_CTRL_TERMINATE=92
> undeclared (first use in this function)
>     return AE_CTRL_TERMINATE;
>            ^
> arch/x86/pci/mmconfig-shared.c:391:10: error: dereferencing pointer t=
o
> incomplete type
>   if ((res->type !=3D ACPI_RESOURCE_TYPE_ADDRESS32) &&
>           ^
> arch/x86/pci/mmconfig-shared.c:391:20: error:
> =91ACPI_RESOURCE_TYPE_ADDRESS32=92 undeclared (first use in this func=
tion)
>   if ((res->type !=3D ACPI_RESOURCE_TYPE_ADDRESS32) &&
>                     ^
> arch/x86/pci/mmconfig-shared.c:392:10: error: dereferencing pointer t=
o
> incomplete type
>       (res->type !=3D ACPI_RESOURCE_TYPE_ADDRESS64))
>           ^
> arch/x86/pci/mmconfig-shared.c:392:20: error:
> =91ACPI_RESOURCE_TYPE_ADDRESS64=92 undeclared (first use in this func=
tion)
>       (res->type !=3D ACPI_RESOURCE_TYPE_ADDRESS64))
>                     ^
> arch/x86/pci/mmconfig-shared.c:395:2: error: implicit declaration of
> function =91acpi_resource_to_address64=92
> [-Werror=3Dimplicit-function-declaration]
>   status =3D acpi_resource_to_address64(res, &address);
>   ^
> arch/x86/pci/mmconfig-shared.c:396:2: error: implicit declaration of
> function =91ACPI_FAILURE=92 [-Werror=3Dimplicit-function-declaration]
>   if (ACPI_FAILURE(status) ||
>   ^
> arch/x86/pci/mmconfig-shared.c:398:31: error: =91ACPI_MEMORY_RANGE=92
> undeclared (first use in this function)
>      (address.resource_type !=3D ACPI_MEMORY_RANGE))
>                                ^
> arch/x86/pci/mmconfig-shared.c:376:33: warning: unused variable
> =91address=92 [-Wunused-variable]
>   struct acpi_resource_address64 address;
>                                  ^
> arch/x86/pci/mmconfig-shared.c: At top level:
> arch/x86/pci/mmconfig-shared.c:409:1: error: unknown type name =91acp=
i_status=92
>  static acpi_status find_mboard_resource(acpi_handle handle, u32 lvl,
>  ^
> arch/x86/pci/mmconfig-shared.c:409:41: error: unknown type name =91ac=
pi_handle=92
>  static acpi_status find_mboard_resource(acpi_handle handle, u32 lvl,
>                                          ^
> arch/x86/pci/mmconfig-shared.c: In function =91is_acpi_reserved=92:
> arch/x86/pci/mmconfig-shared.c:431:2: error: implicit declaration of
> function =91acpi_get_devices=92 [-Werror=3Dimplicit-function-declarat=
ion]
>   acpi_get_devices("PNP0C01", find_mboard_resource, &mcfg_res, NULL);
>   ^
> arch/x86/pci/mmconfig-shared.c:431:30: error: =91find_mboard_resource=
=92
> undeclared (first use in this function)
>   acpi_get_devices("PNP0C01", find_mboard_resource, &mcfg_res, NULL);
>                               ^
> arch/x86/pci/mmconfig-shared.c: At top level:
> arch/x86/pci/mmconfig-shared.c:544:13: warning: =91struct
> acpi_mcfg_allocation=92 declared inside parameter list [enabled by
> default]
>       struct acpi_mcfg_allocation *cfg)
>              ^
> arch/x86/pci/mmconfig-shared.c:544:13: warning: =91struct
> acpi_table_mcfg=92 declared inside parameter list [enabled by default=
]
> arch/x86/pci/mmconfig-shared.c: In function =91acpi_mcfg_check_entry=92=
:
> arch/x86/pci/mmconfig-shared.c:548:9: error: dereferencing pointer to
> incomplete type
>   if (cfg->address < 0xFFFFFFFF)
>          ^
> arch/x86/pci/mmconfig-shared.c:551:19: error: dereferencing pointer t=
o
> incomplete type
>   if (!strncmp(mcfg->header.oem_id, "SGI", 3))
>                    ^
> arch/x86/pci/mmconfig-shared.c:554:10: error: dereferencing pointer t=
o
> incomplete type
>   if (mcfg->header.revision >=3D 1) {
>           ^
> In file included from include/linux/kernel.h:13:0,
>                  from include/linux/kernfs.h:10,
>                  from include/linux/sysfs.h:15,
>                  from include/linux/kobject.h:21,
>                  from include/linux/pci.h:28,
>                  from arch/x86/pci/mmconfig-shared.c:13:
> arch/x86/pci/mmconfig-shared.c:561:39: error: dereferencing pointer t=
o
> incomplete type
>          "is above 4GB, ignored\n", cfg->pci_segment,
>                                        ^
> include/linux/printk.h:217:33: note: in definition of macro =91pr_err=
=92
>   printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>                                  ^
>            ^
> arch/x86/pci/mmconfig-shared.c:600:32: error: dereferencing pointer t=
o
> incomplete type
>         cfg->end_bus_number, cfg->address) =3D=3D NULL) {
>                                 ^
> arch/x86/pci/mmconfig-shared.c: In function =91pci_mmcfg_early_init=92=
:
> arch/x86/pci/mmconfig-shared.c:642:25: error: =91ACPI_SIG_MCFG=92
> undeclared (first use in this function)
>     acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
>                          ^
> arch/x86/pci/mmconfig-shared.c: In function =91pci_mmcfg_late_init=92=
:
> arch/x86/pci/mmconfig-shared.c:658:24: error: =91ACPI_SIG_MCFG=92
> undeclared (first use in this function)
>    acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
>                         ^
> arch/x86/pci/mmconfig-shared.c: At top level:
> arch/x86/pci/mmconfig-shared.c:373:20: warning: =91check_mcfg_resourc=
e=92
> defined but not used [-Wunused-function]
>  static acpi_status check_mcfg_resource(struct acpi_resource *res, vo=
id *data)
>                     ^
> cc1: some warnings being treated as errors
> make[1]: *** [arch/x86/pci/mmconfig-shared.o] Error 1
