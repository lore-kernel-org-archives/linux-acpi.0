From: "Darren Benham" <dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
Subject: Re: Compaq Evo N600c DSDT / uploaded / working / with errors
Date: Thu, 1 May 2003 15:06:10 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <14413.64.164.111.254.1051826770.squirrel@benham.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-Am9021/vqXxTGLny65vKQgC/G2K4zDHf@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

You need to add some external statements to get rid of the "Object does
not exist" error... they are defined in an SDST table....

Richard Harman said:
> I don't know AML/ASL, but I think I fixed most of the errors in my
> Compaq Evo N600c laptop's DSDT.  I've uploaded it to the DSDT
> database, http://acpi.sourceforge.net/dsdt/view.php?id=26.
>
> Everything but the lcd backlight turning off works.  Fans are
> controllable, I can read proper values out of battery info, the
> thermal zones work, but I'm not sure about the cpu
> throttling/performance settings.
>
> Compiles with the following errors:
>
> dsdt-fixed.dsl    53:             If (LEqual (\C001, 0x00))
> Error    1022 -             Object does not exist ^  (\C001)
>
> dsdt-fixed.dsl  3663:                             Method (_OFF, 0,
> NotSerialized) Warning  2019 -         Not all control paths return a
> value ^  (_OFF)
>
> dsdt-fixed.dsl  6157:                 \_PR.C000
> Error    1022 -         Object does not exist ^  (\_PR.C000)
>
> dsdt-fixed.dsl  6213:                         Notify (\_PR.C000, 0x80)
> Error    1022 -                         Object does not exist ^
> (\_PR.C000)
>
> dsdt-fixed.dsl  6286:                         Notify (\_PR.C000, 0x80)
> Error    1022 -                         Object does not exist ^
> (\_PR.C000)
>
> The rest I don't know how to fix :)  If someone who knows AML/ASL
> would be kind enough to fix the rest of it I'd be an extremely happy
> camper.
>
> Richard
> -------------------------------------------------
> Richard G Harman Jr <me+nospam-Am9021/vqXxTGLny65vKQgC/G2K4zDHf@public.gmane.org>
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-- 
Darren





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
