From: "Bryan K. Wright" <bryan-j2wAk2T2zOxQaOoIv/cCD/2DmoZIrT0C@public.gmane.org>
Subject: Re: Bad interaction between ehci-hcd and acpi?
Date: Thu, 04 Mar 2004 09:38:26 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403041438.i24EcRZ09051@ayesha.phys.Virginia.EDU>
References: <1078181249.3511.5.camel@darkstar>
Reply-To: bryan-utW8kV9oO443r0Ub5QXD9Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: Your message of "Mon, 01 Mar 2004 22:47:29 GMT."
             <1078181249.3511.5.camel-4/PLUo9XfK8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi again,

	Thanks to S=E9rgio Monteiro Basto for the suggestion about upgrading
to a slightly later kernel.  This seems to help, but there's still a =

problem.  I'm now using 2.4.25.  The overheating problem is less, but
the temperature still rises by about 10 degrees whenever I plug in
a high-speed USB device, and stays there until I rmmod the ehci-hcd
module.  After removing the module, the temperature drops (within a few
seconds) back to a normal value.

						Bryan

sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org said:
> On Mon, 2004-03-01 at 17:08, Bryan K. Wright wrote:
> 	Here are the configuration details:
> Kernel 2.4.21 (vanilla) with the acpi-20030619-2.4.21.diff patch.
> Sharp PC-AV18 laptop (KN266, Athlon XP-M 1800+)
> Tested with two different models of Epson scanner, and with two
> different
> brands of external USB disks.
> =

> 	Has anybody else seen similar symptoms?

> yes we had this symptoms when we work with that kernel(2.4.21) after 4
> release 2.4.25 I don't remember any complain. Please upgrade you
> kernel to last one, and test it again . =



-- =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Bryan Wright                |"If you take cranberries and stew them like =

Physics Department          | applesauce, they taste much more like prune=
s =

University of Virginia      | than rhubarb does."  --  Groucho =

Charlottesville, VA  22901  |			=

(434) 924-7218              |         bryan-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
