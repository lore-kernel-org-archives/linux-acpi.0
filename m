From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: Re: PROBLEM: ACPI freezes 2.6.1 on boot
Date: Thu, 22 Jan 2004 11:32:01 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3oesw9sv2.fsf@reason.gnu-hamburg>
References: <Pine.LNX.4.58.0401211051530.2123@home.osdl.org>
	<m3d69dhukz.fsf@reason.gnu-hamburg>
	<1074721887.3672.12.camel@darkstar.portugal>
	<m34qupdj94.fsf@reason.gnu-hamburg>
	<1074727903.3667.49.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1074727903.3667.49.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
 =?iso-8859-15?q?=28S=E9rgio?= Monteiro Basto's message of "21 Jan 2004 23:31:43 +0000")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-15?q?S=E9rgio_Monteiro_Basto?= <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

 || On 21 Jan 2004 23:31:43 +0000
 || S=E9rgio Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org> wrote:=20

 smb> So you are another APIC victim :)

Seems that way. :)


 smb> [...]

 smb> And thinking, can be true ? that, if SCI can't be
 smb> level-triggered (like my laptop and yours), kernel with APIC
 smb> (loapic or smp) options will hang on boot !

But can it really not be level triggered?=20

My dmesg output tells me explicitly that it switched to level
triggered successfully when APIC is disabled.

So is that message wrong or is there a problem between APIC/ACPI?

Should we not be able to resolve that problem anytime soon, I would
suggest to add some information about this to the Kernel help for both
ACPI and APIC, like:

"
 CAUTION:=20
 On some laptops, enabling both local APIC and ACPI can cause
 problems.  Should your system hang during boot with a message like
  'ACPI: IRQ X was Edge Triggered, setting to Level Triggerd'
 you should disable either local APIC (recommended) or ACPI.=20
 See http://bugzilla.kernel.org/show_bug.cgi?id=3D1774 for details.
"

that could save people a lot of time in the future hunting down that
bug again -- also it should limit the amount of mails sent around on
the topic. :)

Regards,
Georg

--=20
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
