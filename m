From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: kacpid respawning under linux-2.4.20 on Toshiba Satell
	ite 5105
Date: Fri, 3 Jan 2003 10:46:57 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847137F1D@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ken Hughes <khughes-kam3zbT8ll8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Ken Hughes [mailto:khughes-kam3zbT8ll8@public.gmane.org] 
> I have a Toshiba Satellite 5105-S501 and have problems with the latest
> patches for the 2.4.20 kernel.  Under 2.4.19 things work ok, but with
> the 2.4.20 patches I get kacpidpc respawning continuously.  My load
> average sits around 1 with the kacpidpc thread always showing up
> as a zombie process. It also seems that this forces the CPU fan to
> run continuously.  I'm trying to build a 2.4.20-pre kernel (with
> little luck) to see at what point this change occurs.
> 
> Can anyone give me some pointers where to look next in the 2.4.20
> sources?

I would guess if you looked at /proc/interrupts you would also see
continuous ACPI interrupts as well. Is this the case?

I would start tracing what is going on from acpi_ev_sci_handler().

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
