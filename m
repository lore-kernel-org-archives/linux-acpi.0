From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 4/6] power: reset: removed use of the dts mask and use fixed value for reset.
Date: Wed, 8 Jan 2014 22:45:20 +0100
Message-ID: <201401082245.20863.arnd@arndb.de>
References: <1389135041-16062-1-git-send-email-fkan@apm.com> <1389135041-16062-5-git-send-email-fkan@apm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389135041-16062-5-git-send-email-fkan@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Feng Kan <fkan@apm.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 07 January 2014, Feng Kan wrote:
> @@ -73,8 +73,7 @@ static int xgene_reboot_probe(struct platform_device *pdev)
>                 return -ENODEV;
>         }
>  
> -       if (of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask))
> -               ctx->mask = 0xFFFFFFFF;
> +       ctx->mask = 0x1;

Is the "mask" property now deprecated? Please update the binding document
accordingly if it's no longer needed.

	Arnd
