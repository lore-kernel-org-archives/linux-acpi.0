From: Alvaro Lopes <alvieboy-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org>
Subject: Re: Thermal module errors
Date: Fri, 07 Feb 2003 11:29:40 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E4398A4.6040907@alvie.com>
References: <32774.192.168.10.204.1044602945.squirrel@benham.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <32774.192.168.10.204.1044602945.squirrel-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Darren Benham wrote:

>I don't know if anyone's seen this but I haven't seen anything mentioned
>(easily) in the list archives.  Here's the output from a kernel log when
>trying to load the thermal module.  I've seen this with kernels 2.4.18,
>2.4.20 , and 2.4.21pre4 (with the latest patch, which applied cleanly,
>BTW).
>Feb  6 23:04:37 ltdbenham kernel: dswstate-0251 [29]
>ds_result_pop_from_bot: No result objects! State=3Dc15d8828Feb  6 23:04:=
37 ltdbenham kernel:  dsutils-0494 [29] ds_create_operand   =20
>: Missing or null operand, AE_AML_NO_RETURN_VALUEFeb  6 23:04:37 ltdbenh=
am kernel:  dsutils-0587 [28] ds_create_operands  =20
>: While creating Arg 1 - AE_AML_NO_RETURN_VALUEFeb  6 23:04:37 ltdbenham=
 kernel:  psparse-1102: *** Error: Method
>execution failed [\_TZ_.C1F1] (Node c15ede08), AE_AML_NO_RETURN_VALUEFeb=
  6 23:04:37 ltdbenham kernel:  psparse-1102: *** Error: Method
>execution failed [\_TZ_.TZ1_._TMP] (Node c15ebce8), AE_AML_NO_RETURN_VAL=
UE
>
> =20
>
There's a problem with your DSDT. Can you sent it to this list ? I=20
believe there's already a DSTD patch for your compaq or a similar one.

Install the Intel iasl package (you can find it at=20
http://www.intel.com/technology/iapc/acpi/downloads.htm )  and do a=20
'iasl -d /proc/acpi/dsdt'. Send here the results, please.

=C1lvaro

--=20

=C1lvaro Lopes=20
---------------------
A .sig is just a .sig




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
