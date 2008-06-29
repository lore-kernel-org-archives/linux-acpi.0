From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Sun, 29 Jun 2008 20:23:53 +0100
Message-ID: <20080629192353.GA9132@srcf.ucam.org>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <200806262152.02099.rjw@sisk.pl> <Pine.LNX.4.55.0806270102051.31618@cliff.in.clinika.pl> <200806291600.29059.rjw@sisk.pl> <Pine.LNX.4.55.0806291952590.22548@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0806291952590.22548@cliff.in.clinika.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jun 29, 2008 at 08:05:42PM +0100, Maciej W. Rozycki wrote:

>  It is the reverse -- checking the DSDT ID is coarser, matching all the
> systems that use the broken firmware.  With DMI we may face both false
> positives and false negatives which imply further maintenance actions.  
> Please note as proved over the years understanding of these issues seems
> to be problematic for people, so the result may be another round of
> discussions reinventing the wheel in a couple of years' time or so.

The DSDT can't be updated without the BIOS being updated, and the DMI 
information gives us a BIOS version string that can be matched against 
if a fixed version is ever released. I'd be in favour of doing it with 
DMI on the grounds that it's how we already handle machine-specific 
quirks rather than adding new code to do it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
