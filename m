From: Diego Zuccato <diego-gmoNqwowlqBr8A+qpt3pXFzrSV/HdtiB@public.gmane.org>
Subject: Re: Runlevel for Sleep?
Date: Mon, 09 Sep 2002 23:52:22 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D7D3436.8C579CCD@otello.alma.unibo.it>
References: <Pine.LNX.4.44.0209071232170.1021-100000@cherise.pdx.osdl.net> <200209081126.g88BQjn05186@pfn1.pefnos> <3D7C5FDF.4FB4E759@otello.alma.unibo.it> <200209090855.g898rbA19798@pfn1.pefnos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

"P. Christeas" wrote:

> The whole point of the initscripts is that this is your call. The kernel
[...]
> I just try to imagine situations thay may need design consideration.
Uhm... Then just call your scripts from acpid. Or manage yourself ACPI
events. It's all in userspace. If a service needs special handling,
simply do it before (suspend) or after (resume) echoing to
/proc/acpi/sleep. IMO there's no need to provide extra hooks.
The timer setting, IIRC, is one of the "services" that need that kind of
special handlin (at resume, you have to set current time from hw clock).
Think echoing to /proc/scpi/sleep as a REALLY slow ATOMIC operation :-)

BYtE,
 Diego.


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
