From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: IBM R40 FFixedHW register?
Date: Thu, 23 Oct 2003 19:28:00 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031023172800.GQ13989@poupinou.org>
References: <20031021153556.B56816@root.org> <20031022095656.GN13989@poupinou.org> <20031022130030.C59735@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031022130030.C59735-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 22, 2003 at 01:02:41PM -0700, Nate Lawson wrote:
> On Wed, 22 Oct 2003, Ducrot Bruno wrote:
> > On Tue, Oct 21, 2003 at 03:39:55PM -0700, Nate Lawson wrote:
> > > I'm testing out my new cpu driver for FreeBSD and came across an
> > > interesting case in supporting Px states.  They work great on several
> > > laptops but the R40 can't set Px states.  I looked at the ASL and found
> > > that the control/status register pair is FFixedHW.
> > >
> > >             Return (Package (0x02)
> > >             {
> > >                 ResourceTemplate ()
> > >                 {
> > >                     Register (FFixedHW, 0x40, 0x00, 0x0000000000000199)
> > >                 },
> > >
> > >                 ResourceTemplate ()
> > >                 {
> > >                     Register (FFixedHW, 0x10, 0x00, 0x0000000000000198)
> > >                 }
> > >             }
> > >
> > > I guess I have to find the datasheet for that model to figure out how to
> > > access those registers.  Anyone come across this before?  What space are
> > > those actually in (IO, Memory, ??).  The register widths are also strange
> > > (64 and 16 bits).
> >
> > They are MSRs for Pentium-M found in Centrino platforms, but acpi spec would
> > only say you that you have to contact the CPU vendor.
> 
> Ah, thank you.  That makes sense.  How do you decide which platform you
> are on to determine how to interpret FFixedHW resources?  Check the vendor
> ID string for the ASL?  Check CPU or chipset type?  It could be that
> FFixedHW is MSR on x86 but some other thing (EFI) on ia64.

No.  A FFixedHW is more likely a way to tell ACPI that OS must provide a
specific driver for supporting that.  It is just that for this really specific
case, they are MSRs, but that is only an accident.

> 
> For this particular laptop, should I be looking in the chipset guide or
> the CPU guide?

CPU.  And anyway, you have to consider that actually this piece of asl is buggy,
in the sense that a FFixedHW should not be allowed to store informations, or
to be more precise, all fields should be 0.

Some (random) examples:

For a Pentium-M (banias):

Processor (CPU, 0x01, 0x00001010, 0x06) {
	/*
	 * 2.0 P-states
	 */
	Name(_PCT, Package() {
		ResourceTemplate() {Register (FFixedHW, 0, 0, 0)},	// perf_ctrl
		ResourceTemplate() {Register (FFixedHW, 0, 0, 0)}	// perf_status
	})
	Name(_PSS, Package() {
		Package() {
			1300,		// Frequency
			26000,		// power dissipation
			500,		// transition latency (always worst case)
			0,		// Bus latency
			0x0d2b,		// ctrl
			0x0d2b		// status
		},
		Package() {
			1200,
			22000,
			500,
			0,
			0x0c29,
			0x0c29
		},
		Package() {
			1000,
			20000,
			500,
			0,
			0x0a25,
			0x0a25
		},
		Package() {
			800,
			16000,
			500,
			0,
			0x0823,
			0x0823
		},
		Package() {
			600,
			12000,
			500,
			0,
			0x0610,
			0x0610
		}
	})
	Method(_PPC, 0, NotSerialized) {
		// Don't care.  This is for a badly designed OS anyway
	}
	/*
	 * 2.0 C-states
	 */
	Name(_CST) {
		4, 
		Package () {
			ResourceTemplate () { Register (FFixedHW, 0, 0, 0) },
			1,		// C state type, read 'like C1'
			1,		// Latency 
			933		// Power consumption
		}, 
		Package () {
			ResourceTemplate () { Register (SystemIO, 8, 0, 0x1014) }, 
			2, 
			1, 
			500
		}, 
		Package () {
			ResourceTemplate () { Register (SystemIO, 8, 0, 0x1015) }, 
			3,		// C state like C3, read need BM checks, etc.
			85, 
			250
		}, 
		Package () {
			ResourceTemplate () { Register (SystemIO, 8, 0, 0x1016) }, 
			3, 
			185, 
			100
		} 
	})
}

For P-states: if, and only if, you know you are on an Pentium-M (Banias), and
there is a driver for it, then:
	OSPM decide to go to P-state n: call specific driver.
		banias driver will:
			write _PSS for the field 'ctrl' to MSR 0x199
			read MSR 0x198 and return all OK if this equal _PSS[n].'status', else return KO.

For C-states: there is 4 states, and C1 is a FFixedHW.  Perform 'hlt' for that state.
That one is (again) not a MSR.

An other example.  ICH-2M, and PIII-M:
Processor (CPU, 0x01, 0x00001010, 0x06) {
	/*
	 * 2.0 P-states
	 */
	Name(_PCT, Package() {
		ResourceTemplate() {Register (FFixedHW, 0, 0, 0)},	// perf_ctrl
		ResourceTemplate () {Register (FFixedHW, 0, 0, 0)}	// perf_status
	})
	Name(_PSS, Package() {
		Package() {
			933,		// Frequency
			20000,		// power dissipation
			500,		// transition latency (always worst case)
			0,		// Bus latency
			0,		// ctrl
			0		// status
		},
		Package() {
			1200,
			22000,
			500,
			0,
			1,
			1
		}
	})
	..
}

To perform a transition, and there if there is a driver for it (read: CPU *and* chipset):
	from the 0x1010, calculate the IO register for speedstep (0x1010 + 0x40)
		or directly from the ich2-m (speedstep_register = pciconfig pm_base + 0x50).
	
	disable interrupts,
	Bus Mastring off
	outb _PSS.ctrl to speedstep_register
	Bus mastering on
	re-enable interrupts.
	success if _PSS.status == inb(speedstep_register).

As you can see, for this one, there is a need to disable both interrupts and
bus mastering, and therefore you can not just outb to the perf_ctrl.

I can provide more examples, I guess, but this mail is becoming long.


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
