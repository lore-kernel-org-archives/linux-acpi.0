From: Dominik Brodowski <devel-JhLEnvuH02M@public.gmane.org>
Subject: Re: not all irqs detected
Date: Sat, 24 Aug 2002 21:00:58 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020824210055.A1252@brodo.de>
References: <200208241717.g7OHH1X19234@mailgate5.cinetic.de> <20020824200511.G587@brodo.de> <20020824.121703.52419660.imp@bsdimp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020824.121703.52419660.imp-uzTCJ5RojNnQT0dZR+AlfA@public.gmane.org>; from imp-uzTCJ5RojNnQT0dZR+AlfA@public.gmane.org on Sat, Aug 24, 2002 at 12:17:03PM -0600
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "M. Warner Losh" <imp-uzTCJ5RojNnQT0dZR+AlfA@public.gmane.org>
Cc: joerg.beyer-htSm2yLGOjU@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> : > I tried to read & understand the driver/acpi/pci_*.c code, but I need
> : > some help to get started: how are the free/usable IRQs found
> : > and mapped?
> 
> Actually, that's not the case ('all shoule be free'). 
Thanks for clearing that up, I actually meant that all _usable_ IRQs (i.e.
those in the ACPI PRT tables) should be _available_ == free... So it should
be:
| The usable IRQs are set down in the DSDT table, the Detailed System
| Description Table (which is more or less fixed in the BIOS). And as all PCI
| IRQs are expected to be non-exclusive, all of those usable IRQs should be 
| available / "free for use". However, the ACPI code tries to use the 
| available IRQs most effectively, i.e. no sharing of IRQs if possible.

Dominik


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
