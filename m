From: Bernd Schubert <Bernd.Schubert-ZRyP5vvp4SQZDP5dtiX3a0ZMdOyQQXjt@public.gmane.org>
Subject: Re: psmouse.c, throwing 3 bytes away
Date: Mon, 9 Feb 2004 00:03:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040208230314.GA21937@fubini.pci.uni-heidelberg.de>
References: <20040208215935.GA13280@ucw.cz> <20040208221933.92D0B3F1B@latitude.mynet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040208221933.92D0B3F1B-hJetzOkQQ2D26ODOwDBsm7iufofboIZS@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vojtech-AlSwsSmVLrQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Feb 08, 2004 at 11:19:32PM +0100, aeriksson-97jfqw80gc6171pxa8y+qA@public.gmane.org wrote:
> 
> > 
> > > Problem still occurs :-(
> > 
> > I have good news - I've managed to reliably reproduce the bug on my
> > machine and that means I now have a good chance to find and fix it.
> > 
> 
> Another data point. I just tried switching to a non-preempt kernel as
> was suggested by someone. The problem still occurs.
> 

Hello,

on IBM Thinkpads R31 this is also easiliy to reproduce:

For 2.6. one only needs to read from /proc/apm or /proc/acpic/...
and the mouse becomes crazy and one gets the throwing 2 bytes away
messages in the log files. By fast reading in an endless loop even
input from the keyboard is ignored.

For 2.4. this only happens on reading from /proc/apm, somehow acpi is not
affected in 2.4. kernel versions.

Well, for R31's it is said that it is the bad bios, but maybe its
related? Any ideas why it doesn't happen with acpi and 2.4.? 

My knowlege of the kernel interals is quite low and pretty much limited
to the basic vfs area, so could you please give me some good advises how to
debug this?

Thanks,
	Bernd


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
