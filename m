From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: ACPI and the PNP Layer
Date: Sun, 1 Feb 2004 17:24:47 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040201172447.GV18725@parcelfarce.linux.theplanet.co.uk>
References: <Law11-F969ScIXWOReP0000022f@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Law11-F969ScIXWOReP0000022f-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dino Klein <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Feb 01, 2004 at 02:41:02AM +0000, Dino Klein wrote:
> >PNP is unnecessary on machines with ACPI.
> 
> When you say PNP, are you refering to PNPBIOS/ISAPNP, or the Linux PNP 
> Layer iself, which uses the previous two as PNP protocols?

The former.

> >I think there's a fundamental mistake here, which is that drivers need
> >to be modified to deal with ACPI.  The serial driver (I'm the original
> >author of the 8250_acpi code) needed to be modified to discover serial
> >devices in the ACPI namespace.  This is because HP's ia64 machines are
> >legacy-free, so do not have serial ports at 0x3f8 and 0x2f8 (or wherever
> >...) like PCs.  Some of HP's machines have PCI serial ports which need
> >no additional code, but others have what are called 'PDH UARTs' which
> >can only be discovered by looking in the ACPI namespace.
> 
> You're saying this under the assumption that everything will go USB/PCI/etc 
> in the future, right?

Correct.  They're cheaper and simpler than the alternatives, so once
support is sufficiently widespread, I would indeed expect the legacy
support to go away.

> >Obviously no ia64 machine will support ISAPNP or PNPBIOS, so your proposal
> >wouldn't work very well.  It's also not a lot of code -- 4934 bytes for
> >8250_acpi.c versus 12488 bytes for 8250_pnp.c.  I can't think of any other
> >"legacy devices in non-legacy positions" situations like this.  Can you?
> 
> I took a quick look at the two files, and they are quite comparable 
> code-wise; the additional size in 8250_pnp.c is due to the extra comments 
> and EISA IDs defined.
> Now about the legacy devices - wouldn't you say that the keyboard/PS2 
> driver should be modified to register with the ACPI bus, just in order to 
> have everything nice & neat? or how about the parallel port, or motherboard 
> based IRDA (PNP0510)?
> Perhaps I'm just exaggerating with this, but I like to have things nice and 
> neat :)

PS/2 is obsoleted by USB, as is parallel.  I don't know abut IRDA but I
would expect it to show up as a PCI device normally.  Are manufacturers
still making machines which have this as a non-PCI device?  Remember just
because it's on the motherboard doesn't mean it's a non-PCI device.

Using the PNP layer on non-x86 would certainly lead to problems today.
For example:

        /* check if the resource is valid */
        if (*irq < 0 || *irq > 15)
                return 0;

I can't see this proposal being a good idea today.  Perhaps if the PNP
layer were cleaned up it would be.  That'd be a good place to direct
your efforts.  For example, could drivers/pnp/resource.c use more of
the facilities in kernel/resource.c?  Should some of the features from
pnp/resource.c be moved to kernel/resource.c?  Are there other places
in the tree that could make use of the features in pnp/resource.c if
they were generally available?  I've had good luck in the past answering
questions ike this.

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
