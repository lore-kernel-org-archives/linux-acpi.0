From: Malte Doersam <malte.d-hi6Y0CQ0nG0@public.gmane.org>
Subject: ACPI Sleep gone in 2.5.66? And is my Bios Windows only?
Date: Thu, 17 Apr 2003 16:37:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200304171637.19390.malte.d@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Yu-w7oI5at0b/4@public.gmane.org, Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi everybody,

I have a Thinkpad R31 which has some really annoying APM bugs, so I just tried 
ACPI:

Using 2.4.21-pre3 [1] I got almost everything working when I used pci=noacpi 
as a kernel argument. Even Sleep worked, though the onboard e100 didn't wake 
up. (Using the Intel driver or the "original" kernel driver didn't matter.) 
Here is my dmesg [2] and my dsdt [3].

I tried 2.5.66 [4] and hoped, that the pci=noacpi would not be necessary 
anymore. But all of a sudden the /proc/acpi/sleep isn't there anymore, which 
is pitty. My dmesg [5] and my dsdt [6] for 2.5.66.

I modified my DSDT as described here: 
http://home.fhtw-berlin.de/~s0502837/r31/

What I asked myself, studying my DSDT: could it be, that certain features only 
work with MS operating systems?


--snip--
        If (LEqual (Arg0, 0x04))
        {
            If (OSCP (\_OS, "Microsoft Windows"))
            {
                Store (0x00, OSTP)
            }
            Else
            {
                If (OSCP (\_OS, "Microsoft Windows NT"))
                {
                    Store (0x01, OSTP)
                }
                Else
                {
                    If (OSCP (\_OS, "Microsoft WindowsME: Millennium 
Edition"))
                    {
                        Store (0x02, OSTP)
                    }
                    Else
                    {
                        Store (0x07, OSTP)
                    }
                }
            }
--snap--

So I tried modifying the Else to Store (0x00, OSTP) but it didn't change 
anything.


Questions over questions, maybe someone can bring some light into this... :-)

cheers Malte

[1] http://home.fhtw-berlin.de/~s0502837/linux.kernel/2.4.21-pre3.config
[2] http://home.fhtw-berlin.de/~s0502837/linux.kernel/2.4.21-pre3.dmesg
[3] http://home.fhtw-berlin.de/~s0502837/linux.kernel/2.4.21-pre3.dsdt
[4] http://home.fhtw-berlin.de/~s0502837/linux.kernel/2.5.66.config
[5] http://home.fhtw-berlin.de/~s0502837/linux.kernel/2.5.66.dmesg
[6] http://home.fhtw-berlin.de/~s0502837/linux.kernel/2.5.66.dsdt


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
