From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: RE: lost thermal zones on 20040715 nc6000
Date: Wed, 11 Aug 2004 10:55:29 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092243329.5907.10.camel@tdi>
References: <37F890616C995246BE76B3E6B2DBE05501A8B206@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <37F890616C995246BE76B3E6B2DBE05501A8B206-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-08-11 at 09:42 -0700, Moore, Robert wrote:
> 
> Alex,
> 
> This is an interesting problem, and I do not think it is a problem with
> the AML interpreter.  The machine's AML code seems to be either ignoring
> an error case or accidentally generating an improper value used during a
> package comparison (Match).
> 
> 1) For TZ1._TMP, C201 is called with an arg of 0.  For TZ2._TMP, C201 is
> called with an arg of 1.  For TZ3._TMP, C201 is called with an arg of 2.
> 
> 2) When C201 is called with an arg < 2, a different code path is
> followed.  This code path invokes another method, C08F, which is
> returning a value of 0x1C00 (in what appears to be the "normal" code
> path)
> 
> 3) This return value (in Local1) in turn gets compared to elements of
> the package C1EE as follows:
> 
> Store (Match (DerefOf (Index (DerefOf (Index (C1EE, C200 (Arg0))),
> 0x01)), MGT, Local1, MTR, 0x00, 0x00), Local0)
> 
> 4) None of the elements of C1EE are greater than 0x1C00, so the Match()
> operator returns 0xFFFFFFFF (indicating failure).  This is stored in
> Local0.
> 
> 5) Local0 is then passed to C202 as follows:
> 
> C202 (Local0, Arg0)
> 
> 6) In C202, the zeroth argument is used as an index into package C1EE.
> 
> 7) Since this argument is 0xFFFFFFFF, the Index() operation fails.
> 
> It's hard to guess what the original code is attempting, but I do not
> see any errors in the interpretation of the code.
> 
> Did this actually work at some time in the past?
> 

   Strange.  Yes, I'm currently running 2.6.8-rc4 on it w/ ACPI 20040326
and all 3 thermal zone seem to work just fine:

$ acpi -Vf
     Battery 1: charged, 100%
     Battery 2: discharging, 15%, 00:31:33 remaining
     Thermal 1: ok, 111.2 degrees F
     Thermal 2: ok, 134.6 degrees F
     Thermal 3: ok, 91.4 degrees F
  AC Adapter 1: off-line

$ cat /proc/acpi/thermal_zone/TZ1/polling_frequency 
<polling disabled>
$ cat /proc/acpi/thermal_zone/TZ1/cooling_mode 
cooling mode:            passive
$ cat /proc/acpi/thermal_zone/TZ1/trip_points 
critical (S5):           103 C
passive:                 100 C: tc1=1 tc2=2 tsp=100 devices=0xf7ffe500 
active[0]:               80 C: devices=0xf7f38920 
active[1]:               65 C: devices=0xf7f39880 
active[2]:               55 C: devices=0xf7f39800 
active[3]:               45 C: devices=0xf7f39780 
$ cat /proc/acpi/thermal_zone/TZ1/temperature 
temperature:             44 C
$ cat /proc/acpi/thermal_zone/TZ1/state 
state:                   ok

I don't see any ACPI error messages with the older version of the CA.
Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
