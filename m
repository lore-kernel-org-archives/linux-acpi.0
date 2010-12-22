From: Tejun Heo <tj@kernel.org>
Subject: Re: Early kernel messages are overflowing the static log buffer
Date: Wed, 22 Dec 2010 14:17:19 +0100
Message-ID: <20101222131719.GA8061@htj.dyndns.org>
References: <4D06B317.2090608@sgi.com>
 <20101222130946.GC13412@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101222130946.GC13412@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Mike Travis <travis@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, Len Brown <lenb@kernel.org>, Jack Steiner <steiner@sgi.com>, Lori Gilbertson <loriann@sgi.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hello,

On Wed, Dec 22, 2010 at 02:09:46PM +0100, Ingo Molnar wrote:
> > [    0.000000] pcpu-alloc: [000] 0000 0001 0002 0003 0004 0005 0006 0007 1024 1025 1026 1027 1028 1029 1030 1031
> > 
> > What I'm asking is which of these would be most acceptable to
> > either remove or replace with some sort of message reduction?
> 
> The pcpu alloc messages look entirely superfluous and zappable - make them 
> KERN_DEBUG perhaps (and Cc: Tejun)?

Yeap, with percpu allocator now mostly stable, I don't think the
message needs to be KERN_INFO anymore.  I'll change it to KERN_DEBUG.

Thanks.

-- 
tejun
