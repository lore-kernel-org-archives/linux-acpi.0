From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] ACPI / PMIC: constify platform_device_id
Date: Wed, 29 Nov 2017 10:51:32 +0200
Message-ID: <20171129085132.GL22431@lahna.fi.intel.com>
References: <317de9ac1d1ff31fd568ca7be10d2e4fd6be1f90.1511929854.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60739 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751689AbdK2JA2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 Nov 2017 04:00:28 -0500
Content-Disposition: inline
In-Reply-To: <317de9ac1d1ff31fd568ca7be10d2e4fd6be1f90.1511929854.git.arvind.yadav.cs@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, andy@infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Nov 29, 2017 at 10:05:02AM +0530, Arvind Yadav wrote:
> platform_device_id are not supposed to change at runtime. All functions
> working with platform_device_id provided by <linux/platform_device.h>
> work with const platform_device_id. So mark the non-const structs as
> const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
