From: Ulrich Dobramysl <uli-do-RbZlAiThDcE@public.gmane.org>
Subject: Gericom Supersonic - System freeze at startup
Date: Thu, 03 Oct 2002 18:33:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D9C7155.7070709@gmx.at>
Reply-To: uli-NCHUqdhOjCGWIDz0JBNUog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello there!

I have a problem concerning ACPI with my laptop. I've tried several 
Kernels (2.4.16-19, 2.5.40) with several different ACPI patches, but 
everytime I get the same problem, if ACPI is enabled in the kernel 
config. The system freezes at startup right after the line "ACPI 
Namespace succesfully loaded at root c047a05c". The fan slows down or is 
switched off completely, depending on how hot my laptop is (The strange 
thing about this is, that it switches off completely if the CPU is 
rather hot, but when booting the cold system the fan just gets slower).
I need ACPI, because hopefully my IRQ problems (the network and sound 
cards just do not get interrupts) would be resolved, and the fan noise 
is a bit annoying when working several hours.
Can someone please help me?

Uli Dobramysl



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
