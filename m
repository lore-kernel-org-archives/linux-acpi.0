From: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Centrino suspend/resume test result
Date: Wed, 19 May 2004 12:58:57 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <6E0C289723A0564F9A8279E236E8565F076FBC9D@pdsmsx402.pd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Zhu, Yi" <yi.zhu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Machine: Toshiba Satellite M20
Distribution: SuSE SLES9
Kernel: 2.6.5, build ipw2100 as modules

1. ipw2100 module load test ( version-0.41)
Sucessfully load hostap and ipw2100 module. Set static ip addr to eth1.
iwconfig says:
eth1      IEEE 802.11b  ESSID:"linksys"  Nickname:"ipw2100"
          Mode:Managed  Frequency:2.462GHz  Access Point:
00:0C:41:CC:CA:2A =20
          Bit Rate=3D11Mb/s   Tx-Power=3D0 dBm  =20
          Retry:on   RTS thr=3D2304 B   Fragment thr:off
          Encryption key:off
          Power Management:off
          Link Quality:98/100  Signal level:-33 dBm  Noise level:-98 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:52   Missed beacon:2
ifconfig says:
eth1      Link encap:Ethernet  HWaddr 00:04:23:69:DE:18 =20
          inet addr:192.168.1.123  Bcast:192.168.1.255
Mask:255.255.255.0
          inet6 addr: fe80::204:23ff:fe69:de18/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:8 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:2634 (2.5 Kb)  TX bytes:348 (348.0 b)
          Interrupt:10 Base address:0xf000 Memory:e0001000-e0001fff=20

lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:16 errors:0 dropped:0 overruns:0 frame:0
          TX packets:16 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:1040 (1.0 Kb)  TX bytes:1040 (1.0 Kb)

ping is also sucessful.


2.  S3 mode test
Entering S3 mode is sucessful in console, but not in X.
In console after resume, eth0 works normally.
dmesg says:
...
hostap_crypt: registered algorithm 'NULL'
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 0.41
ipw2100: Copyright(c) 2003-2004 Intel Corporation
ipw2100: Compiled with WEP disabled.
Detected ipw2100 PCI device at 0000:01:04.0, dev: eth1, mem:
0xE0001000-0xE0001FFF -> ce96c000, irq: 10
eth1: Using legacy firmware load.
ipw2100: Associated with 'linksys' at 1Mbps, channel 6
eth1: Association lost.
ipw2100: Associated with 'linksys' at 1Mbps, channel 6
eth1: Association lost.
ipw2100: Associated with 'linksys' at 11Mbps, channel 11
eth1: Association lost.
ipw2100: Associated with 'linksys' at 11Mbps, channel 11
eth1: no IPv6 routers present
NET: Registered protocol family 17
eth1: no IPv6 routers present
PM: Preparing system for suspend
Stopping tasks: =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D|
Execute Method: [\_PTS] (Node cdf60a28)
exregion-0294 [270] ex_system_io_space_han: system_iO 0 (32 width)
Address=3D0000000000001000
exregion-0294 [270] ex_system_io_space_han: system_iO 1 (32 width)
Address=3D0000000000001000
exregion-0294 [269] ex_system_io_space_han: system_iO 0 (32 width)
Address=3D0000000000001000
exregion-0294 [270] ex_system_io_space_han: system_iO 1 (32 width)
Address=3D0000000000001028
exregion-0294 [270] ex_system_io_space_han: system_iO 1 (8 width)
Address=3D0000000000000080
exregion-0294 [270] ex_system_io_space_han: system_iO 1 (8 width)
Address=3D00000000000000B3
exregion-0294 [270] ex_system_io_space_han: system_iO 1 (8 width)
Address=3D00000000000000B2
exregion-0184 [269] ex_system_memory_space: system_memory 0 (8 width)
Address=3D000000000DFFFC0A
 acpi_ec-0178 [270] acpi_ec_read          : Read [00] from address [92]
 acpi_ec-0178 [271] acpi_ec_read          : Read [01] from address [b6]
 acpi_ec-0230 [271] acpi_ec_write         : Wrote [01] to address [b6]
exregion-0294 [270] ex_system_io_space_han: system_iO 1 (8 width)
Address=3D00000000000000B3
exregion-0294 [270] ex_system_io_space_han: system_iO 1 (8 width)
Address=3D00000000000000B2
exregion-0294 [270] ex_system_io_space_han: system_iO 1 (8 width)
Address=3D00000000000000B3
exregion-0294 [270] ex_system_io_space_han: system_iO 1 (8 width)
Address=3D00000000000000B2
exregion-0294 [270] ex_system_io_space_han: system_iO 1 (8 width)
Address=3D00000000000000B3
exregion-0294 [270] ex_system_io_space_han: system_iO 1 (8 width)
Address=3D00000000000000B2
PM: Entering state.
 hwsleep-0304 [253] acpi_enter_sleep_state: Entering sleep state [S3]
Back to C!
PM: Finishing up.
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
 pci_irq-0251 [255] acpi_pci_irq_lookup   : Searching for PRT entry for
00:00:1f[B]
 pci_irq-0271 [255] acpi_pci_irq_lookup   : Found IRQ 10
 pci_irq-0383 [254] acpi_pci_irq_enable   : Device 0000:00:1f.6 using
IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
eth1: Using legacy firmware load.
eth1: ipw2100_hw_send_command timed out.
eth1: Failed to start the card.
blk: queue c1360400, I/O limit 4095Mb (mask 0xffffffff)
Execute Method: [\_WAK] (Node cdf608a8)
exregion-0294 [272] ex_system_io_space_han: system_iO 1 (8 width)
Address=3D0000000000000080
Restarting tasks... done
eth1: Hardware fatal error detected.
eth1: Scheduling firmware restart.
ipw2100: eth1: Restarting adapter.
eth1: Using legacy firmware load.
ipw2100: Associated with 'linksys' at 11Mbps, channel 11
MCE: The hardware reports a non fatal, correctable incident occurred on
CPU 0.
Bank 1: f200000000000105

In X after resume, system hangs at "eth1: Using legacy firmware load."
No future action can be taken. Ping from other box failed.

3. S4 mode test
Entering S4 will hang system.
No screen output is captured.
ipw2100 debug says:
.... : Power cycling the hardware
.....:
eth1: Using legacy firmware load.

System hangs after this.

4. WEP not tested

thanks,
-zhen


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
