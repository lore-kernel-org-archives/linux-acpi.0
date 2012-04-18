From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH 1/6] ACPI: D3cold state is always valid
Date: Wed, 18 Apr 2012 10:32:28 +0800
Message-ID: <1334716348.11188.148.camel@minggr>
References: <1334641676-14566-1-git-send-email-ming.m.lin@intel.com>
	 <1334641676-14566-2-git-send-email-ming.m.lin@intel.com>
	 <201204172229.18203.rjw@sisk.pl>  <1334715327.11188.144.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:11569 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430Ab2DRCca (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Apr 2012 22:32:30 -0400
In-Reply-To: <1334715327.11188.144.camel@minggr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Huang Ying <huang.ying.caritas@gmail.com>, Aaron Lu <aaron.lu@amd.com>

On Wed, 2012-04-18 at 10:15 +0800, Lin Ming wrote:
> (fix Len's address)
> 
> On Tue, 2012-04-17 at 22:29 +0200, Rafael J. Wysocki wrote:
> > On Tuesday, April 17, 2012, Lin Ming wrote:
> > > ACPI_STATE_D3 actually means ACPI D3hot which is not always valid.
> > > Instead, ACPI D3cold is always valid.
> > > 
> > > Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> > 
> > Can you just introduce ACPI_STATE_D3_HOT and redefine D3_COLD so that
> > it's the same as D3, as I said?
> 
> Do you mean below?

Or you mean below?

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index eba6604..5852b8a 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -499,8 +499,9 @@ typedef u64 acpi_integer;
 #define ACPI_STATE_D0                   (u8) 0
 #define ACPI_STATE_D1                   (u8) 1
 #define ACPI_STATE_D2                   (u8) 2
-#define ACPI_STATE_D3                   (u8) 3
-#define ACPI_STATE_D3_COLD              (u8) 4
+#define ACPI_STATE_D3_HOT               (u8) 3
+#define ACPI_STATE_D3                   (u8) 4
+#define ACPI_STATE_D3_COLD              ACPI_STATE_D3
 #define ACPI_D_STATES_MAX               ACPI_STATE_D3_COLD
 #define ACPI_D_STATE_COUNT              5
 


> 
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index eba6604..f0b25c8 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -499,9 +499,9 @@ typedef u64 acpi_integer;
>  #define ACPI_STATE_D0                   (u8) 0
>  #define ACPI_STATE_D1                   (u8) 1
>  #define ACPI_STATE_D2                   (u8) 2
> -#define ACPI_STATE_D3                   (u8) 3
> -#define ACPI_STATE_D3_COLD              (u8) 4
> -#define ACPI_D_STATES_MAX               ACPI_STATE_D3_COLD
> +#define ACPI_STATE_D3_HOT               (u8) 3
> +#define ACPI_STATE_D3                   (u8) 4
> +#define ACPI_D_STATES_MAX               ACPI_STATE_D3
>  #define ACPI_D_STATE_COUNT              5
>  
>  #define ACPI_STATE_C0                   (u8) 0
> 


