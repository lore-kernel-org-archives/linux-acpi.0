From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 3/6] acpi cleanup: Use pr_info() instead of printk() in
 arch/x86/mm/srat.c
Date: Mon, 19 Aug 2013 12:53:04 -0600
Message-ID: <1376938384.10300.458.camel@misato.fc.hp.com>
References: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>
	 <1376636809-10159-4-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376636809-10159-4-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, rjw@sisk.pl, liwanp@linux.vnet.ibm.com, tj@kernel.org, akpm@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2013-08-16 at 15:06 +0800, Tang Chen wrote:
> Use pr_info() instead of printk() in arch/x86/mm/srat.c.
> 
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>

Please fold patch 4/6 into this patch 3/6 since they both are printk()
cleanup on the same file.  I do not see why they need to be separated.
With that change,

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi
