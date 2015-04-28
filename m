From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Tue, 28 Apr 2015 15:59:13 +0200
Message-ID: <20150428135913.GD19025@pd.tnic>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <1AE640813FDE7649BE1B193DEA596E880270F835@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880270F835@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 28, 2015 at 01:38:41PM +0000, Zheng, Lv wrote:
> > -	raw_spin_lock(&ghes_nmi_lock);
> > +	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
> > +		return ret;
> > +
> 
> if (atomic_cmpxchg(&ghes_in_nmi, 0, 1))
> 	return ret;

Ok, now I understand what you mean.

We absolutely want to use atomic_add_unless() because we get to save us
the expensive

	LOCK; CMPXCHG

if the value was already 1. Which is exactly what this patch is trying
to avoid - a thundering herd of cores CMPXCHGing a global variable.

I.e.,

	movl	ghes_in_nmi(%rip), %ecx	# MEM[(const int *)&ghes_in_nmi], c
	cmpl	$1, %ecx	#, c
	je	.L311	#,				<--- exit here if ghes_in_nmi == 1.
	leal	1(%rcx), %edx	#, D.37163
	movl	%ecx, %eax	# c, c
#APP
# 177 "./arch/x86/include/asm/atomic.h" 1
	.pushsection .smp_locks,"a"
.balign 4
.long 671f - .
.popsection
671:
	lock; cmpxchgl %edx,ghes_in_nmi(%rip)	# D.37163, MEM[(volatile u32 *)&ghes_in_nmi]
# 0 "" 2
#NO_APP

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
