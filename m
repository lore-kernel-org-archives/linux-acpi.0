From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: 21 Sep 2002 15:02:31 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1032634954.2215.2.camel@darkstar.portugal>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE80-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2002-09-19 at 02:27, Grover, Andrew wrote:
> I wanted to make a special request for testing of the 2.4 patch (or should I
> say, MEGA-patch).
> 
> Marcelo has asked for widespread testing of it, in anticipation of likely
> 2.4 mainline inclusion. I will be posting a call for testing to linux-kernel
> soon, but am posting this here first to hopefully weed out any really bad
> bugs that may have crept in.
> 
> The main issues of importance are:
> 
> - DOES IT BOOT?
yes
> - DOES IT ASSIGN INTERRUPTS PROPERLY?
> 
yes normally, and had correct the events, now events works without
kacpid patch.
> Failure to do so either indicates a bug that we need to fix (fast) or a
> system that should go on the blacklist. dmesg now includes the DSDT
> signature to aid blacklisting.
> 
> Issues like whether the battery reports stats properly are of secondary
> importance.
> 
> Thanks in advance.
> 
> Regards -- Andy
> 
> -----------------------------
> Andrew Grover
> Intel Labs / Mobile Architecture
> andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
