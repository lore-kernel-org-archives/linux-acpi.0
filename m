From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/5] x86/smpboot: Add the missing description of
 possible_cpus
Date: Tue, 20 Mar 2018 13:37:12 +0100
Message-ID: <20180320123712.GR4043@hirez.programming.kicks-ass.net>
References: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
 <20180320110432.28127-2-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180320110432.28127-2-douly.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, hpa@zytor.com
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 20, 2018 at 07:04:28PM +0800, Dou Liyang wrote:

> +	possible_cpus=	[s390,x86_64] Use this to set hotpluggable cpus.
> +			This option sets possible_cpus bits in cpu_possible_map.
> +			Thus keeping the numbers of bits set constant even if
> +			the machine gets rebooted.

That description, esp. the last sentence, doesn't make any kind of sense
to me. What?
