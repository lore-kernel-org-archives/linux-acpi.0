From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: All 2.4.22 patches after 09-16 broken?
Date: Thu, 20 Nov 2003 16:32:00 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031120163200.GK30485@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0311200838380.17057-100000@v8.miniserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311200838380.17057-100000-tZ8E+9KPiprzJgz6305IAw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marcel Meckel <acpi-X2Xph2rMQzhn68oJJulU0Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 20, 2003 at 08:53:16AM +0100, Marcel Meckel wrote:
> I patched vanilla 2.4.22 kernel with acpi-20031002-2.4.22.diff, ran 
> make xconfig. In menu "character devices" i see option
> "/dev/agpgart (AGP Support)" twice, one as bool one as tristate option. 
> Without changing an option (and without .config of course) i get this 
> error after pressing "Save and Exit" Button:
> 
> Error in Tcl Script
> Error: can't read "CONFIG_SCSI": no such variable
> 
> ERROR - Attempting to write value for unconfigured variable 
> (CONFIG_PARPORT_PC_CML1).

Maybe the tk program is having trouble parsing this:

+  else if [ "$CONFIG_SMP" = "y" ]; then

Can you try changing that line in drivers/acpi/Config.in by putting a
new line between the `else' and the `if'?  ie make it look like:
  else
    if [ "$CONFIG_SMP" = "y" ]; then

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
