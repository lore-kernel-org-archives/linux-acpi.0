From: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Subject: Re: fan control
Date: Fri, 2 May 2003 13:43:02 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030502134302.A3839@fermat.unipv.it>
References: <B900970C7DD9474C972986EB3EC7C58F0D40A0@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B900970C7DD9474C972986EB3EC7C58F0D40A0-PWLG29+z7hEKeIAE67mlpo2P0GrZ+RbP@public.gmane.org>; from Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org on Fri, May 02, 2003 at 01:28:16PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Herbert Nachtnebel <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Ok, four trip points, four FAN "devices"/states, lowest one at 40 deg. 
> You told us that your lowest temperature is about 50 deg. Hence the last one
> should be on and you don't see it => something to investigate.
> 

In this moment:

$ cat /proc/acpi/thermal_zone/TZ1/temperature
temperature:             50 C

$ cat /proc/acpi/fan/FAN*/state
status:                  on
status:                  off
status:                  off
status:                  off

(I changed the name of the fans to the more readable FAN[0-3], OK?)

This is correct.
If I  echo -n 3 > /proc/acpi/fan/FAN0/state

then the fan stops.
After reaching the second trip point, the fan starts up and I have the
following status report

$ cat /proc/acpi/fan/FAN*/state
status:                  off
status:                  on
status:                  off
status:                  off

This is what is strange.

> What hardware are you using?

Compaq Evo N800v

Cheers,

Daniele


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
