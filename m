From: Paolo Costa <paolo.costa-hl5o88x/ua9eoWH0uzbU5w@public.gmane.org>
Subject: ACPI and network problems in KDE on travelmate 800
Date: Tue, 29 Apr 2003 20:24:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EAEC363.5090901@polimi.it>
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

Hi,

i'm running an "unstable" debian with kde 3.1.1 on a travelmate 803 
equipped with Intel Centrino and BroadComm network card (using module 
bcm4400). I download from kernel.org the tarball of kernel 2.4.20 and 
patched it with acpi-2.4.20, enabling all options but Cpu ENumearation 
only, Toshiba Laptop Extras and Debug statements. I install also acpi 
and acpi daemon(acpid)

After rebooting, everything works fine, i could see files in /proc/acpi 
and values seem to be right. Moreover, I was able to power down the 
notebook via software. Also the network card has no trouble, at least if 
I use it in console. But if I try to use it under KDE, e.g. with 
konqueror, kmail or mozilla, it stops working at all (also in console 
mode) and the following message appears repeatly on consoles:

NETDEV WATCHDOG: eth0 timed out

Note that if I simply login in KDE without invoking konqueror, the 
network card (in console) works great but as soon as I use it inside kde 
it crashes.

If i reboot with a previous unpatched kernel everythings gets right but 
of course with no ACPI support :((

Have you got any suggestions ?

Thanks in advance

Paolo



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
