From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Dell D600: teaching radeonfb how to wake up...
Date: Thu, 27 Nov 2003 10:27:48 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1069889267.19543.172.camel@gaston>
References: <20031119180119.GB22307@tate.loria.fr>
	 <20031120111315.GB432@openzaurus.ucw.cz> <1069370504.705.32.camel@gaston>
	 <20031120234708.GA431@elf.ucw.cz> <20031121155010.C19564@loria2.loria.fr>
	 <1069637387.723.112.camel@gaston> <20031124173603.GA298@elf.ucw.cz>
	 <1069725771.876.296.camel@gaston> <20031125120443.GA297@elf.ucw.cz>
	 <20031126132419.GL7374@poupinou.org>  <20031126223436.GD207@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031126223436.GD207-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Emmanuel Thome <Emmanuel.Thome+acpi-/zGXu1G9BXs@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> That's what I'm doing, but it crashes machine on most
> machines. Perhaps PCI needs to be already initialized at this point or
> something like that?

Yes, what I've been told is that you need to have re-initialized the AGP
slot first, which may need yet another BIOS driver to POST, or some ACPI
wakeup thingy (re-initializing the AGP bridge means in some case filling
some non-documented registers with proper timing & clock skew values
etc...)

Ben.





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
