From: tho-NfGIfjByo2U0TNoGDjcNAsJftPPqhGjr@public.gmane.org
Subject: Linux kernel 2.5.40 (+acpi patch 20021002) hangs at boot
Date: Wed, 02 Oct 2002 16:29:07 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E17wsvU-00029x-00@doma.ballum>
Reply-To: gthomsen-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I just tried the Linux kernel 2.5.40 on my IBM ThinkPad X22 (2662XXK
with BIOS v1.12), but it locks solid (not even CAD helps) just after
PNPBIOS messages were printed. At first I suspected the PNPBIOS to
cause that problem, but the boot argument 'pnpbios=off' only caused
the message 'pnpbios: disabled' to be printed. The machine hung then
nevertheless. I got the same results with the acpi patch for 2.5.40
of 20021002.

Thought you might be interested.

Let me know, what kind of other information I could provide.

cheers
	Guenther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
