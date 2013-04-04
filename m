From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 07/20] x86, ACPI: Make acpi_initrd_override_find work
 with 32bit flat mode
Date: Thu, 4 Apr 2013 11:35:55 -0700
Message-ID: <20130404183555.GW9425@htj.dyndns.org>
References: <1362897887-30808-1-git-send-email-yinghai@kernel.org>
 <1362897887-30808-8-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1362897887-30808-8-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Jacob Shin <jacob.shin@amd.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hello,

On Sat, Mar 09, 2013 at 10:44:34PM -0800, Yinghai Lu wrote:
> For finding with 32bit, it would be easy to access initrd in 32bit
> flat mode, as we don't need to set page table.
> 
> That is from head_32.S, and microcode updating already use this trick.
> 
> Need to change acpi_initrd_override_find to use phys to access global
> variables.
> 
> Pass is_phys in the function, as we can not use address to decide if it
> is phys or virtual address on 32 bit. Boot loader could load initrd above
> max_low_pfn.
> 
> Don't call printk as it uses global variables, so delay print later
> during copying.
> 
> Change table_sigs to use stack instead, otherwise it is too messy to change
> string array to phys and still keep offset calculating correct.
> That size is about 36x4 bytes, and it is small to settle in stack.
> 
> Also remove "continue" in MARCO to make code more readable.

It'd be nice if the error message can be stored somewhere and then
printed out after the system is in proper address mode if that isn't
too complex to achieve.  If it gets too messy, no need to bother.

Thanks.

-- 
tejun
