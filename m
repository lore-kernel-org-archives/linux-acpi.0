From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [RFC PATCH 0/3] Add a new flag for ITS device to control indirect
 route
Date: Thu, 1 Dec 2016 09:07:14 +0000
Message-ID: <3ce161a7-ee63-a018-4a75-9e7520143d97@arm.com>
References: <1480578360-9268-1-git-send-email-majun258@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480578360-9268-1-git-send-email-majun258@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Majun <majun258@huawei.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, lenb@kernel.org, lv.zheng@intel.com, rafael.j.wysocki@intel.com, devel@acpica.org, mark.rutland@arm.com, robh+dt@kernel.org, jason@lakedaemon.net
Cc: dingtianhong@huawei.com, guohanjun@huawei.com
List-Id: linux-acpi@vger.kernel.org

On 01/12/16 07:45, Majun wrote:
> From: MaJun <majun258@huawei.com>
> 
> For current ITS driver, two level table (indirect route) is enabled when the memory used
> for LPI route table over the limit(64KB * 2) size. But this function impact the 
> performance of LPI interrupt actually because need more time to look up the table.

Are you implying that your ITS doesn't have a cache to lookup the most
active devices, hence performing a full lookup on each interrupt?

Anyway, doing this as a DT quirk doesn't feel right. Please use the ITS
quirk infrastructure.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
