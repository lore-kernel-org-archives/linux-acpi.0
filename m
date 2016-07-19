From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / PMIC: remove modular references from non-modular code
Date: Tue, 19 Jul 2016 22:09:30 +0200
Message-ID: <2014296.Y0F3yzq3m9@vostro.rjw.lan>
References: <20160711220516.3371-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160711220516.3371-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, July 11, 2016 06:05:16 PM Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of these files are:
> 
> drivers/acpi/Kconfig:menuconfig PMIC_OPREGION
> drivers/acpi/Kconfig:   bool "PMIC (Power Management Integrated Circuit) operation region support"
> 
> drivers/acpi/Kconfig:config BXT_WC_PMIC_OPREGION
> drivers/acpi/Kconfig:   bool "ACPI operation region support for BXT WhiskeyCove PMIC"
> 
> drivers/acpi/Kconfig:config XPOWER_PMIC_OPREGION
> drivers/acpi/Kconfig:   bool "ACPI operation region support for XPower AXP288 PMIC"
> 
> ...meaning they currently are not being built as a module by anyone.
> 
> Lets remove the couple traces of modular infrastructure use, so that
> when reading the code there is no doubt it is builtin-only.
> 
> We delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> One file was using module_init.  Since module_init translates to
> device_initcall in the non-modular case, the init ordering remains
> unchanged with this commit.
> 
> In one case we replace the module.h with export.h since that file
> is exporting some symbols, but does not use __init.  The other two
> are using __init and so module.h gets replaced with init.h there.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied, thanks!
