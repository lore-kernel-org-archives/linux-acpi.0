From: Mads Paulin <paulin-/w0Os/Ss2Sh/SzgSGea1oA@public.gmane.org>
Subject: Mandrake 10 weird acpi behaviour
Date: Tue, 16 Mar 2004 10:28:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079429336.10065.8.camel@skinnerup.mip.sdu.dk>
References: <1079031999.3679.1.camel@darkstar>
	 <20040311230047.GA20345@stikine.ucs.sfu.ca>
	 <Pine.LNX.4.58.0403121055010.1203@frog.athome>
	 <20040312193716.GC25056@stikine.ucs.sfu.ca>
	 <Pine.LNX.4.58.0403131152490.1228@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0403131152490.1228-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

I have recently installed Mandrake 10 on my ASUS M2400N laptop and have
experienced some strange behaviour (perharps) originating from ACPI or
acpid.

When the laptop boots, everything is fine. ACPI is working correct and
acpid is started is on boot. When I hit the powerbutton, the laptop
shuts down fine. However, althoug the acpi events are correctly reported
when the hotkeys are pressed, the scripts/assigned applications are not
executed.

If I issue a 'service acpid restartø to restart the acpid daemon, the
applications assigned to the hotkeys are launched as supposed. However,
in this case when I hit the powerbutton, the laptop immediately calls
acpi_power_off and shuts down uncleanly without unmounting file systems
or anything.

Any ideas to what can be causing this ??

The kernel is a mandrake 2.6.3-4mdk compiled from the mandrake source. I
had to recompile to disable local apic (known problem for the ASUS
M2400N). acpi i compiled into the kernel.

Regards,
Mads





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
