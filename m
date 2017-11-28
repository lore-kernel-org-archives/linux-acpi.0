From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI / PMIC: Constify platform_device_id
Date: Tue, 28 Nov 2017 12:22:10 +0200
Message-ID: <20171128102210.GY22431@lahna.fi.intel.com>
References: <cover.1511863076.git.arvind.yadav.cs@gmail.com>
 <c75963e7a2e955795e18b15fe3f8ebfb2cf1cfef.1511863076.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c75963e7a2e955795e18b15fe3f8ebfb2cf1cfef.1511863076.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, andy@infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 28, 2017 at 03:31:51PM +0530, Arvind Yadav wrote:
> platform_device_id are not supposed to change at runtime. All functions
> working with platform_device_id provided by <linux/platform_device.h>
> work with const platform_device_id. So mark the non-const structs as
> const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

You may want to change the title to mention the PMIC driver in question
like: "ACPI / PMIC / bxtwc: ..." or so.

The patch itself is fine,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
