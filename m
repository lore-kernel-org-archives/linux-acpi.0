From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: acpi events
Date: 25 Feb 2004 00:45:01 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077687901.5913.100.camel@dhcppc4>
References: <1077631684.403b5ac4e6272@imp5-q.free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1077631684.403b5ac4e6272-i+kWGVKuYDKksujEA26zIQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sweafty-GANU6spQydw@public.gmane.org
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

does the power button result in incrementing the acpi interrupt in
/proc/interrupts?

if no, then we've got your SCI configured incorrectly, something I'm
looking at right now.

if /proc/interrupts shows IOAPIC mode, you're probably suffering from
this one:

http://bugzilla.kernel.org/show_bug.cgi?id=1622

though if you send me your acpidmp output, /proc/interrupts, and dmesg,
I can tell for sure.

cheers,
-len

On Tue, 2004-02-24 at 09:08, sweafty-GANU6spQydw@public.gmane.org wrote:
> Hi,
> 
> I've got some problems with ACPI / Dell Inspiron 5100 (bios revision A26). I
> tried all kernels since 2.6.1, and i always got the same issue: There is no ACPI
> event writen to /proc/acpi/event. 
> 
> I close the lid (its state gets changed from 'open' to 'close') => no event
> I push power button => no event
> 
> Through boot messages (dmesg), all these are detected. Can somebody help me
> figuring out what the problem is ?
> 
> Cheers,
> 
> --
> Philippe
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id56&alloc_id438&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
