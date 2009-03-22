From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Paravirtualizing bits of acpi access
Date: Sun, 22 Mar 2009 14:14:36 +0100
Message-ID: <20090322131436.GB22848@elte.hu>
References: <49C484B7.20100@goop.org> <200903211810.53990.rjw@sisk.pl>
	<49C5BDD8.1050605@goop.org> <200903221228.40181.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <200903221228.40181.rjw@sisk.pl>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Brown, Len" <len.brown@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Sunday 22 March 2009, Jeremy Fitzhardinge wrote:
> > Rafael J. Wysocki wrote:
> > > Well, why don't you implement the platform suspend operations for Xen?
> > > I guess you don't want ACPI _PTS to be executed during suspend as well.
> > >   
> > 
> > I don't know.  What's _PTS?
> 
> It's an ACPI method called to prepare the platform to enter the sleep state
> (the name stands for "prepare to sleep").  Executing it may affect the
> hardware.
> 
> > I think for the most part we want Linux to do most of the acpi 
> > work of bringing the machine into an idle state.  Its just that 
> > Xen is responsible for the very low level cpu context 
> > save/restore, because the Linux kernel is still running on vcpus 
> > rather than the physical cpus.
> 
> I think you really should not execute any global ACPI methods to 
> suspend a guest, because that may affect the host.  That's why I 
> think it's better to regard Xen as a platform and implement a 
> separate set of suspend operations for it.

I'd agree with that. That also allows the reuse of existing 
callbacks, right?

	Ingo
