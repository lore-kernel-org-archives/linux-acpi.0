From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 01/15] ACPI: create kernel/acpi/
Date: Wed, 31 Dec 2008 14:39:01 +0100
Message-ID: <20081231133901.GB2388@uranus.ravnborg.org>
References: <1230720725-9376-1-git-send-email-lenb@kernel.org> <526647e1bb69fd3248558fce365bb1fbfb226ccd.1230719795.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756111AbYLaNhd@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <526647e1bb69fd3248558fce365bb1fbfb226ccd.1230719795.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

> diff --git a/kernel/acpi/Makefile b/kernel/acpi/Makefile
> new file mode 100644
> index 0000000..92a1f94
> --- /dev/null
> +++ b/kernel/acpi/Makefile
> @@ -0,0 +1,26 @@
> +#
> +# Makefile for the Linux/ACPI
> +#
> +
> +export ACPI_CFLAGS
> +

Why is ACPI_CFLAGS exported?
> +ACPI_CFLAGS	:= -Os
> +
> +ifdef CONFIG_ACPI_DEBUG
> +  ACPI_CFLAGS	+= -DACPI_DEBUG_OUTPUT
> +endif
> +
> +EXTRA_CFLAGS	+= $(ACPI_CFLAGS)
A better way:

ccflags-$(CONFIG_ACPI_DEBUG) := -DACPI_DEBUG_OUTPUT

Note: EXTRA_CFLAGS is deprecated in favour of ccflags-y.

> +export ACPI_CFLAGS
> +
> +ACPI_CFLAGS	:= -Os
> +
> +ifdef CONFIG_ACPI_DEBUG
> +  ACPI_CFLAGS	+= -DACPI_DEBUG_OUTPUT
> +endif
> +
> +EXTRA_CFLAGS	+= $(ACPI_CFLAGS)

Same construct - see above.

	Sam
