From: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Subject: Re: Compaq evo n800v
Date: Sat, 8 Mar 2003 20:59:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030308205945.A17123@fermat.unipv.it>
References: <1047125223.5077.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1047125223.5077.28.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>; from anders.persson-sT6loi8rTDSci/EUP2OQSw@public.gmane.org on Sat, Mar 08, 2003 at 01:07:03PM +0100
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Anders Persson <anders.persson-sT6loi8rTDSci/EUP2OQSw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Anders,
I have a Compaq EVO N800v too.

> 2.4.20 kernel +
> patch-2.4.21-pre4.gz +
> acpi-20030218-2.4.21-pre4.diff.gz +
> linux-2.4.18-acpi-20020709-dsdt.patch +
> custom dsdt

I am using 2.4.20, no 21-pre patch.

> 
> AC- and battery-status works just fine, as well as the Fn-combinations
> for screen-brightness. 

Same to me.

> But no matter how low the CPU-load, the clock frequency is always at
> max.

Same, is that different under Windows?

> Also, the fan(s?) are always on making noise (at relatively low
> speed but still too high compared to under Win-XPP).  

I am not experiencing that. I can see 4 fans in /proc/acpi/fan and their status
depends on the (three) thermal zones.
I guess you did something wrong with your custom dsdt.

FYI:

ls /proc/acpi/fan

C1D9  C1DA  C1DB  C1DC

ls /proc/acpi/thermal_zone

TZ1  TZ2  TZ3



Daniele


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
