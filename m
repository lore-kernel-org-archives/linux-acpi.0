From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 2/2][Patch-next -v2] ACPI, APEI, HEST Fix the
 unsuitable usage of platform_data.
Date: Thu, 02 Sep 2010 10:33:40 +0800
Message-ID: <1283394820.13175.48.camel@yhuang-dev>
References: <4C7F0C94.8090802@np.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C7F0C94.8090802@np.css.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Cc: APEI-lenb <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, ACPI <linux-acpi@vger.kernel.org>, LKLM <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Randy Dunlap <randy.dunlap@oracle.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2010-09-02 at 10:31 +0800, Jin Dongming wrote:
> platform_data in hest_parse_ghes() is used for saving the address of entry
> information of erst_tab. When the device is failed to be added, platform_data
> will be freed by platform_device_put(). But the value saved in platform_data
> should not be freed here. If it is done, it will make system panic.
> 
> So I think platform_data should save the address of allocated memory
> which saves entry information of erst_tab.
> 
> This patch fixed it and I confirmed it on x86_64 next-tree.
> 
> Signed-off-by: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Acked-by: Huang Ying <ying.huang@intel.com>

Best Regards,
Huang Ying
