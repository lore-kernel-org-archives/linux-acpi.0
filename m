From: Alfonso =?ISO-8859-1?Q?Mu=F1oz-Pomer?= Fuentes <etinarcadiaego-pCzzcW6XgXY@public.gmane.org>
Subject: Re: Bug: Processor support interfering with /dev/eth0
Date: 06 Jun 2003 00:30:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1054852235.599.14.camel@roamer>
References: <Pine.LNX.4.33.0306051052490.663-100000@frog.athome>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-hJJEcFSt9pPd2MTUTu3V"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.33.0306051052490.663-100000-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-hJJEcFSt9pPd2MTUTu3V
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

On Thu, 2003-06-05 at 10:56, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1

Hi, thnanks for the interest...

> Salut Alfonso,
> I am not a developer,... but I would be interssted to see, what
> 
>  cat cat /proc/interrupts
> 

I have attached a couple of files. The 'interrupts' file is the output
from 'cat /proc/interrupts' and I've also included the output of 'cat
/proc/pci' in 'pci'. I've read some doc from the ACPI website and I've
seen that sometimes there are conflicting devices on the same IRQ, or at
least that's what I got to understand. In my case it seems that the same
IRQ is used by the FireWire interface, but I haven't got it compiled. If
I do, as the driver is still experimental, whenever there's some network
traffic (at boot up when getting an IP address from my DHCP server) it
produces an awful lot of error messages and it goes havoc. I've included
a sample in the file 'ieee1394'. Maybe this can be helpful. However,
what I don't understand is why if I unload the processor module there is
no problem at all. I still believe that there must be something else
going on.

> will say, in both cases. And what acpi-support did you use? The acpi that
> comes with the kernel, or a developping version?

So far I have tried 2.4.20 with ACPI patch, 2.4.21-rc3 with ACPI patch,
2.4.21-rc7 with Alan Cox patch (it includes ACPI) and 2.5.70 with Alan
Cox patch. All of them have this same bug. Not different at all.

> On 5 Jun 2003, Alfonso Muñoz-Pomer Fuentes wrote:
> > I'm forwarding this message that I sent to acpi-sppt because I believe
> > it's a bug. Feedback greatly appreciated.
> 
> regards
>   hartwig felger
> 
> Hartwig Felger informatics

Cheers.

-- 
Alfonso Muñoz-Pomer Fuentes <etinarcadiaego-pCzzcW6XgXY@public.gmane.org>

--=-hJJEcFSt9pPd2MTUTu3V
Content-Disposition: attachment; filename=interrupts
Content-Type: text/plain; name=interrupts; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

           CPU0       
  0:    1700185          XT-PIC  timer
  1:       9961          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       7659          XT-PIC  usb-ohci
  6:          0          XT-PIC  Texas Instruments PCI1410 PC card Cardbus Controller
  7:       6321          XT-PIC  eth0
  9:       1355          XT-PIC  acpi
 11:          5          XT-PIC  ALi Audio Accelerator, Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support
 12:       1047          XT-PIC  PS/2 Mouse
 14:     138288          XT-PIC  ide0
 15:         20          XT-PIC  ide1
NMI:          0 
ERR:          0

