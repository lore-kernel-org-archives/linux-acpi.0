From: "greg" <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: RE: broken power button
Date: Fri, 6 Feb 2004 12:53:37 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040206175337.M29360@morningdave.org>
References: <3ACA40606221794F80A5670F0AF15F8401CBB686@PDSMSX403.ccr.corp.intel.com> <1076089128.4731.1.camel@tinny.home.foo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1076089128.4731.1.camel-3lu5YwujmwObGSPjaX/RoA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>, "Yu,Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>, "acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

---------- Original Message -----------
From: "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sent: Fri, 06 Feb 2004 09:38:48 -0800
Subject: RE: [ACPI] broken power button

> On Fri, 2004-02-06 at 09:17, Yu, Luming wrote: 
> > > > I applied the patch; I think ACPI should report a warning 
> > > in this case. 
> > 
> > I suspect that patch is not necessary.
> > 
> > IAccording to the description of ACPI spec section 4.7.2.2.1.1
> > there should have SCI interrupt triggered by Fixed Power Button.
> > 
> > To verify whether Fixed Power Button works as expected, you 
> > can just hit power button , and check /proc/interrupts to see whether
> > ACPI interrupt number get increased. 
> 
> My ACPI interrupt number climbs by 8 about once every two seconds (step
> function).
> 
> if I press the power button with Greg's patch (i.e. force PWRB not
> PWRF), it jumps by 2 when I press the button (then another 8 less 
> than one second later).  I also get this in /var/log/acpid:
> 
> [Fri Feb  6 09:26:22 2004] received event "button/power PWRB 
> 00000080 00000006"
> [Fri Feb  6 09:26:22 2004] executing action "/etc/acpi/default.sh 
> button/power PWRB 00000080 00000006"
> [Fri Feb  6 09:26:22 2004] BEGIN HANDLER MESSAGES
> [Fri Feb  6 09:26:22 2004] END HANDLER MESSAGES
> [Fri Feb  6 09:26:22 2004] action exited with status 0
> [Fri Feb  6 09:26:22 2004] completed event "button/power PWRB 
> 00000080 00000006"
> 
> without the patch, the power button also causes the # of interrupts 
> to jump by 2, but I get nothing in /var/log/acpid.
> 
> 	Scott
------- End of Original Message -------


I can confirm this behavior on my machine as well.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
