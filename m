From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI Debugger
Date: Tue, 3 Sep 2002 14:39:37 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE08@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "'KOCHI, Takayoshi'" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: KOCHI, Takayoshi [mailto:t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org] 
> Currently drivers/acpi/debugger subdirectory is not built and
> some files (dbcmds.c, dbxface.c) call acpi_dm_disassemble(), which
> is not a part of ACPI driver distribution for Linux
> (I could find the function in the acpica-unix distribution).
> 
> Is there any plan to revive these debugger stuff or will they
> be simply thrown away?

Hmm. Yeah, so the ACPI driver *does* have a cmdline debugger that allows one
to execute arbitrary control methods, step thru, etc. It is exposed through
a kgdb module. I haven't used it in more than 18 months. Either it should be
fixed, or removed. (Not that the source is hurting anything just sitting
there, but if it's broken...)

Are you interested in reviving it?  If not, I'll remove it, I guess....

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
