From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/4] ACPI / battery: use specialized print macros
Date: Fri, 12 Jan 2018 20:52:24 +0200
Message-ID: <1515783144.7000.974.camel@linux.intel.com>
References: <20180112135847.14989-1-dmitry.rozhkov@linux.intel.com>
         <20180112135847.14989-4-dmitry.rozhkov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:5534 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965128AbeALSz1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Jan 2018 13:55:27 -0500
In-Reply-To: <20180112135847.14989-4-dmitry.rozhkov@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org

On Fri, 2018-01-12 at 15:58 +0200, Dmitry Rozhkov wrote:

> +	pr_warning(PREFIX "Deprecated procfs I/F for battery is
> loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");

A nit: it can be pr_warn().

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
