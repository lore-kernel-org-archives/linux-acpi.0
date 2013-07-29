From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] APEI/ERST: Fix error message formatting
Date: Mon, 29 Jul 2013 08:32:33 -0700
Message-ID: <1375111953.2075.42.camel@joe-AO722>
References: <1374526866-6813-1-git-send-email-bp@alien8.de>
	 <20130724171347.GB29756@naverao1-tp.watson.ibm.com>
	 <1374686598.18818.18.camel@joe-AO722> <51F10AA8.2050901@linux.vnet.ibm.com>
	 <CAErSpo5vLbsM5BXjrCVy1AKBxRRSH33TthyyK3O35Mghqw81nQ@mail.gmail.com>
	 <20130729135812.GD6634@pd.tnic>
	 <CAErSpo6fbMmicX95j_wYkJRnQeJEZ_jQSm76j9ZN4sHP0C2Yhg@mail.gmail.com>
	 <20130729144046.GE6634@pd.tnic>
	 <CAErSpo69wNc1h6PyJhFfhdFzz0GOiM=SCCfrm-WO5XDFTFzcHw@mail.gmail.com>
	 <20130729152230.GG6634@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:51327 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751155Ab3G2Pce (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Jul 2013 11:32:34 -0400
In-Reply-To: <20130729152230.GG6634@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>

On Mon, 2013-07-29 at 17:22 +0200, Borislav Petkov wrote:
[]
> Right, I'll make it be a hex "0x" in both stall-functions and leave it
> to someone more ACPI-knowledgeable to decide what goes in there - my
> patch is a simple cleanup anyway.
[]
> From: Borislav Petkov <bp@suse.de>
[]
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
[]
> @@ -39,7 +39,8 @@
>  
>  #include "apei-internal.h"
>  
> -#define ERST_PFX "ERST: "
> +#undef pr_fmt
> +#define pr_fmt(fmt) "ERST: " fmt

This reverses the order of some ERST/FW_WARN messages.
I don't know if that matters to any log scrapers.


> @@ -109,8 +110,7 @@ static inline int erst_errno(int command_status)
>  static int erst_timedout(u64 *t, u64 spin_unit)
>  {
>  	if ((s64)*t < spin_unit) {
> -		pr_warning(FW_WARN ERST_PFX
> -			   "Firmware does not respond in time\n");
> +		pr_warn(FW_WARN "Firmware does not respond in time\n");

etc...

> @@ -271,8 +271,7 @@ static int erst_exec_move_data(struct apei_exec_context *ctx,
>  
>  	/* ioremap does not work in interrupt context */
>  	if (in_interrupt()) {
> -		pr_warning(ERST_PFX
> -			   "MOVE_DATA can not be used in interrupt context");
> +		pr_warn("MOVE_DATA can not be used in interrupt context");

missing newline



