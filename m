From: Christoph Lameter <cl@linux.com>
Subject: Re: acpi throttling: Use this_cpu_has and simplify code
Date: Tue, 21 Dec 2010 16:43:24 -0600 (CST)
Message-ID: <alpine.DEB.2.00.1012211638470.3769@router.home>
References: <20101214162842.542421046@linux.com>  <20101214162855.392020353@linux.com> <1292345072.5934.32.camel@edumazet-laptop> <alpine.DEB.2.00.1012141055220.17229@router.home> <4D07A2B7.8080405@zytor.com> <alpine.DEB.2.00.1012141109470.17229@router.home>
 <4D07A7CB.7010205@zytor.com> <4D07A95C.7030703@kernel.org> <4D0814AF.7080209@zytor.com> <4D08ECEF.3040909@kernel.org> <4D08EE57.8010602@zytor.com> <4D08EF4E.8070403@kernel.org> <4D0A3AF2.50508@gmail.com> <alpine.DEB.2.00.1012161215200.21588@router.home>
 <4D0CD840.2050100@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D0CD840.2050100@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Eric Dumazet <eric.dumazet@gmail.com>, akpm@linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, rui.zhang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 18 Dec 2010, Tejun Heo wrote:

> It's bothersome that these methods don't have any indication that
> they're bound to local CPU when they can't be called with @pr for
> another CPU as MSRs can only be accessed from local CPU.

Right.

> In the longer run, it would be nice if there's an indication that this
> is only for the local CPU and maybe a WARN_ON_ONCE().  Maybe dropping
> @pr and using this_cpu_*() is better for performance too?

That is precisely the difficulty with many other functions that take
pointers to cpu_info. If we can establish that they are called *only* with
pointers to the current cpu then we can improve the function by dropping
the parameter and using this_cpu ops to access the cpu_info fields.

Using this_cpu ops instead of access to a field of a struct pointed to by
an array avoids an addition of pointers and replacest with a operation
that essentially takes a global address with a segment prefix. It reduces
register pressure and avoids the additions of pointers but it will encode
the address in the instruction.
