From: Z F <mail4me9999-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Latitude X300 problem
Date: Mon, 14 Jun 2004 19:46:27 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040615024627.83008.qmail@web20412.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello everybody,

I am trying to configure ACPI to work on my Dell Latitude X300
notebook.
I think I followed the instructions from
http://www.cpqlinux.com/acpi-howto.html

on how to obtain DSDT and how to compile it into the kernel.

Accodring to http://acpi.sourceforge.net/dsdt/view.php someone 
has posted a fixed DSDT for this computer model.

So I disassembled my dsdt to get SystemMemory (as I do not know how to
compute these numbers from the amount of physical memory) and edited
the dstd.asl for the BIOS version I have (A06).

After the compilation onto the kernel and rebooting I get the attached
messages. Basically, this means that almost everything does not work.
I can change cpu throttling and see the sate of the fan (it is always
on).
THe compilation of dsdt.asl with iasl produces no errors and no
warnings.


Could someone tell me how to debug this. I know very little about ACPI
but am willing to learn... :-)

Thank you very much for your kind help

Lazar


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
