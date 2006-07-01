From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: SMBus access
Date: Sat, 1 Jul 2006 14:10:15 -0700
Message-ID: <20060701141015.a4922e86.rdunlap@xenotime.net>
References: <m2irmhjb5t.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:51908 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751924AbWGAVHi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Jul 2006 17:07:38 -0400
Received: from midway.site ([71.245.108.25]) by xenotime.net for <linux-acpi@vger.kernel.org>; Sat, 1 Jul 2006 14:07:28 -0700
In-Reply-To: <m2irmhjb5t.fsf@phoenix.squirrel.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johan Vromans <jvromans@squirrel.nl>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sat, 01 Jul 2006 22:57:34 +0200 Johan Vromans wrote:

> To get battery readings on some laptops it is necessary to interface
> with the SMBus that hangs of the EC. However, the current
> implementation of the EC driver does not permit other modules 
> read/write access. 
> 
> A trivial solution is to change acpi_ec_read/write from static to
> nonstatic, and export the symbols so other modules can use them.
> 
> Would there be any objections to apply this change?

a.  patch should also be sent to linux-acpi@vger.kernel.org (cc-ed)
b.  patch does not apply cleanly to latest kernel
c.  missing Signed-off-by: line (see Documentation/SubmittingPatches)
d.  incorrect patch filename directory level (see SubmittingPatches)



> -- Johan
> 
> --- drivers/acpi/ec.c~	2006-04-17 13:40:49.000000000 +0200
> +++ drivers/acpi/ec.c	2006-04-22 17:49:13.000000000 +0200
> @@ -305,20 +305,22 @@
>  }
>  #endif /* ACPI_FUTURE_USAGE */
>  
> -static int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
> +int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
>  {
>  	if (acpi_ec_poll_mode)
>  		return acpi_ec_poll_read(ec, address, data);
>  	else
>  		return acpi_ec_intr_read(ec, address, data);
>  }
> -static int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
> +EXPORT_SYMBOL(acpi_ec_read);
> +int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
>  {
>  	if (acpi_ec_poll_mode)
>  		return acpi_ec_poll_write(ec, address, data);
>  	else
>  		return acpi_ec_intr_write(ec, address, data);
>  }
> +EXPORT_SYMBOL(acpi_ec_write);
>  static int acpi_ec_poll_read(union acpi_ec *ec, u8 address, u32 * data)
>  {
>  	acpi_status status = AE_OK;
> -


---
~Randy
