From: Andrew Kohlsmith <akohlsmith-acpi-uiYP0llB1AZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Compaq Evo N160: Fixed DSDT - battstat_applet works now
Date: Sun, 15 Dec 2002 08:46:08 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212150846.08467@-mixdown.ca>
References: <3DFB6C25.4030805@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3DFB6C25.4030805-hi6Y0CQ0nG0@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Heiko Ettelbrueck <hbruckynews-hi6Y0CQ0nG0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> Today I fixed the DSDT of my Compaq Evo N160 so that it knows the design
> capacity of its battery and allows tools like battstat_applet to
> calculate the percentage of remaining capacity.

Thank you so much.  I am currently using it.  I wonder if anything you changed 
also fixes the "polling battery state causes hard lockup" bug that myself and 
another N160 user are experiencing.

I take it you have also not had any trouble with LNKG having an incorrect 
initialization -- I have to boot with pci=noacpi or the system hangs after 
initializing the LNKF device.  I will see what I can do on this one, it was 
suggested that the ACPI entry for the LNKG device was not correct with regard 
to interrupts.

At any rate, thank you for your efforts on this.

Regards,
Andrew


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
