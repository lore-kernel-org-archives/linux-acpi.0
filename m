From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Overheating is *not* dangerous Re: Changing temperature trip points
Date: Sun, 3 Nov 2002 23:46:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021103224633.GO28704@atrey.karlin.mff.cuni.cz>
References: <20021103195616.GB27271@elf.ucw.cz> <20021103211607.A1555@brodo.de> <20021103202130.GB22668@atrey.karlin.mff.cuni.cz> <20021103213010.A1665@brodo.de> <20021103203949.GE22668@atrey.karlin.mff.cuni.cz> <20021103220843.B1665@brodo.de> <20021103220017.GB28704@atrey.karlin.mff.cuni.cz> <20021103231318.B19750@brodo.de> <20021103221945.GH28704@atrey.karlin.mff.cuni.cz> <20021103233054.G19750@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021103233054.G19750-JhLEnvuH02M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Cc: Edmund Rhudy <nrhudy-plZrL8KR64B+CIkdHa1UOg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!
> > > > Actually, Documentation/acpi/processor.txt seems like right
> > > > place. "Polling" warning should be in Documentation/, really.
> > > 
> > > Which does not exist ==> extremely dangerous situation. Even though you
> > > should know what you're doing when you meddle with the affairs of kernels,
> > > kernels should try at least to some extent to be safe to use. 
> > 
> > So perhaps its good time to create Documentation/acpi? ;-).
> > 
> > Anyway it is not *dangerous* situation. ACPI machines power down on
> > overtemp.
> ACPI machines power down on overtemp. What is overtemp? The temperature
> specified in CRITICAL in the DSDT. And if this value is wrong, then you need
> to rely on the sanity of BIOS programmers. And a log of good luck.

Actually, I believe its sanity of HW designers. I'd not trust BIOS
programmers to get it right.

There's one more point above _CRT, that's what I call overtemp:

[from specs:]

This says that if you can cook your machine, it was not acpi
compliant.
							Pavel

When the heat reaches the temperature indicated by _CRT, the OS must
immediately shutdown the system.
The system must disable the power either after the temperature reaches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
some hardware-determined level above
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
_CRT or after a predetermined time has passed. Before disabling power,
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
platform designers should incorporate
some time that allows the OS to run its critical shutdown
operation. There is no requirement for a minimum
shutdown operation window that commences immediately after the
temperature reaches _CRT.  This is
because
*  Heat might rise rapidly in some systems and slower on others,
depending on casing design and
    environmental factors.
*  Shutdown can take several minutes on a server and only a few short
seconds on a hand-held device.
Because of this indistinct discrepancy and the fact that a critical
heat situation is a remarkably rare occurrence,
ACPI does not specify a target window for a safe shutdown. It is
entirely up to the OEM to build in a safe
buffer that it sees fit for the target platform.


-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
