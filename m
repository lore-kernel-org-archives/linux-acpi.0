From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] ACPI / PNP: Don't add "enumeration_by_parent"
 devices
Date: Fri, 20 Apr 2018 16:07:27 +0300
Message-ID: <20180420130727.GV2173@lahna.fi.intel.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
 <1524218846-169934-2-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524218846-169934-2-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: rjw@rjwysocki.net, andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org, lenb@kernel.org, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, arnd@arndb.de, graeme.gregory@linaro.org, helgaas@kernel.org, linuxarm@huawei.com, z.liuxinliang@hisilicon.com
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 20, 2018 at 06:07:25PM +0800, John Garry wrote:
> +	} else {
> +		device->driver_data = dev;

I think this deserves a comment explaining why we (ab)use driver_data
like this.
