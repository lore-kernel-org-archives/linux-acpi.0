From: Bin Gao <bin.gao@linux.intel.com>
Subject: Re: [PATCH 2/2] acpi/pmic: Add opregion driver for Intel BXT
 WhiskeyCove PMIC
Date: Mon, 13 Jun 2016 10:38:02 -0700
Message-ID: <20160613173801.GA202077@worksta>
References: <20160611072531.GB90940@worksta>
 <54020215-86ac-77be-ea4f-19941ed3a176@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54020215-86ac-77be-ea4f-19941ed3a176@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ysiyer <yegnesh.s.iyer@intel.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>, Bin Gao <bin.gao@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jun 12, 2016 at 10:13:33AM +0800, Aaron Lu wrote:
> Last time Paul suggests device_initcall instead of module_init here:
> 
> commit 75829dcf10862966f52716f2d67ac1c1b1eb486b
> Author: Paul Gortmaker <paul.gortmaker@windriver.com>
> Date:   Mon Feb 15 00:27:51 2016 -0500
> 
>     drivers/acpi: make pmic/intel_pmic_crc.c explicitly non-modular
> 
> Perhaps you should do the same.

Thanks Aaron's review.
I just sent out v2 of the patches which addressed your comments.
