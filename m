From: Matthew Harrell <lists-sender-12e533-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org>
Subject: Re: Re: odd irq routing errors?
Date: Fri, 14 Mar 2003 08:34:46 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030314133446.GA546@bittwiddlers.com>
References: <20030313221321.GA21296@bittwiddlers.com>
 <20030314103049.GB19277@clara.net>
Reply-To: Matthew Harrell <mharrell-dated-1048080890.82da7a-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_44MbdCBMvW8NG3hdSIyVCQ)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030314103049.GB19277-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary_(ID_44MbdCBMvW8NG3hdSIyVCQ)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

: > : > PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255
: 
: The message is (mis)informational rather than destructive for me.

BTW, when I tried some of your suggestions I saw that I was, in fact, getting
the exact same error message.  I was never able to see it before since the 
laptop became totally unuseable.  

: Try removing acpid from your startup scripts before booting into 2.5.6x
: then check your /proc/interrupts and see if there are a large number
: being generated quickly.

Not sure what a large number really is anymore since I haven't really watched
it in a long time.  Once I removed acpid from the startup it then died on 
starting alsa but when I booted it into single user mode I saw the message
about pci=noacpi.  So, I am now operating under it with acpi on, pci=noacpi,
and no acpid.  If I turn on acpid it hangs the system again so this is kind of
a pointless configuration to run in.  I don't see an unusual amount of
interrupts in this state except on timer and I assume that is normal

             CPU0
    0:     405906          XT-PIC  timer
    1:         14          XT-PIC  i8042
    2:          0          XT-PIC  cascade
    8:          4          XT-PIC  rtc
    9:        740          XT-PIC  acpi, VIA8233
   10:      17175          XT-PIC  uhci-hcd, eth0
   11:         25          XT-PIC  eth1
   12:         35          XT-PIC  i8042
   14:       8644          XT-PIC  ide0
   15:          1          XT-PIC  ide1
  NMI:          0
  LOC:          0
  ERR:          0
  MIS:          0


: This could cause laptop slowdown and perhaps overheating which can
: introduce instability.  It's a known problem that I've seen
: mentioned on the list.  I expect that the developers will need much more
: information from you if they are to help.

If anyone would like to look into it just let me know what info I can provide.
I can work like this for a while but it's not optimal - 50% of the time I don't
have pcmcia support on bootup like this (and don't really need it) and 50%
of the time I don't have USB.  

Boot messages are attached below

-- 
  Matthew Harrell                          Any sufficiently advanced technology
  Bit Twiddlers, Inc.                       is indistinguishable from a rigged
  mharrell-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org                 demo.

--Boundary_(ID_44MbdCBMvW8NG3hdSIyVCQ)
Content-type: application/octet-stream; NAME=boot.log.bz2
Content-transfer-encoding: base64
Content-disposition: attachment; filename=boot.log.bz2

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
Rx2bJqnGPP0paAXzLoQXD0h/EXckU4UJAsNFuDA=

--Boundary_(ID_44MbdCBMvW8NG3hdSIyVCQ)--


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
