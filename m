From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: ACPI and the PNP Layer
Date: Mon, 2 Feb 2004 10:31:39 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040202102827.Y22816@root.org>
References: <Law11-F969ScIXWOReP0000022f@hotmail.com>
 <20040201172447.GV18725@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040201172447.GV18725-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 1 Feb 2004, Matthew Wilcox wrote:
> On Sun, Feb 01, 2004 at 02:41:02AM +0000, Dino Klein wrote:
> > I took a quick look at the two files, and they are quite comparable
> > code-wise; the additional size in 8250_pnp.c is due to the extra comments
> > and EISA IDs defined.
> > Now about the legacy devices - wouldn't you say that the keyboard/PS2
> > driver should be modified to register with the ACPI bus, just in order to
> > have everything nice & neat? or how about the parallel port, or motherboard
> > based IRDA (PNP0510)?
> > Perhaps I'm just exaggerating with this, but I like to have things nice and
> > neat :)
>
> PS/2 is obsoleted by USB, as is parallel.  I don't know abut IRDA but I
> would expect it to show up as a PCI device normally.  Are manufacturers
> still making machines which have this as a non-PCI device?  Remember just
> because it's on the motherboard doesn't mean it's a non-PCI device.

Compare the output of acpidump and the datasheet for a Super I/O chip some
time.  Everything on the LPCB is legacy and is thus probed through ACPI,
not PCI.  IRDA is almost always on the Super I/O.

http://www.via.com.tw/en/Products/superIO.jsp

-Nate


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
