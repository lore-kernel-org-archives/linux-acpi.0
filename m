From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Entering C3 Processor State without a Bus Arbiter
Date: Thu, 15 Jan 2004 15:52:12 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040115154555.V73140@root.org>
References: <Law11-OE36TK4GXSNMh0000bd93@hotmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Law11-OE36TK4GXSNMh0000bd93-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
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

On Thu, 15 Jan 2004, Dino Klein wrote:
> I'm curios as to why the implementation does not enter C3 without the
> presence of a Bus Arbiter; also, how come a comment in the source claims
> that C3/WBINVD is too expensive?
>
> After removing the restrictions in the source files, and adding a WBINVD
> instruction right before the read from P_LVL3 - the processor was put in
> the C3 state. This is on my Via Apollo Pro133A based Abit VP6 board,
> which does not have a Bus Arbiter. Just for the record, I did pull out
> the second CPU, so I can do "safer" experimentation.

WBINVD is too expensive when you're entering C3 hundreds of times per
second.  Try playing back an mp3 while dd'ing a CDROM in PIO mode to your
hard drive.  Goodbye data, hello backups!  The CPU can't snoop the bus in
C3.

> I've seen a thread talking about how the processor was not put into C3
> as often enough, when the USB drivers were loaded - in my case I would
> say that it was put too often, this with the UHCI + EHCI + HID drivers
> loaded, and two mice and one hub attached.

Um, because without BM detection, you're entering C3 with BM active while
USB is enabled.

-Nate


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
