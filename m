From: Bernd Petrovitsch <bernd-GBwJepH+xoVeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH] 2.6.0-test4: Trivial /sys/power/state patch, sleep
 status report
Date: 26 Aug 2003 00:40:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1061851218.12331.23.camel@gimli.at.home>
References: <200308260125.30194.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ykqYJFslnnQ6Pcgb/vDd"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200308260125.30194.p_christ-U04EIuiosng@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-ykqYJFslnnQ6Pcgb/vDd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2003-08-26 at 00:25, P. Christeas wrote:
> Just found out that by 'echo sth_wrong > /sys/power/state' the kernel would 
> oops in a fatal way (no clean exit from there).
> The oops suggested that the code would enter an invalid fn.
> 
> You may apply the included patch to solve the bug. IMHO doing a clean exit is 
> much preferrable than having BUG() there.
[...]
> ----
[...]
> diff -Bbur /diskb/users/panos/linux-off/kernel/power/main.c /usr/src/linux/kernel/power/main.c
> --- /diskb/users/panos/linux-off/kernel/power/main.c	2003-08-23 12:13:17.000000000 +0300
> +++ /usr/src/linux/kernel/power/main.c	2003-08-26 00:59:34.000000000 +0300
> @@ -500,7 +514,7 @@
>  		if (s->name && !strcmp(buf,s->name))
>  			break;
>  	}
> -	if (s)
> +	if ( (s) && (state < PM_SUSPEND_MAX) )
>  		error = enter_state(state);
>  	else
>  		error = -EINVAL;

What do you think about the attached patch to solve the bug and remove a
warning?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

--=-ykqYJFslnnQ6Pcgb/vDd
Content-Disposition: attachment; filename=power-main.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=power-main.patch; charset=ISO-8859-1

--- linux-2.6.0-test4/kernel/power/main.c	Sat Aug 23 01:53:13 2003
+++ linux-2.6.0-test4-patched/kernel/power/main.c	Mon Aug 25 21:16:50 2003
@@ -492,7 +492,7 @@
 static ssize_t state_store(struct subsystem * subsys, const char * buf, si=
ze_t n)
 {
 	u32 state;
-	struct pm_state * s;
+	struct pm_state * s =3D NULL;
 	int error;
=20
 	for (state =3D 0; state < PM_SUSPEND_MAX; state++) {

--=-ykqYJFslnnQ6Pcgb/vDd--



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
