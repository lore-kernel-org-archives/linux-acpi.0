From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/3] ACPI : introduce macros for using the ACPI
 specification version
Date: Tue, 30 Jun 2015 22:12:34 +0200
Message-ID: <CAJZ5v0hO_nmccyGR58CO3rEy55E3PNJXWSmGxtimVsZHfPzQnw@mail.gmail.com>
References: <1434666968-1543-1-git-send-email-al.stone@linaro.org>
	<1434666968-1543-2-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35503 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbbF3UMg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jun 2015 16:12:36 -0400
In-Reply-To: <1434666968-1543-2-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>

Hi Al,

On Fri, Jun 19, 2015 at 12:36 AM, Al Stone <al.stone@linaro.org> wrote:
> Add the ACPI_SPEC_VERSION() macro to build a proper version number from
> a major and minor revision number.  Add also the ACPI_FADT_SPEC_VERSION
> that constructs a proper version number from the entries in the current
> FADT.
>
> These macros are added in order to simplify retrieving and comparing ACPI
> specification version numbers, since this is becoming a more frequent need.
> In particular, there are some architectures that require at least a certain
> version of the spec, and there are differences in some structure sizes that
> have changed with recent versions but can only be tracked by spec version
> number.
>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  include/linux/acpi.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index a4acb55..33ed313 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -48,6 +48,11 @@
>  #include <acpi/acpi_io.h>
>  #include <asm/acpi.h>
>
> +#define ACPI_SPEC_VERSION(major, minor)        ((major<<8)|minor)

One nit here.

acpi_gbl_FADT.header.revision is of type u8 originally, so shifting it
by 8 bit positions only works due to some implicit type casting I
suppose.

Moreover, it is not entirely clear why the macro is specific to the
computation of the ACPI spec version.

So I'd drop ACPI_SPEC_VERSION and only define ACPI_FADT_SPEC_VERSION
as something like

#define ACPI_FADT_SPEC_VERSION (((unsigned
int)acpi_gbl_FADT.header.revision << 8) | (unsigned
int)acpi_gbl_FADT.minor_revision)

Thanks,
Rafael
