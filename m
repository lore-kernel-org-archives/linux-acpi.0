From: Philippe =?iso-8859-1?q?Cl=E9ri=E9?= <philippe-vlmYvWlZpDU@public.gmane.org>
Subject: Re: General ACPI/Linux question
Date: Sun, 26 Jan 2003 08:23:35 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301260823.35858.philippe@gcal.net>
References: <1043546064.14472.9.camel@nefeli>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1043546064.14472.9.camel-coIz1MXBdV0@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=46or what it's worth, I have ACPI working fine on a 1700T with=20
Gentoo Linux and kernel 2.4.20-acpi-r9. As far as I can tell=20
this kernel is vanilla + acpi 20021212. No modifications were=20
needed.=20

This is the first kernel I have tried that gave me some info on=20
the battery. klaptop is working and shows a battery icon when=20
on battery or an AC plug when on AC. And it pops up a message=20
when battery power is low. But it does not show whether=20
capacity is at 90, 50 or 20%.=20

I have not checked any of the sleep modes since I don't use them=20
at all so I can't comment on that.

=46or the moment I'm happy.

Regards,
Philippe

On Saturday, 25 January 2003 20:54, Constantinos Antoniou wrote:
> Hello,
>
> I have a laptop (Compaq Presarion 1700T) and would really
> really like to have some ACPI support (battery status is very
> important, suspend to ram or disk - anything faster than
> reboot- would be very very useful and welcome).
>
> I have not tried every possible trick, and in any case I am
> hoping to get some things working this year... either with
> the introduction of ACPI in RH8.1 or otherwise (ok, this is
> not flame-bait. Let me move on
>
> :)) This is not a system/problem specific post, however.
>
> My question is: One of the most usual things I see in the
> various newsgroup posts is that DSDT tables are buggy, and
> people need to disassemble them, edit them, replace them etc
> etc. However, windows power management on the same machines
> works. So what is the situation?
>
> The way I (don't) understand it, the ACPI implementation
> expects some things to be defined correctly in the DSDT
> table. However, some OSes manage to work with whatever is
> there.
>
> And to go one step further, if I change this DSDT thingie,
> will the ACPI functionality in the other OSes still work? So,
> would an option be to be more lenient (I understand that
> there are standards and people should respect them...)
>
> Thanks in advance and please be considerate in the replies -
> IANA ACPI expert.
>
> Costas

=2D-=20
Best regards,
Philippe Cl=E9ri=E9


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
