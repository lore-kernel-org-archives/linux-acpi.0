From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] drivers/acpi: make evged.c explicitly non-modular
Date: Mon, 9 May 2016 15:35:13 -0400
Message-ID: <5730E671.8070201@codeaurora.org>
References: <1462819227-28297-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462819227-28297-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

+Rafael,

On 5/9/2016 2:40 PM, Paul Gortmaker wrote:
> The Makefile/Kconfig currently controlling compilation of this code is:
> 
> Makefile:acpi-$(CONFIG_ACPI_REDUCED_HARDWARE_ONLY) += evged.o
> 
> -
> -module_platform_driver(ged_driver);
> -MODULE_LICENSE("GPL v2");
> +builtin_platform_driver(ged_driver);
> 

Thanks, it looks good to me. I realized Rafael was missing in your post.
I added him here.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
