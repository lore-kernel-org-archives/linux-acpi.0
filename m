From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI-merges in 2.6.10-rc1-bk14 or 15 broke resume on
	Thinkpads
Date: 15 Nov 2004 11:53:08 -0500
Message-ID: <1100537587.5876.953.camel@d845pe>
References: <20041113021105.GN29980@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041113021105.GN29980-Qla6irXeAv31G4Ig9pEGJw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: David Weinehall <tao-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-11-12 at 21:11, David Weinehall wrote:
> My IBM Thinkpad T40 no longer resumes from suspend to ram (using ACPI).
> The problems started after 2.6.10-rc1-bk13 (which worked ok); -bk15 does
> not work, -bk14 did not compile, so I cannot be sure if that snapshot is
> broken too.  Everything up to, and including, -bk22 is broken.
> 
> Error messages (with a bit of context; message written down manually
> though, so it might contain typos):
> 
> PCI: Setting latency timer of device 0000:00:1f.5 to 64
> ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
> ACPI-1138: *** Error: Method execution failed [\_GPE._L18] (Node
> dff5a7ac), AE_TIME
> ACPI-0552: *** Error: AE_TIME while evaluating method [_L18] for GPE[0]
> 
> 
> For information:
> 
> 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
> 
> Further information available on request.  Please CC (or lkml) on reply,
> I'm not subscribed to the ACPI-list.

Please reply with the complete dmesg of the 1st kernel you noticed that
started failing, and the last kernel you can find that still worked.

Also, please describe more about how it fails -- does it hang after
printing the message above?

It would probably be a good idea to open a new bug report and attach
this info there:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
component: power-sleep-wake
assign it to me.

thanks,
-Len




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
