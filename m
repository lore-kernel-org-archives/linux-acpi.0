From: David Brownell <david-b@pacbell.net>
Subject: Re: Power Mangement Interfaces
Date: Mon, 2 Apr 2007 14:31:04 -0700
Message-ID: <200704021431.05096.david-b@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200704021124.21926.david-b@pacbell.net>
	<20070402194039.GA8044@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@laptop.org>
In-Reply-To: <20070402194039.GA8044@srcf.ucam.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=unsubscribe>
List-Archive: <http://mailman.laptop.org/pipermail/devel>
List-Post: <mailto:devel@laptop.org>
List-Help: <mailto:devel-request@laptop.org?subject=help>
List-Subscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=subscribe>
Sender: devel-bounces@laptop.org
Errors-To: devel-bounces@laptop.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@lists.linux-foundation.org, devel@laptop.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 02 April 2007 12:40 pm, Matthew Garrett wrote:
> On Mon, Apr 02, 2007 at 11:24:21AM -0700, David Brownell wrote:
> 
> > I don't follow this at all.  Most of the relevant devices have a PCI
> > device driver, not an ACPI device driver.  Surely you aren't proposing
> > that PCI drivers should incorporate lots of ACPI-specific code (which
> > won't be useful on non-ACPI platforms) before they start to work right?
> 
> PCI devices have a handle to their ACPI object in platform_data,

Good to know.  I was under the impression that was still in the
planning stage, not yet the working/reliable stage.  But I do see
some ACPI code doing that; maybe I'll take more of a look.


> so it's  
> easy enough to have generic code that interacts with both objects.

Well, not really "generic" if it knows about ACPI.
But at least not device-specific.


> > For a PCI device driver, pci_enable_wake() is all the hook that it should
> > ever need.  If ACPI magic is needed, it should be called from inside that
> > routine.
> 
> Yeah, I don't see that being a problem.

Except for not yet working that way! ;)

- Dave
