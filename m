From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: RE: preparing toshiba_acpi driver release
Date: Tue, 27 Jan 2004 11:21:31 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040127102131.GI25416@poupinou.org>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8A54@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8A54-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 26, 2004 at 02:29:02PM -0500, Brown, Len wrote:
> > Wait.  I take video, not hotkey :)
> 
> Yes, I just mentioned hotkeys because that is the other part of the
> platform dependent drivers which need a more generic solution.
> 
> > > I think video brightness control will be a very popular and visible
> > > feature -- no pun intended;-)
> > 
> > ATM I much prefer _CST though, even if there is no visible 
> > effect other
> > than people may notice that their laptop will run longer on battery,
> > and if they don't have some usb driver loaded.
> 
> I was thinking about ergonomics rather than power-savings -- though
> probably brightness control has some power savings benefits too -- maybe
> somebody on the list has numbers for screen power consumption?

backlights are power hungry monster.

> 
> > > In the back of my head I'm also wondering if we've got a 
> > missing piece
> > > of the suspend/resume puzzle here too -- and I'd hate for 
> > ACPI to be the
> > > "missing link" to get that key feature working.
> > 
> > IMHO, there is a need at first to glue devices in the ACPI 
> > namespace and the
> > devices enumerated by OS a la pnpbios...
> 
> For suspend/resume, or for something else?

For enumerating devices, should be usefull for suspend/resume.
The ACPI subsystem then may be able to call specific AML method
for this device, but at first, driver need to know that such
method exist.

> PNP is only for ISA devices, yes?  Is it really still used?

PNP was first designed for PCI device, IIRC.  Anyway, common isa devices
include serial ports, parallel ports, keyboard controller to name
a few.  Now, Linux do have some kind method to glue such devices
with real drivers.  It's more to point to look that kind of code
in order to see if ACPI can do the same, but with all the devices in mind.

> When we were working on interrupts somebody suggested that we ask the
> ISA bus driver about what ISA interrupts where taken rather than using a
> table inside the ACPI code containing "conventions".  The conventions
> are simple, and so far seem to be functional -- though one could argue
> such heuristics are sort of a hack.

ISA devices do have 'well known' interrupts, io ports.  Anyway, isa devices
are enumerated by ACPI and configuration may be retrived for them if
really needed (they are children of the isa bridge function of the
southbridge, in a hopefully well written AML).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
