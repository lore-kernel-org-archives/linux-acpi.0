From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 00/11] x86, memblock: Allocate memory near kernel image
 before SRAT parsed.
Date: Fri, 6 Sep 2013 11:15:26 -0400
Message-ID: <20130906151526.GA22423@mtj.dyndns.org>
References: <1377596268-31552-1-git-send-email-tangchen@cn.fujitsu.com>
 <20130904192215.GG26609@mtj.dyndns.org>
 <52299935.0302450a.26c9.ffffb240SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52299935.0302450a.26c9.ffffb240SMTPIN_ADDED_BROKEN@mx.google.com>
Sender: linux-doc-owner@vger.kernel.org
To: Wanpeng Li <liwanp@linux.vnet.ibm.com>
Cc: rjw@sisk.pl, lenb@kernel.org, tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hello, Wanpeng.

On Fri, Sep 06, 2013 at 04:58:11PM +0800, Wanpeng Li wrote:
> What's the root reason memblock alloc from high to low? To reduce 
> fragmentation or ...

Because low memory tends to be more precious, it's just easier to pack
everything towards the top so that we don't have to worry about which
zone to use for allocation and fallback logic.

Thanks.

-- 
tejun
