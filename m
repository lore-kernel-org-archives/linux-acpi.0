From: Marius Oancea <mariuso-db4prxYhZ5Fhl2p70BpVqQ@public.gmane.org>
Subject: ACPI 20020829 and kernel 2.4.19-4GB #1 Fri Sep 13 13:14:56 UTC 2002
 i686 on Gericom Supersonic M6T
Date: Fri, 22 Nov 2002 12:22:04 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DDE91EC.2090207@sec.co.ro>
Reply-To: mariuso-QShcZ35DvxU@public.gmane.org
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi, I have an Gericom M6T and I just installed SuSE 8.1.

If u add pci=acpi to the bootparam, acpi is working nearly acceptable :
 - acpi events are not raported anymore
 - when i start /stop acpid (at the time of acpi modules insertion) the 
complete system crash

I tried  to compile a original 2.4.19  kernel (from kernel.org) and 
patch this kernel with acpi-20020918-2.4.19.diff.

After that, acpi is working very well, but ... I don't have the exotic 
features of SuSE anymore (PCMCIA driver is not the last one and is not 
stable enough, SuSE hardware autodetection is not working too .... , 
grub, orinocco wireless card neither).

So, hopefully  somebody in this list has a patch for the SuSE 8.1 
kernel. The most stable acpi for Gericom Supersonic M6T is acpi-20020918.

Should I address this question to another list ?

If yes, on wich list ?

    With all my respect
        Marius OANCEA




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
