From: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Subject: Re: acpi debug messages from compaq presario 2800...
Date: Wed, 07 Aug 2002 19:07:04 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208072307.TAA05468@magic-pi-ball.mit.edu>
References: <20020807225425.5804.qmail@scrye.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Your message of "Wed, 07 Aug 2002 16:54:19 MDT."
             <20020807225425.5804.qmail-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> Could not install Pci_config handler for C03C, AE_ALREADY_EXISTS 
> ....evrgnini-0243: *** Error: Could not install Pci_config handler for
> C03C, AE_ALREADY_EXISTS
> 
> Is this a problem? Any ideas what C03C is? 

I have the exact same error messsages.  As I speculated earlier,
this could be affecting the soundcard and modem, which are both
PCI.  The soundcard ALSA drivers must be unloaded and reloaded
on suspend, sound apps die when I hit "pause", and Quake 3 
doesn't work any more (complains of "broken pipe" when 
accessing the emulated OSS device).  Second, modem has gotten 
flakier -- it refuses to connect after coming out of a suspend, 
requiring a reboot.  I'm trying out unloading/reloading those 
modules as well in my suspend script ...

None of these problems occurred prior to modifying my DSDT.

Can you verify these effects?

Unfortunately, I haven't yet figured out what C03C is.


Sourav


PS:  There's also token in the DSDT that starts with "*SYN" ...
i wonder if that needs to be changed to "SYN" as well.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
