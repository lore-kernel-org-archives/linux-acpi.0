From: "Matthew Tippett" <matthew-+XluyfkzffvQT0dZR+AlfA@public.gmane.org>
Subject: IO Input based on DSDT
Date: Fri, 20 Dec 2002 08:45:08 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E031EE4.5010102@casero.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
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

A quick question...

Based on the DSDT, is it possible to write userland applications that 
interrogate the same ports as the DSDT?  For example, the battery 
information method _BIF calls the BIF_ which is the following code.

Arg0 is the battery index.

         SX10()
         SX30(0x1)
         SX30(Arg0)
         SX11()
         Store(SX42(), Index(BIFP, 0x0, ))
         Store(SX42(), Index(BIFP, 0x1, ))
         Store(SX42(), Index(BIFP, 0x2, ))
         Store(SX42(), Index(BIFP, 0x3, ))
         Store(SX42(), Index(BIFP, 0x4, ))
         Store(SX42(), Index(BIFP, 0x5, ))
         Store(SX42(), Index(BIFP, 0x6, ))
         Store(SX42(), Index(BIFP, 0x7, ))
         Store(SX42(), Index(BIFP, 0x8, ))
         Store(SX45(), Index(BIFP, 0x9, ))
         Store(SX45(), Index(BIFP, 0xa, ))
         Store(SX45(), Index(BIFP, 0xb, ))
         Store(SX45(), Index(BIFP, 0xc, ))
         SX12()
         Return(BIFP)

Which is fairly obviously a 'configure', 'read', 'set structure',
'return'.

The question I have is that by digging deep enough into the call graph 
will I end up with a set of ports that would allow me to extract the 
data that I want, so that I can then rebuild a working DSDT.

And by extension, could I take some actions that occur on ports, and 
then look at making those available via ACPI?  (Such as fan control 
which is ignored in the Dell i8200 DSDT).

Regards,

Matt

-- 
Matthew Tippett - matthew.tippett-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org - (416) 435-4118
Technology Forum - http://www.technology-forum.org/
Commercial Open Source - http://www.commercialos.org/


-----

The information contained in this message is proprietary of Casero Inc.,
protected from disclosure, and may be privileged. The information is
intended to be conveyed only to the designated recipient(s) of the
message. If the reader of this message is not the intended recipient,
you are hereby notified that any dissemination, use, distribution or
copying of this communication is strictly prohibited and may be
unlawful. If you have received this communication in error, please
notify us immediately by replying to the message and deleting it from
your computer. Thank you.



-------------------------------------------------------
This SF.NET email is sponsored by:  The Best Geek Holiday Gifts!
Time is running out!  Thinkgeek.com has the coolest gifts for
your favorite geek.   Let your fingers do the typing.   Visit Now.
T H I N K G E E K . C O M        http://www.thinkgeek.com/sf/
