From: Kevin Verma <kevinverma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: broken acpi support for battery 2.6.14
Date: Sun, 13 Nov 2005 15:34:31 +0530
Message-ID: <baf307070511130204h31c7f6bfv35067ce4c53fd868@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I am continuesly noticing that the battery status being shown as NA
and it is not possible to see the charge remaining via "Gnome battery
charge monitor" while the output from /proc FS  and dmesg are as below
:
--------------------
[root@localhost /]# cat /proc/acpi/battery/BAT0/info
present:                 yes
ERROR: Unable to read battery information
--------------------
[root@localhost /]# cat /proc/acpi/battery/BAT0/alarm
alarm:                   1206 mWh
--------------------
[root@localhost /]# cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          charging
present rate:            2138 mW
remaining capacity:      22420 mWh
present voltage:         12508 mV
--------------------
dmesg :

    ACPI-0292: *** Error: Looking up [SERN] in namespace, AE_ALREADY_EXISTS
    ACPI-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.GBIF] (Node c145e9e0), AE_ALREADY_EXISTS
application nt uses obsolete OSS audio interface
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c145d8a0), AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c145d8a0), AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c145d8a0), AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c145d8a0), AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c145d8a0), AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c145d8a0), AE_AML_METHOD_LIMIT
    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
    ACPI-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c145d8a0), AE_AML_METHOD_LIMIT
----------------------
Any possible outlook, if there are any bad effects on the hardware
while this problem remains unsolved ?


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
