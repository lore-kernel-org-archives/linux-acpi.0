From: "Nick Bartos" <spam99-1EIjRwF9Gc5s5w19saIqfg@public.gmane.org>
Subject: Re: acpi=force safe?
Date: Fri, 6 Feb 2004 06:54:36 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41685.65.28.18.238.1076072076.squirrel@mail.diamondcpu.com>
References: <40678.65.28.18.238.1076044455.squirrel@mail.diamondcpu.com>
    <20040206064023.2a80a4dd.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040206064023.2a80a4dd.ak-l3A5Bk7waGM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

So if I have a /proc/acpi dir then it is safe?  What is the worst that
could happen if the acpi is broken in the board and I force it?  Just
courious, what if I forced it for a really old board that didn't have acp=
i
at all and thus technically couldn't work anyway (I wouldn't do that but =
I
do wonder)?  Would the acpi files in proc still exist or not?


> On Thu, 5 Feb 2004 23:14:15 -0600 (CST)
> "Nick Bartos" <spam99-1EIjRwF9Gc5s5w19saIqfg@public.gmane.org> wrote:
>
>> I can do acpi=3Dforce, but I worry about causing stability issues.
>
> If the machine works with that it is safe. However many older boards
> have broken ACPI, that is why it is disabled by default for older board=
s.
>
> -Andi
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
