From: "malattia@linux.it" <malattia@linux.it>
Subject: Re: [patch 0/5] iASL patches in Debian
Date: Thu, 8 Jul 2010 23:40:26 +0900
Message-ID: <20100708144026.GE1909@kamineko.org>
References: <20100704044332.573836359@linux.it>
 <4911F71203A09E4D9981D27F9D830858A10EFE10@orsmsx503.amr.corp.intel.com>
 <20100707220736.GD5635@kamineko.org>
 <1278550164.3638.12.camel@minggr.sh.intel.com>
 <20100708134928.GD1909@kamineko.org>
 <1278626807.2164.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:59149
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118Ab0GHOk1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jul 2010 10:40:27 -0400
Content-Disposition: inline
In-Reply-To: <1278626807.2164.17.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Jul 08, 2010 at 10:06:47PM +0000, Lin Ming wrote:
> On Thu, 2010-07-08 at 21:49 +0800, malattia@linux.it wrote:
> > On Thu, Jul 08, 2010 at 08:49:24AM +0800, Lin Ming wrote:
> > > On Thu, 2010-07-08 at 06:07 +0800, malattia@linux.it wrote:
> > > > On Wed, Jul 07, 2010 at 12:27:20PM -0700, Moore, Robert wrote:
> > > > > If you'd like to get ambitious, run the ASLTS suite on the big-endian machines.
> > > > 
> > > > I'll give it a go :)
> > > > Is the one found in the meego git repository what I should try?
> > > 
> > > Or acpica git repository (git://git.moblin.org/acpica)
> > > 
> > > acpica/tests/aslts
> > 
> > For now I only ran "Do 0 aslts" and the results are not too bad. I cleaned
> > up the build logs a bit and here's the diff between sparc64 and x86_64:
> 
> Good. Thanks!
> 
> > 
> > --- /proc/self/fd/11	2010-07-08 22:33:25.614802828 +0900
> > +++ /proc/self/fd/13	2010-07-08 22:33:25.614802828 +0900
> > @@ -1,6 +1,10 @@
> > -Linux smetana 2.6.26-2-sparc64-smp #1 SMP Mon Jun 21 16:31:11 UTC 2010 sparc64 GNU/Linux
> > +Linux caligola 2.6.34 #37 SMP PREEMPT Sat May 29 11:36:03 JST 2010 x86_64 GNU/Linux
> >  
> >  Make-install all the provided test cases
> > +install -d -m 775 ../../../../../../tmp/aml/20100528/nopt/32
> > +install -d -m 775 ../../../../../../tmp/aml/20100528/nopt/64
> > +install -d -m 775 ../../../../../../tmp/aml/20100528/opt/32
> > +install -d -m 775 ../../../../../../tmp/aml/20100528/opt/64
> >  ASL Input:  MAIN.asl - 78 lines, 1734433 bytes, 21705 keywords
> >  AML Output: bdemo.aml - 282587 bytes, 4188 named objects, 17517 executable opcodes
> >  
> > @@ -90,11 +94,11 @@
> >  
> >  Compilation complete. 0 Errors, 83 Warnings, 18 Remarks, 0 Optimizations
> >  ASL Input:  MAIN.asl - 62 lines, 962044 bytes, 20265 keywords
> > -AML Output: oconst.aml - 255557 bytes, 862 named objects, 19403 executable opcodes
> > +AML Output: oconst.aml - 255575 bytes, 862 named objects, 19403 executable opcodes
> 
> Why do the aml files have different size?
> Is it caused by big/small endian?

They should be identical, possibly my patch is incomplete or not
correct. Out of the ~180 tests only the ones in the diff show
differences.
I'll have to check what is wrong on sparc64 for them.

...
> > +AML Output: oconst.aml - 261272 bytes, 862 named objects, 19403 executable opcodes
> > +AML Output: dynobj.aml - 57916 bytes, 599 named objects, 4286 executable opcodes
> > +AML Output: dynobj.aml - 57920 bytes, 599 named objects, 4286 executable opcodes
-- 
mattia
:wq!
