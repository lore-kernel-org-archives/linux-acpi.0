From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC,5/7] NUMA hotplug emulator
Date: Thu, 13 May 2010 14:11:20 +0200
Message-ID: <20100513141120.10524f05@hyperion.delvare>
References: <20100513115625.GF2169@shaohui>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20100513115625.GF2169@shaohui>
Sender: owner-linux-mm@kvack.org
To: Shaohui Zheng <shaohui.zheng@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andi Kleen <ak@linux.intel.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>, Thomas Renninger <trenn@suse.de>, David Rientjes <rientjes@google.com>, Mel Gorman <mel@csn.ul.ie>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Alex Chiang <achiang@hp.com>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Shaohua Li <shaohua.li@intel.com>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, James Bottomley <James.Bottomley@HansenPartn>
List-Id: linux-acpi@vger.kernel.org

On Thu, 13 May 2010 19:56:25 +0800, Shaohui Zheng wrote:
> 
> hotplug emulator: Abstract cpu register functions
> 
> Abstract function arch_register_cpu and register_cpu, move the implementation
> details to a sub function with prefix "__". 
> 
> each of the sub function has an extra parameter nid, it can be used to register
> CPU under a fake NUMA node, it is a reserved interface for cpu hotplug emulation
> (CPU PROBE/RELEASE) in x86.
> 
> Signed-off-by: Shaohui Zheng <shaohui.zheng@intel.com>
> Signed-off-by: Haicheng Li <haicheng.li@intel.com>

I don't know anything about this, please don't Cc me on these patches.
Given the very long Cc list, I'm certain many other developers you have
included are not interested. Please focus on the relevant lists next
time!

-- 
Jean Delvare

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