--=-hJJEcFSt9pPd2MTUTu3V
Content-Disposition: attachment; filename=pci
Content-Type: text/plain; name=pci; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: ALi Corporation M1644/M1644T Northbridge+Trident (rev 1).
      Prefetchable 32 bit memory at 0xf0000000 [0xf3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: ALi Corporation PCI to AGP Controller (rev 0).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   2, function  0:
    USB Controller: ALi Corporation USB 1.1 Controller (rev 3).
      IRQ 5.
      Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xf7eff000 [0xf7efffff].
  Bus  0, device   4, function  0:
    IDE interface: ALi Corporation M5229 IDE (rev 195).
      IRQ 255.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=4.
      I/O at 0xeff0 [0xefff].
  Bus  0, device   6, function  0:
    Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=24.
      I/O at 0x1000 [0x10ff].
      Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
  Bus  0, device   7, function  0:
    ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV] (rev 0).
  Bus  0, device   8, function  0:
    Bridge: ALi Corporation M7101 PMU (rev 0).
  Bus  0, device  10, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 16).
      IRQ 7.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xed00 [0xedff].
      Non-prefetchable 32 bit memory at 0xf7efef00 [0xf7efefff].
  Bus  0, device  12, function  0:
    FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (rev 0).
      IRQ 7.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=4.
      Non-prefetchable 32 bit memory at 0x10001000 [0x100017ff].
      Non-prefetchable 32 bit memory at 0x10004000 [0x10007fff].
  Bus  0, device  16, function  0:
    CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 1).
      IRQ 6.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0x10002000 [0x10002fff].
  Bus  0, device  17, function  0:
    CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 51).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=128.Max Lat=5.
      Non-prefetchable 32 bit memory at 0x10003000 [0x10003fff].
  Bus  0, device  18, function  0:
    System peripheral: Toshiba America Info Systems SD TypA Controller (rev 5).
      IRQ 11.
      Non-prefetchable 32 bit memory at 0x10001800 [0x100019ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Trident Microsystems CyberBlade XPAi1 (rev 130).
      IRQ 6.
      Master Capable.  Latency=8.  
      Non-prefetchable 32 bit memory at 0xfc000000 [0xfdffffff].
      Non-prefetchable 32 bit memory at 0xfbc00000 [0xfbffffff].
      Non-prefetchable 32 bit memory at 0xf8000000 [0xf9ffffff].
      Non-prefetchable 32 bit memory at 0xf7ff8000 [0xf7ffffff].

--=-hJJEcFSt9pPd2MTUTu3V
Content-Disposition: attachment; filename=ieee1394
Content-Type: text/plain; name=ieee1394; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Jun  5 19:53:03 roamer kernel: ohci1394_0: Unrecoverable error!
Jun  5 19:53:03 roamer kernel: ohci1394_0: Async Req Tx Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Async Rsp Tx Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Async Req Rcv Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Async Rsp Rcv Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 0 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 1 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 2 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 3 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 4 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 5 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 6 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 7 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 8 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 9 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 10 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 11 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 12 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 13 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 14 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 15 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 16 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 17 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 18 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 19 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 20 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 21 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 22 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 23 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 24 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 25 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 26 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 27 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 28 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 29 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 30 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 31 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 0 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 1 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 2 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 3 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 4 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 5 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 6 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 7 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 8 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 9 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 10 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 11 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 12 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 13 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 14 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 15 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 16 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 17 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 18 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 19 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 20 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 21 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 22 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 23 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 24 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 25 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 26 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 27 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 28 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 29 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 30 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 31 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Runaway loop while stopping context: ...
Jun  5 19:53:03 roamer kernel: ohci1394_0: Runaway loop while stopping context: ...
Jun  5 19:53:03 roamer kernel: ohci1394_0: Runaway loop while stopping context: reqTxComplete...
Jun  5 19:53:03 roamer kernel: ohci1394_0: Runaway loop while stopping context: respTxComplete...
Jun  5 19:53:03 roamer kernel: ohci1394_0: Runaway loop while stopping context: RQPkt...
Jun  5 19:53:03 roamer kernel: ohci1394_0: Runaway loop while stopping context: RSPkt...
Jun  5 19:53:03 roamer kernel: ohci1394_0: Error in reception of SelfID packets [0xffffffff/0x00000000] (count: 1)
Jun  5 19:53:03 roamer kernel: ohci1394_0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Unhandled interrupt(s) 0xfe7cff0c
Jun  5 19:53:03 roamer kernel: ohci1394_0: Unrecoverable error!
Jun  5 19:53:03 roamer kernel: ohci1394_0: Async Req Tx Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Async Rsp Tx Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Async Req Rcv Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Async Rsp Rcv Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 0 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 1 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 2 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 3 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 4 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 5 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 6 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 7 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 8 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 9 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 10 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 11 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 12 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 13 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 14 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 15 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 16 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 17 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 18 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 19 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 20 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 21 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 22 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 23 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 24 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 25 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 26 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 27 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 28 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 29 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 30 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Xmit 31 Context died: ctrl[ffffffff] cmdptr[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 0 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 1 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 2 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 3 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 4 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 5 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 6 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 7 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 8 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 9 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 10 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 11 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 12 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 13 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 14 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 15 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 16 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 17 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 18 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 19 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 20 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 21 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 22 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 23 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 24 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 25 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 26 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 27 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 28 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 29 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 30 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Iso Recv 31 Context died: ctrl[ffffffff] cmdptr[ffffffff] match[ffffffff]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Runaway loop while stopping context: ...
Jun  5 19:53:03 roamer kernel: ohci1394_0: Runaway loop while stopping context: ...
Jun  5 19:53:03 roamer kernel: ohci1394_0: Runaway loop while stopping context: reqTxComplete...
Jun  5 19:53:03 roamer kernel: ohci1394_0: Runaway loop while stopping context: respTxComplete...
Jun  5 19:53:03 roamer kernel: ohci1394_0: Runaway loop while stopping context: RQPkt...
Jun  5 19:53:03 roamer kernel: ohci1394_0: Runaway loop while stopping context: RSPkt...
Jun  5 19:53:03 roamer kernel: ohci1394_0: Error in reception of SelfID packets [0xffffffff/0x00000000] (count: 2)
Jun  5 19:53:03 roamer kernel: ohci1394_0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
Jun  5 19:53:03 roamer kernel: ohci1394_0: Unhandled interrupt(s) 0xfe7cff0c

--=-hJJEcFSt9pPd2MTUTu3V--



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
