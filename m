From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] ACPI / scan: Parse _CCA and setup device coherency
Date: Wed, 29 Apr 2015 16:03:19 +0200
Message-ID: <5542288.z0SSOZ4xV7@wuerfel>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com> <1430315049-4663-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430315049-4663-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, al.stone@linaro.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, leo.duran@amd.com, hanjun.guo@linaro.org, msalter@redhat.com, grant.likely@linaro.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 29 April 2015 08:44:09 Suravee Suthikulpanit wrote:
> +                       device->flags.cca_seen = 1;
> +               } else if (IS_ENABLED(CONFIG_ACPI_MUST_HAVE_CCA)) {
> +                       /*
> +                        * Architecture has specified that if the device
> +                        * can do DMA, it must have ACPI _CCA object.
> +                        * Here, there could be two cases:
> +                        *   1. Not DMA-able device.
> +                        *   2. DMA-able device, but missing _CCA object.
> +                        *
> +                        * In both cases, we will default to dma non-coherent.
> +                        */
> +                       cca = 0;
> +               } else {
> +                       /*
> +                        * If architecture does not specify that device must
> +                        * specify ACPI _CCA (e.g. x86), we default to use
> +                        * dma coherent.
> +                        */
> +                       cca = 1;
> +               }
> 

What does it mean here if a device does DMA but is not coherent? Do you
have an example of a server that needs this?

Can we please make the default for ARM64 cca=1 as well?

	Arnd
