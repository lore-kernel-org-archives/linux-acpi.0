From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] ibm-acpi-0.8 (was Re: 2.6.10-rc1-mm3)
Date: Mon, 8 Nov 2004 18:12:24 -0800
Message-ID: <20041108181224.F2357@build.pdx.osdl.net>
References: <200411081334.18751.annabellesgarden@yahoo.de> <200411082240.02787.annabellesgarden@yahoo.de> <20041108153022.N14339@build.pdx.osdl.net> <20041109013013.GA21832@aero.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261221AbUKICMd@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041109013013.GA21832@aero.ensim.com>; from borislav@users.sourceforge.net on Mon, Nov 08, 2004 at 05:30:13PM -0800
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Deianov <borislav@users.sourceforge.net>
Cc: len.brown@intel.com, Chris Wright <chrisw@osdl.org>, Karsten Wiese <annabellesgarden@yahoo.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

* Borislav Deianov (borislav@users.sourceforge.net) wrote:
> On Mon, Nov 08, 2004 at 03:30:22PM -0800, Chris Wright wrote:
> > 
> > The init error cleanup paths are broken in that driver.  It creates the
> > /proc/acpi/ibm dir and forgets to clean it up.  Partially that's due to
> > returning directly from the macro IBM_HANDLE_INIT_REQ.  This should help.
> 
> Yikes. Guilty as charged.
> 
> I reworked Chris's patch a bit and tried both the error and non-error
> case here. Len, if it looks good, please apply.

Ah, even better.  Thanks Boris.  BTW, you could probably mark ibm_init()
and ibm_handle_init() as __init.

-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
