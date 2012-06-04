From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH -next] acpi: fix acpi_bus.h warnings when ACPI is not
 enabled
Date: Mon, 04 Jun 2012 07:42:00 -0700
Message-ID: <4FCCC938.7080900@xenotime.net>
References: <20120523170740.ae058d8d5468d471eb948c39@canb.auug.org.au> <4FBD0CDD.6010003@xenotime.net> <4FCC3A4C.2080407@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FCC3A4C.2080407@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On 06/03/2012 09:32 PM, Len Brown wrote:

> Hi Randy,
> with your patch applied and CONFIG_ACPI=3Dn, I still get:
>=20
> include/acpi/acpi_bus.h:445:12: warning: =91register_acpi_bus_type=92=
 defined but not used [-Wunused-function]
> include/acpi/acpi_bus.h:446:12: warning: =91unregister_acpi_bus_type=92=
 defined but not used [-Wunused-function]
>=20
> so I think I prefer the patch below.

Hi Len,

I'd love to see your failing .config file if you have it or can
reproduce it.  My patch still works for me.


> thanks,
> Len Brown, Intel Open Source Technology Center
>=20
> On 05/23/2012 12:14 PM, Randy Dunlap wrote:
>=20
>> From: Randy Dunlap <rdunlap@xenotime.net>
>>
>> Fix header file warnings when CONFIG_ACPI is not enabled:
>>
>> include/acpi/acpi_bus.h:443:42: warning: 'struct acpi_bus_type' decl=
ared inside parameter list
>> include/acpi/acpi_bus.h:443:42: warning: its scope is only this defi=
nition or declaration, which is probably not what you want
>> include/acpi/acpi_bus.h:444:44: warning: 'struct acpi_bus_type' decl=
ared inside parameter list
>>
>> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
>> ---
>>  include/acpi/acpi_bus.h |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> --- linux-next-20120523.orig/include/acpi/acpi_bus.h
>> +++ linux-next-20120523/include/acpi/acpi_bus.h
>> @@ -440,6 +440,8 @@ static inline int acpi_pm_device_sleep_w
>> =20
>>  #else	/* CONFIG_ACPI */
>> =20
>> +struct acpi_bus_type;
>> +
>>  static int register_acpi_bus_type(struct acpi_bus_type *bus) { retu=
rn 0; }
>>  static int unregister_acpi_bus_type(struct acpi_bus_type *bus) { re=
turn 0; }
>> =20
>=20
>=20
> Subject: [PATCH] ACPI: fix acpi_bus.h build warnings when ACPI is not=
 enabled
>=20
> introduced in Linux-3.5-rc1 by
> 66886d6f8c9bcdee3d7fce5796dcffd6b4bc0b48
> (ACPI: Add stubs for (un)register_acpi_bus_type)
>=20
> Fix header file warnings when CONFIG_ACPI is not enabled:
>=20
> include/acpi/acpi_bus.h:443:42: warning: 'struct acpi_bus_type' decla=
red inside parameter list
> include/acpi/acpi_bus.h:443:42: warning: its scope is only this defin=
ition or declaration, which is probably not
> include/acpi/acpi_bus.h:444:44: warning: 'struct acpi_bus_type' decla=
red inside parameter list
>=20
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  include/acpi/acpi_bus.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index b0d6282..9e6e1c6 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -440,8 +440,8 @@ static inline int acpi_pm_device_sleep_wake(struc=
t device *dev, bool enable)
> =20
>  #else	/* CONFIG_ACPI */
> =20
> -static int register_acpi_bus_type(struct acpi_bus_type *bus) { retur=
n 0; }
> -static int unregister_acpi_bus_type(struct acpi_bus_type *bus) { ret=
urn 0; }
> +static inline int register_acpi_bus_type(void *bus) { return 0; }
> +static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> =20
>  #endif				/* CONFIG_ACPI */
> =20



--=20
~Randy
