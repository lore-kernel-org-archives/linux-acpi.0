From: =?ISO-8859-1?Q?S=E9rgio?= "M. Basto" <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: Compaq Presario 2175US
Date: Tue, 13 Jul 2004 17:01:20 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1089734480.24119.44.camel@rh10.fe.up.pt>
References: <007601c468ec$fe378b00$3901a8c0@nurscaresvr.integracarehh.com>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=-V4HuAJpOYz9rDRtz2qYE"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <007601c468ec$fe378b00$3901a8c0-r0wPPUdlpptkIWvYYjssb9VCoBd5ohsJtWf/oUnstBo@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jeremy Mann <jmann-hthdAawbG4PxMOqTD017tQC/G2K4zDHf@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-V4HuAJpOYz9rDRtz2qYE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-07-13 at 16:20, Jeremy Mann wrote:

> I've just spent the better part of 2 hours looking through the list archives
> and see many posts related to the 2100 series Compaq laptops, but I didn't
> see anything related to how I can get ACPI active enough to dump my DSDT
> code.  I'm running Mandrake 10, just tried a kernel recompile using an IRQ9
> hack, but my laptop still gets a hard lockup upon boot from a 2.6.7
> kernel(and 2.6.3, and 2.4.2x).  The only way I can get the laptop to bootup
> is using either ACPI=off or ACPI=ht(mandrake default).  Any suggestions?  I
> just flashed to the latest and greatest(ha!) bios from compaq and tried
> again with no such luck.
> 

try boot with ACPI=on nolapic



Sergio M. B.

--=-V4HuAJpOYz9rDRtz2qYE
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.9">
</HEAD>
<BODY>
On Tue, 2004-07-13 at 16:20, Jeremy Mann wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#737373"><I>I've just spent the better part of 2 hours looking through the list archives
and see many posts related to the 2100 series Compaq laptops, but I didn't
see anything related to how I can get ACPI active enough to dump my DSDT
code.  I'm running Mandrake 10, just tried a kernel recompile using an IRQ9
hack, but my laptop still gets a hard lockup upon boot from a 2.6.7
kernel(and 2.6.3, and 2.4.2x).  The only way I can get the laptop to bootup
is using either ACPI=off or ACPI=ht(mandrake default).  Any suggestions?  I
just flashed to the latest and greatest(ha!) bios from compaq and tried
again with no such luck.
</I></FONT></PRE>
</BLOCKQUOTE>
<PRE><TT>try boot with ACPI=on no<FONT COLOR="#a020f0"><B>lapic</TT></B></FONT></PRE>
<BR>
<PRE><TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
Sergio M. B.
</TD>
</TR>
</TABLE>
</PRE>
</BODY>
</HTML>

--=-V4HuAJpOYz9rDRtz2qYE--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
