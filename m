From: Dan <overridex-Kz9Au3A7zptBDgjK7y7TUQ@public.gmane.org>
Subject: RE: fan control based on temp
Date: Fri, 18 Jun 2004 02:48:33 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1087541313.28996.0.camel@nazgul.overridex.net>
References: <6E0C289723A0564F9A8279E236E8565F07A001D5@pdsmsx402.pd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6E0C289723A0564F9A8279E236E8565F07A001D5-4yWAQGcml64divtuJNk2fFDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-06-17 at 01:20, Wang, Zhenyu Z wrote:
> PowerResource (PFNL, 0x00, 0x0000)
>         {
>             Method (_STA, 0, NotSerialized)
>             {
>                 If (\_SB.PCI0.PIB.EC0.ECOK)
>                 {
>                     And (\_SB.PCI0.PM.GO00, 0x01, Local0)
>                     Return (Local0)
>                 }
>                 Else
>                 {
>                     Return (0x00)
>                 }
>             }
> 
>             Method (_ON, 0, NotSerialized)
>             {
>             }
> 
>             Method (_OFF, 0, NotSerialized)
>             {
>             }
>         }
> PowerResource (PFNH, 0x00, 0x0000)
>         {
>             Method (_STA, 0, NotSerialized)
>             {
>                 If (\_SB.PCI0.PIB.EC0.ECOK)
>                 {
>                     And (\_SB.PCI0.PM.GO00, 0x01, Local0)
>                     Return (Local0)
>                 }
>                 Else
>                 {
>                     Return (0x00)
>                 }
>             }
> 
>             Method (_ON, 0, NotSerialized)
>             {
>             }
> 
>             Method (_OFF, 0, NotSerialized)
>             {
>             }
>         }
> 
> Method _ON and _OFF are empty. ACPI can't control it.
> Try this to test:
> Method (_ON, 0, NotSerialized)
> {
>         Or (\_SB.PCI0.PM.GO00, 0x01, \_SB.PCI0.PM.GO00)
> }
> Method (_OFF, 0, NotSerialized)
> {
>         And(\_SB.PCI0.PM.GO00, 0xFE, \_SB.PCI0.PM.GO00)
> }
> 

Well, 24 hours later compiling on and off, and the fan seems to be going
on and off properly - hopefully that did the trick! :) 

============================
-Dan "OverrideX"-
ICQ: 7171522
AIM: OverrideX
Jabber: OverrideX-/eSpBmjxGS4dnm+yROfE0A@public.gmane.org

I have often regretted my speech, never my silence. -- Publilius Syrus




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
