From: <joerg.beyer-htSm2yLGOjU@public.gmane.org>
Subject: trouble with medion 9788 DE notebook
Date: Tue, 20 Aug 2002 20:22:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208201822.g7KIMYX01424@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have a medion 9877 DE notebook, which is a Athon 1.Ghz machine, simmilar=
 to=20
this onhttp://rguerin.free.fr/medion/ .

without your acpi patch I cant use the nic. I understand that this is not =
a problem with the
nic, but a problem with the IRQs. Ok I used several versions of your patch=
es, e.g.
acpi-20020815-2.4.20-pre3.diff.gz with the respective linux kernel. I stil=
l get =5Fa=5Flot=5F
errors on the network interface, and also disk access is =5Fvery=5F slow. It t=
akes minutes
to untar something like the linux kernel tarball.

This is what lspci tells about the machine:
linux:/home/joerg # lspci=20
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev=
 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:06.0 Communication controller: Ambient Technologies Inc: Unknown device=
 4000 (rev 02)
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (=
rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (r=
ev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Con=
troller (rev 50)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev=
 10)
00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d02 (rev 01)

and these are the errors I have on the nic.

linux:/home/joerg # ifconfig eth0
eth0      Protokoll:Ethernet  Hardware Adresse 00:07:CA:00:AC:A3 =20
          inet Adresse:10.0.0.30  Bcast:10.255.255.255  Maske:255.0.0.0
          UP BROADCAST NOTRAILERS RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3584 errors:26602 dropped:730 overruns:26602 frame:0
          TX packets:3564 errors:0 dropped:0 overruns:0 carrier:0
          Kollisionen:0 Sendewarteschlangenl=E4nge:100=20
          RX bytes:5169122 (4.9 Mb)  TX bytes:268991 (262.6 Kb)
          Interrupt:10 Basisadresse:0x1000=20


/var/log/messages tells me, this:

Aug 20 22:05:52 linux kernel: eth0: Too much work at interrupt, IntrStatus=
=3D0x0040.
Aug 20 22:06:23 linux last message repeated 8 times
Aug 20 22:07:24 linux last message repeated 571 times
Aug 20 22:08:25 linux last message repeated 558 times
Aug 20 22:08:45 linux last message repeated 190 times


Does anybody has an idea/suggestion hwo to fix this=3F

    TIA
    Joerg




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
