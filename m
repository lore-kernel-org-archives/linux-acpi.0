From: stef <svoltz-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
Subject: Re: Wrong button event reported when waking up from S1
Date: Wed, 16 Apr 2003 22:03:16 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030416220316.GA657@wanadoo.fr>
References: <3ACA40606221794F80A5670F0AF15F8427228F@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8427228F-4yWAQGcml64gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: stef <stef-listes-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 16, 2003 at 02:42:17PM +0800, Yu, Luming wrote:
> Give me 
> 1)	boot log
> 2)	/proc/acpi/dsdt
> 3)	lspci -v
> 4)	/proc/interrupts
> 5)	the machine name, motherboard name ..,
> 
> Thanks,
> Luming
> 

	Hello,

1+2)	here's boot log (with a S1/wake up event) and raw dsdt

3)
00:00.0 Host bridge: ALi Corporation M1647 Northbridge [MAGiK 1 / MobileMAGiK 1] (rev 04)
00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:04.0 CardBus bridge: Texas Instruments PCI1420
00:04.1 CardBus bridge: Texas Instruments PCI1420
00:06.0 Bridge: ALi Corporation M7101 PMU
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
00:08.1 Communication controller: ESS Technology ESS Modem (rev 12)
00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:10.0 Ethernet controller: Accton Technology Corporation EN-1216 Ethernet Adapter (rev 11)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/XP (rev 63)

4)
           CPU0       
  0:     392759          XT-PIC  timer
  1:       2635          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          2          XT-PIC  Allegro
  8:          3          XT-PIC  rtc
  9:         17          XT-PIC  acpi
 11:      13899          XT-PIC  Texas Instruments PCI1420, Texas Instruments PCI1420 (#2), eth0
 12:      23861          XT-PIC  PS/2 Mouse
 14:       8222          XT-PIC  ide0
 15:         35          XT-PIC  ide1
NMI:          0 
LOC:     392566 
ERR:       5346
MIS:          0

5) It's an HP Pavilion Notebook Model GD, model number N5441


	I also discovered that while in S0, the "multimedia keys" close to
power and sleep buttons do not send any event, but can be used to wake up the
notebook and all send PWRF events.

Regards,
	Stef

--Q68bSM7Ycu6FN28Q
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="dsdt.gz"
Content-Transfer-Encoding: base64

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
5DvJ/x8rX5RO8iIAAA==

--Q68bSM7Ycu6FN28Q
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="dmesg.gz"
Content-Transfer-Encoding: base64

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
azDtP12D+WdrmL6k4X8Avz1yrmUpAAA=

--Q68bSM7Ycu6FN28Q--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
