From: AnonimoVeneziano <voloterreno-nc/lrvXPQ4s@public.gmane.org>
Subject: ACPI + IO-APIC power off by button problems
Date: Sun, 02 Mar 2003 19:53:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E62533A.7050505@tin.it>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi, I have this configuration:

MSI KT4 Ultra MoBo
Athlon XP 2400+
Matrox G450

and this problem: with kernel 2.4.20 and without ACPI patch installed 
and IO-APIC support activated the system does not shutdown properly, and 
it reboots instead of turn off and if I try to turn off the PC by 
pressing the power off button it does nothing, as if I've never pressed it

Using instead the kernel 2.4.21-pre4 + lastest ACPI patch I've solved 
the power down issue , and now the system shutdown properly , but the 
button does not work again . Without IO-APIC the button works correctly. 
There are some incompatibilities between the PowerButton and the IO-APIC?

I've noticed this problem in my old mobo too, an ASUS CUV4X-EA

Thanks

Bye



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
