From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: acpi on r40e
Date: Tue, 10 Feb 2004 08:12:32 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040210081120.W80646@root.org>
References: <Pine.LNX.4.44.0402072145280.2886-100000@aero.iisc.ernet.in>
 <1076387688.4110.576.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1076387688.4110.576.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Praveen C <praveen-8a50ANe9Mx0/NI2e8YfAcJ/QNRX+jHPU@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 9 Feb 2004, Len Brown wrote:
> On Sat, 2004-02-07 at 11:20, Praveen C wrote:
> > Another problem with acpi which I forgot to mention is that it makes
> > the special buttons for volume and brightness control ineffective. If I
> > boot the same kernel with acpi=off those buttons work fine.
>
> Interesting.
> If you boot, say with "acpi=off", your volume and brightness buttons
> work, but if you boot with ACPI enabled they have no effect?
>
> you DSDT has an IBM defined device:
>
>                     Device (HKEY)
>                     {
>                         Name (_HID, EisaId ("IBM0068"))
>
> which sure sounds like it might be a hot-key device;-)
> However, not immediately clear to me how ACPI w/o vendor-specific
> extensions would talk to it.  Even more unclear is how and why these
> buttons work when ACPI is disabled, and how ACPI interferes with their
> proper operation when it is enabled.

In the APM case, SMM handles the buttons.  In the ACPI case, the SMI is
tristated and the SCI is used.  However, Linux has no IBM hotkey driver
and hence his volume buttons don't work.

-Nate


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
