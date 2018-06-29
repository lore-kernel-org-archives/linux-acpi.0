From: "Schmauss, Erik" <erik.schmauss@intel.com>
Subject: RE: small dmesg regression in kernel 4.17.3
Date: Fri, 29 Jun 2018 17:40:40 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53BB35FEC@ORSMSX110.amr.corp.intel.com>
References: <8837a9e2-e614-e2bf-ed32-6d49de4dd4ed@gmx.de>
 <CAHp75VcQbj7trhupZB7wUnt4QWbsqZZDa-1WvFnSD8ciMCYF6A@mail.gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53BB35DC6@ORSMSX110.amr.corp.intel.com>
 <3440214.eqW5gfvlOh@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3440214.eqW5gfvlOh@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, =?iso-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, "Moore, Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-acpi@vger.kernel.org


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> Sent: Friday, June 29, 2018 2:32 AM
> To: Schmauss, Erik <erik.schmauss@intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; Toralf Förster
> <toralf.foerster@gmx.de>; Moore, Robert <robert.moore@intel.com>; ACPI
> Devel Maling List <linux-acpi@vger.kernel.org>; Linux Kernel <linux-
> kernel@vger.kernel.org>; Guenter Roeck <linux@roeck-us.net>
> Subject: Re: small dmesg regression in kernel 4.17.3
> 
> On Friday, June 29, 2018 12:13:54 AM CEST Schmauss, Erik wrote:
> >
> > > -----Original Message-----
> > > From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> > > Sent: Wednesday, June 27, 2018 10:29 AM
> > > To: Toralf Förster <toralf.foerster@gmx.de>; Schmauss, Erik
> > > <erik.schmauss@intel.com>
> > > Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Linux
> > > Kernel <linux- kernel@vger.kernel.org>
> > > Subject: Re: small dmesg regression in kernel 4.17.3
> > >
> > > +Cc: Erik
> > >
> > > On Tue, Jun 26, 2018 at 8:57 PM, Toralf Förster
> > > <toralf.foerster@gmx.de>
> > > wrote:
> > > > The attached dmesg contains non printable chars 0x01 33 around
> > > > "ACPI BIOS Error (bug): Could not resolve" which is a new issue
> > > > compared to the dmesg of 4.17.2
> > > >
> > > > System is a stable hardened Gentoo Linux at a ThinkPad T440s.
> > >
> > > I bet the below commit makes this.
> > >
> > > commit 2e78935d1e27d31955ad2dad4abe6c453cf669fd
> > > Author: Erik Schmauss <erik.schmauss@intel.com>
> > > Date:   Fri Jun 1 12:06:43 2018 -0700
> > >
> > >    ACPICA: AML parser: attempt to continue loading table after error
> > >
> > >
> > Hi Andy,
> >
> > > So, it does add leading '\n' which flushes buffers followed by
> > > printing the message you see. But, I'm guessing now, kernel adds a
> > > default level since it's going to dmesg which you can see as unprintable
> symbols.
> >
> > What do you mean by a default level?
> >
> > > Personally I'm not a fan of leading '\n':s since it brings more pain
> > > than fixing something. It has special meaning (flushing buffers) and
> > > many developers forget this.
> >
> > This leading '\n' made it in Linux kernel unintentionally. It was originally
> intended as a change for acpiexec and it makes the dmesg look strange. I'll send
> out a fix.
> 
> Which would be something like the patch below I suppose?

Yes, this is what I was thinking of

Thanks,

Erik
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] ACPICA: Drop leading newlines from error messages
> 
> Commit 5088814a6e93 (ACPICA: AML parser: attempt to continue loading table
> after error) unintentionally added leading newlines to error messages emitted by
> ACPICA which caused unexpected things to be printed to the kernel log.  Drop
> these newlines (which effectively reverts the part of commit 5088814a6e93
> adding them).
> 
> Fixes: 5088814a6e93 (ACPICA: AML parser: attempt to continue loading table
> after error)
> Reported-by: Toralf Förster <toralf.foerster@gmx.de>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpica/uterror.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpica/uterror.c
> =================================================================
> ==
> --- linux-pm.orig/drivers/acpi/acpica/uterror.c
> +++ linux-pm/drivers/acpi/acpica/uterror.c
> @@ -182,19 +182,19 @@ acpi_ut_prefixed_namespace_error(const c
>  	switch (lookup_status) {
>  	case AE_ALREADY_EXISTS:
> 
> -		acpi_os_printf("\n" ACPI_MSG_BIOS_ERROR);
> +		acpi_os_printf(ACPI_MSG_BIOS_ERROR);
>  		message = "Failure creating";
>  		break;
> 
>  	case AE_NOT_FOUND:
> 
> -		acpi_os_printf("\n" ACPI_MSG_BIOS_ERROR);
> +		acpi_os_printf(ACPI_MSG_BIOS_ERROR);
>  		message = "Could not resolve";
>  		break;
> 
>  	default:
> 
> -		acpi_os_printf("\n" ACPI_MSG_ERROR);
> +		acpi_os_printf(ACPI_MSG_ERROR);
>  		message = "Failure resolving";
>  		break;
>  	}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in the body of
> a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
