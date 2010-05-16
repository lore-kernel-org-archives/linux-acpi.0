From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC,5/7] NUMA hotplug emulator
Date: Sun, 16 May 2010 10:45:02 -0700
Message-ID: <20100516174502.GI2418@linux.vnet.ibm.com>
References: <20100513115625.GF2169@shaohui>
 <20100507141142.GA8696@ucw.cz>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20100507141142.GA8696@ucw.cz>
Sender: owner-linux-mm@kvack.org
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andi Kleen <ak@linux.intel.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>, Thomas Renninger <trenn@suse.de>, David Rientjes <rientjes@google.com>, Mel Gorman <mel@csn.ul.ie>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Alex Chiang <achiang@hp.com>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Shaohua Li <shaohua.li@intel.com>Jean Delvare <kh>
List-Id: linux-acpi@vger.kernel.org

On Fri, May 07, 2010 at 04:11:42PM +0200, Pavel Machek wrote:
> Hi!
> 
> > hotplug emulator: Abstract cpu register functions
> > 
> > Abstract function arch_register_cpu and register_cpu, move the implementation
> > details to a sub function with prefix "__". 
> > 
> > each of the sub function has an extra parameter nid, it can be used to register
> > CPU under a fake NUMA node, it is a reserved interface for cpu hotplug emulation
> > (CPU PROBE/RELEASE) in x86.
> 
> I don't get it. CPU hotplug can already be tested using echo 0/1 >
> online, and that works on 386. How is this different?
> 
> It seems to add some numa magic. Why is it important?

My guess is that he wants to test the software surrounding NUMA on a
non-NUMA (or different-NUMA) machine, perhaps in order to shake out bugs
before the corresponding hardware is available.

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
