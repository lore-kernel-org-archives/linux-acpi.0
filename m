From: "Black, Richard" <Richard.Black-VXdhtT5mjnY@public.gmane.org>
Subject: Problem with Compaq Presario 27xx
Date: Thu, 1 Aug 2002 17:49:05 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D8C1802AADD0D346BE5C0A1D117075CC02C1C860@cceexc17.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>FROM: Troy SchultzDATE: 06/16/2002 05:23:35SUBJECT:  RE [ACPI] Problem =
with Compaq Presario 27XX The Compaq 2700 series notebooks have buggy =
DSDTs and need to have
several changes made.  Even with these changes there still seems to be a
small issue with battery detection if powered using AC.

>>Send me a copy of your /proc/acpi/dsdt file and I can compare it to =
the
ones I have archived.  I have fixed DSDTs for several 2700 series
notebooks and would be happy to provide you with a "fixed" version.

>>I am running a Compaq Presario 2710CA with kernel 2.4.18 and ACPI
20020404.  I have not tried the newer versions since my system is
working quite well and I am waiting for a version now that fully handles
S3 suspend.  However it looks like this may not be possible with the 2.4
kernel series without significant other changes.

>>- Troy


Where do I go to find out what fixes I need in my dsdt table?
I have it posted at http://www.cpqlinux.com/Pres2701_dsdt.tgz if anyone =
wants to look at it.

Here's my current status:

Compaq Presario 2701US
kernel 2.4.18 + acpi-20020726 + kacpid

I can proceed through the following steps just fine

cat /proc/acpi/dsdt > dsdt.dat
cat dsdt.dat | acpidisasm > dsdt.asl    (intel's pmtools)

When the above command finishes my dsdt.asl contains the hex indicators =
on the left hand side.  Is this correct?:

00000000: OpRegion DBG_ (\DBG_)
00000006:   SystemIO
00000007:   0x80
00000009:   0x01
0000000b: Field
0000000e:   DBG_ (00000000)
00000012:   AccessType: ByteAcc; LockRule: NoLock; UpdateRule: Preserve
00000013:   NamedField DEBG
00000018: Scope _PR_ (\_PR_)
00000020:   Processor CPU0 (\_PR_.CPU0)
00000028:     0x00
00000029:     0x00001010
0000002d:     0x06
0000002e:     Method _CST (\_PR_.CPU0._CST)
...

I can remove off the hex portion with the command

cat old | sed -e 's,^..........,,' > new

but I'm not sure if that's what I really need to do.


What fix do I need so that I can proceed to repack my dsdt table?


Sincerely,
Richard Black
http://www.cpqlinux.com
http://www.geocities.com/rlcomp_1999
http://www.compaq.com/linux

Reference sites
http://www.geocrawler.com/archives/3/17428/2002/6/100/8962779/
http://dude.noc.clara.net/~faye/
kacpid site: http://www.pps.jussieu.fr/~jch/software/presario/
the kacpid patch causes the kernel to periodically check for lost ACPI =
interrupts.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
