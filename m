From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/6] ACPI: D3cold state is always valid
Date: Wed, 18 Apr 2012 11:09:29 +0200
Message-ID: <201204181109.29355.rjw@sisk.pl>
References: <1334641676-14566-1-git-send-email-ming.m.lin@intel.com> <1334715327.11188.144.camel@minggr> <1334716348.11188.148.camel@minggr>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334716348.11188.148.camel@minggr>
Sender: linux-kernel-owner@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Huang Ying <huang.ying.caritas@gmail.com>, Aaron Lu <aaron.lu@amd.com>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, April 18, 2012, Lin Ming wrote:
> On Wed, 2012-04-18 at 10:15 +0800, Lin Ming wrote:
> > (fix Len's address)
> > 
> > On Tue, 2012-04-17 at 22:29 +0200, Rafael J. Wysocki wrote:
> > > On Tuesday, April 17, 2012, Lin Ming wrote:
> > > > ACPI_STATE_D3 actually means ACPI D3hot which is not always valid.
> > > > Instead, ACPI D3cold is always valid.
> > > > 
> > > > Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> > > 
> > > Can you just introduce ACPI_STATE_D3_HOT and redefine D3_COLD so that
> > > it's the same as D3, as I said?
> > 
> > Do you mean below?
> 
> Or you mean below?

This one, with a minor nit.

> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index eba6604..5852b8a 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -499,8 +499,9 @@ typedef u64 acpi_integer;
>  #define ACPI_STATE_D0                   (u8) 0
>  #define ACPI_STATE_D1                   (u8) 1
>  #define ACPI_STATE_D2                   (u8) 2
> -#define ACPI_STATE_D3                   (u8) 3
> -#define ACPI_STATE_D3_COLD              (u8) 4
> +#define ACPI_STATE_D3_HOT               (u8) 3
> +#define ACPI_STATE_D3                   (u8) 4
> +#define ACPI_STATE_D3_COLD              ACPI_STATE_D3
>  #define ACPI_D_STATES_MAX               ACPI_STATE_D3_COLD

I'd say

  #define ACPI_D_STATES_MAX               ACPI_STATE_D3

>  #define ACPI_D_STATE_COUNT              5

Thanks,
Rafael
