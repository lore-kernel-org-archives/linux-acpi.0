From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Changing temperature trip points
Date: Sun, 3 Nov 2002 23:29:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021103222919.GM28704@atrey.karlin.mff.cuni.cz>
References: <20021102171756.GD1983@elf.ucw.cz> <1036288754.2971.1.camel@localhost.localdomain> <20021103195616.GB27271@elf.ucw.cz> <20021103211607.A1555@brodo.de> <20021103202130.GB22668@atrey.karlin.mff.cuni.cz> <20021103213010.A1665@brodo.de> <20021103203949.GE22668@atrey.karlin.mff.cuni.cz> <20021103230552.A20785@brodo.de> <20021103221532.GG28704@atrey.karlin.mff.cuni.cz> <20021103232621.E19750@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021103232621.E19750-JhLEnvuH02M@public.gmane.org>
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

> > goes P0:T3.
> > at t+7 msec machine reaches P0:T7.
> > at t+1000msec cpu cools down, and you reach P0:T0 in 7 msec.
> > 
> > Not good.
> 
> No, that's wrong: 
> 
> 1.) If passive cooling is active, _TSP is used _in all cases_
> as polling frequency (_TSP is an integer given in 1/10th seconds) - see
> acpi_thremal_check:

Okay, you were right and I was wrong.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
