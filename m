From: "Nick Bartos" <spam99-1EIjRwF9Gc5s5w19saIqfg@public.gmane.org>
Subject: RE: acpi=force safe?
Date: Fri, 6 Feb 2004 11:16:15 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16644.65.164.3.3.1076087775.squirrel@mail.diamondcpu.com>
References: <3ACA40606221794F80A5670F0AF15F8401CBB685@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB685-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org
     >
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

Am I to understand that the worse that could happen is that the acpi
features I compiled in (just standard and the button option) just wouldn'=
t
work?  If that is the case then that would be fine.

Really I just don't want things like kernel screw ups (which I thought I
might have had once due to acpi, but I don't remember), or other things
that affect system stability.

If I can compile in these things and force acpi on and not be any worse
off stability wise than if I didn't force it, then that willl be fine for
me.



>> So if I have a /proc/acpi dir then it is safe?  What is the worst that
>> could happen if the acpi is broken in the board and I force it?  Just
>> courious, what if I forced it for a really old board that
>> didn't have acpi
>> at all and thus technically couldn't work anyway (I wouldn't
>> do that but I
>> do wonder)?  Would the acpi files in proc still exist or not?
>>
>
> It's not safe to determine that ACPI has fully enabled only through the
> existence of /proc/acpi.
>
> --Luming
>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
