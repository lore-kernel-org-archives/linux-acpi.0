From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI / PMIC: constify platform_device_id
Date: Sat, 16 Dec 2017 02:55:04 +0100
Message-ID: <2101025.DnMf5DsnqK@aspire.rjw.lan>
References: <317de9ac1d1ff31fd568ca7be10d2e4fd6be1f90.1511929854.git.arvind.yadav.cs@gmail.com> <20171129085132.GL22431@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42194 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755976AbdLPBzu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Dec 2017 20:55:50 -0500
In-Reply-To: <20171129085132.GL22431@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: lenb@kernel.org, andy@infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday, November 29, 2017 9:51:32 AM CET Mika Westerberg wrote:
> On Wed, Nov 29, 2017 at 10:05:02AM +0530, Arvind Yadav wrote:
> > platform_device_id are not supposed to change at runtime. All functions
> > working with platform_device_id provided by <linux/platform_device.h>
> > work with const platform_device_id. So mark the non-const structs as
> > const.
> > 
> > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Patch applied, thanks!

