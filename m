From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-rc8-mm1
Date: Thu, 17 Jan 2008 11:40:32 -0800
Message-ID: <20080117114032.1f9f1df5.akpm@linux-foundation.org>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<20080117124622.GA18450@balbir.in.ibm.com>
	<20080117104021.25a8e562.akpm@linux-foundation.org>
	<924EFEDD5F540B4284297C4DC59F3DEE5E909A@orsmsx423.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <e1000-devel-bounces@lists.sourceforge.net>
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEE5E909A@orsmsx423.amr.corp.intel.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/e1000-devel>,
	<mailto:e1000-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=e1000-devel>
List-Post: <mailto:e1000-devel@lists.sourceforge.net>
List-Help: <mailto:e1000-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/e1000-devel>,
	<mailto:e1000-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: e1000-devel-bounces@lists.sourceforge.net
Errors-To: e1000-devel-bounces@lists.sourceforge.net
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Intel E/100 mailing list <e1000-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org, Linux ACPI mailing list <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, balbir@linux.vnet.ibm.com
List-Id: linux-acpi@vger.kernel.org

On Thu, 17 Jan 2008 11:22:19 -0800 "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:

>  
> The problem is
> >> modprobe:2584 conflicting cache attribute 50000000-50001000
> >> uncached<->default
> 
> Some address range here is being mapped with conflicting types.
> Somewhere the range was mapped with default (write-back). Later
> pci_iomap() is mapping that region as uncacheable which is basically
> aliasing. PAT code detects the aliasing and fails the second uncacheable
> request which leads in the failure.

It sounds to me like you need considerably more runtime debugging and
reporting support in that code.  Ensure that it generates enough output
both during regular operation and during failures for you to be able to
diagnose things in a single iteration.

We can always take it out later.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
