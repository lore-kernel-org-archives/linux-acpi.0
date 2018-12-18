From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v10 6/6] ACPI/IORT: Stub out ACS functions when CONFIG_PCI
 is not set
Date: Tue, 18 Dec 2018 03:46:17 +0100
Message-ID: <80c186fe-e5ff-1d13-fad5-6386b21b45c4@kernel.org>
References: <20181215010247.26101-1-okaya@kernel.org>
 <20181215010247.26101-7-okaya@kernel.org>
 <40e31e86-a4ac-d9a6-d752-b04203d5ced7@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <40e31e86-a4ac-d9a6-d752-b04203d5ced7@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/18/2018 3:14 AM, Hanjun Guo wrote:
> I prefer stub function for iort_enable_acs(), not adding #ifdef/#endif pair inside
> this function.

Yes, I'm reworking this per input from Lorenzo.

> 
> By the way, there are other pci function called in iort.c, could you explain a
> little bit why no need to update other function calls in commit message?

I added few words about why other code was not stubbed out.
