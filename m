From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: ACPI and the PNP Layer
Date: Sun, 1 Feb 2004 01:43:17 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040201014317.GN18725@parcelfarce.linux.theplanet.co.uk>
References: <Law11-F77kuQMAEZyO20001c9f5@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Law11-F77kuQMAEZyO20001c9f5-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dino Klein <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Feb 01, 2004 at 12:28:27AM +0000, Dino Klein wrote:
> I am curious to know whether there is supposed to be a relationship between 
> ACPI and the PNP layer in Linux, i.e. should the devices found through ACPI 
> be registered with the PNP layer, or will the PNP layer itself be 
> supplanted on ACPI based machines?

PNP is unnecessary on machines with ACPI.

> The reason I'm asking is because I'm toying with the idea of writing a 
> protocol driver that will "export" devices from ACPI to the PNP layer. 
> Would this be a more "proper" scheme of dealing with devices, instead of 
> having each driver modified to register with the ACPI bus (serial driver 
> style)? Wouldn't placing devices in the PNP layer make it more transparent 
> for drivers to bind to devices, whether the machine supports ACPI, or only 
> PNPBIOS?

I think there's a fundamental mistake here, which is that drivers need
to be modified to deal with ACPI.  The serial driver (I'm the original
author of the 8250_acpi code) needed to be modified to discover serial
devices in the ACPI namespace.  This is because HP's ia64 machines are
legacy-free, so do not have serial ports at 0x3f8 and 0x2f8 (or wherever
...) like PCs.  Some of HP's machines have PCI serial ports which need
no additional code, but others have what are called 'PDH UARTs' which
can only be discovered by looking in the ACPI namespace.

Obviously no ia64 machine will support ISAPNP or PNPBIOS, so your proposal
wouldn't work very well.  It's also not a lot of code -- 4934 bytes for
8250_acpi.c versus 12488 bytes for 8250_pnp.c.  I can't think of any other
"legacy devices in non-legacy positions" situations like this.  Can you?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
