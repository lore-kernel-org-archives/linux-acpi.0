From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH][RFC] Clean up Kconfig logic for IA64 ACPI
Date: Sun, 2 Nov 2003 04:34:02 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031102043402.GF3824@parcelfarce.linux.theplanet.co.uk>
References: <Pine.GSO.4.58.0310251706470.15711@inky> <20031102031644.GB3824@parcelfarce.linux.theplanet.co.uk> <Pine.GSO.4.58.0311011945190.18996@sue>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0311011945190.18996-rWrNtCO5SiE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Noah J. Misch" <noah-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, linux-ia64-WygotPe7DYIabbyE177sbg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 01, 2003 at 08:05:44PM -0800, Noah J. Misch wrote:
> I do not read linux-ia64 regularly, so I did not notice your work.  I
> apologize for not acknowledging it.

No problem ;-)

> Why not include drivers/Kconfig and scrap the individual subdirectory
> includes, as i386 does?

At that time, I hadn't done the work to create drivers/Kconfig ;-)
The main problem for ia64 is the simulator stuff.  Maybe something like:

if !IA64_HP_SIM
source "drivers/Kconfig"
endif

if IA64_HP_SIM
source "drivers/base/Kconfig"
source "drivers/scsi/Kconfig"
source "net/Kconfig"
source "drivers/block/Kconfig"
source "arch/ia64/hp/sim/Kconfig"
endif

(I guess Kconfig needs an "else" keyword).

(Also the duplication of drivers/block/Kconfig is no longer necessary).

> Also, it looks like your patch makes ACPI non-mandatory.  Is that intentional?

Hmmm... no ;-)  I agree the "select" should probably go in -- we seem
to be infected with ACPI for the foreseeable future ;-(

I imagine these kinds of patches can go into 2.6.1 -- the freeze should
let up a bit by then.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
