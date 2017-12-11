From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [Xen-devel] [PATCH v3 4/4] x86/xen: supply rsdp address in boot
 params for pvh guests
Date: Mon, 11 Dec 2017 15:14:13 +0100
Message-ID: <20171211141413.73b5jxw43tivoy4b@gmail.com>
References: <20171208151139.30213-1-jgross@suse.com>
 <20171208151139.30213-5-jgross@suse.com>
 <5A2E674C0200007800196522@suse.com>
 <1a231a0d-b505-31c8-4723-52ef1dda634f@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1a231a0d-b505-31c8-4723-52ef1dda634f@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: Jan Beulich <JBeulich@suse.com>, lenb@kernel.org, x86@kernel.org, tglx@linutronix.de, xen-devel@lists.xenproject.org, corbet@lwn.net, boris.ostrovsky@oracle.com, mingo@redhat.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com
List-Id: linux-acpi@vger.kernel.org


* Juergen Gross <jgross@suse.com> wrote:

> On 11/12/17 11:09, Jan Beulich wrote:
> >>>> On 08.12.17 at 16:11, <jgross@suse.com> wrote:
> >> Set the boot loader version to 2.14 (0x020e) replacing the wrong 0x0212
> >> which should have been 0x020c.
> > 
> > This part of the description has become partly stale now with the
> > new patch 3.
> 
> Indeed. I'll wait for other comments before sending out a new version.

Looks good to me now, and I've applied the series to tip:x86/boot. I have removed 
this stale sentence from patch #4.

Thanks,

	Ingo
