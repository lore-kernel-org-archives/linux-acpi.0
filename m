From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: All 2.4.22 patches after 09-16 broken?
Date: Thu, 20 Nov 2003 16:03:17 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031120140317.GA4225@luna.mooo.com>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 20, 2003 at 08:53:16AM +0100, Marcel Meckel wrote:
> Hello,
> 
> can someone confirm this strange behaviour:
> 
> I patched vanilla 2.4.22 kernel with acpi-20031002-2.4.22.diff, ran 
> make xconfig. In menu "character devices" i see option
> "/dev/agpgart (AGP Support)" twice, one as bool one as tristate option. 
> Without changing an option (and without .config of course) i get this 
> error after pressing "Save and Exit" Button:
> 
> Error in Tcl Script
> Error: can't read "CONFIG_SCSI": no such variable
> 

I had this error too. Using make menuconfig seemed to work OK though.
I got this error also with when firing up xconfig and immediately exiting
with a valid .config

> ERROR - Attempting to write value for unconfigured variable 
> (CONFIG_PARPORT_PC_CML1).
> 
> Stack trace says:
> 
> can't read "CONFIG_SCSI": no such variable
>     while executing
> "list $CONFIG_BLK_CPQ_CISS_DA $CONFIG_SCSI"
>     (procedure "writeconfig" line 672)
>     invoked from within
> "writeconfig .config include/linux/autoconf.h"
>     invoked from within
> ".f0.right.save invoke"
>     ("uplevel" body line 1)
>     invoked from within
> "uplevel #0 [list $w invoke]"
>     (procedure "tkButtonUp" line 7)
>     invoked from within
> "tkButtonUp .f0.right.save
> "
>     (command bound to event)
> 
> Not necessary to say that this does not happen with vanilla kernel 
> neighter with acpi-20030916-2.4.22.diff from sourceforge ftp.
> 
> Checked this with acpi-20030918-2.4.22.diff too, same strange result.
> 
> Someone an idea what's going wrong here?
> 
> (Didn't want to open a new bug unless i am 100% sure it's a bug in the 
> patch)
> 
> Greetings,
> Marcel.
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
