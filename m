From: "DPR" <info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org>
Subject: RE: APIC, USB mouse and errors
Date: Thu, 27 Feb 2003 16:22:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000001c2de74$0ffac320$0200a8c0@brutzler>
References: <C50AB9511EE59B49B2A503CB7AE1ABD10476BF94@cceexc19.americas.cpqcorp.net>
Reply-To: <info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C50AB9511EE59B49B2A503CB7AE1ABD10476BF94-Iar2LzuD2f6P0FQRY6S+e9kSKC0Mw0DFJ8am2ALHCgk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'Cagle, John (ISS-Houston)'" <john.cagle-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Here we go ...

- interrupt table with enabled APIC (no special kernel params)

           CPU0       
  0:       9480    IO-APIC-edge  timer
  1:        257    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          2    IO-APIC-edge  rtc
  9:          0    IO-APIC-edge  acpi
 10:          0    IO-APIC-edge  usb-uhci
 11:          0    IO-APIC-edge  eth0, usb-uhci
 12:          9    IO-APIC-edge  usb-uhci
 14:          0    IO-APIC-edge  ehci-hcd
 15:        122    IO-APIC-edge  ide2
 16:        806   IO-APIC-level  nvidia
 17:       6480   IO-APIC-level  ide0, ide1
NMI:          0 
LOC:       9434 
ERR:          0
MIS:          0

- and with "noapic" parameter

           CPU0       
  0:       7376          XT-PIC  timer
  1:        228          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:         13          XT-PIC  usb-uhci
 11:        340          XT-PIC  eth0, usb-uhci
 12:          0          XT-PIC  usb-uhci
 14:          0          XT-PIC  ehci-hcd
 15:        123          XT-PIC  ide2
 16:        360   IO-APIC-level  nvidia
 17:       6473   IO-APIC-level  ide0, ide1
NMI:          0 
LOC:       7340 
ERR:       7316
MIS:          0

Regards,

HOLGER

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of 
> Cagle, John (ISS-Houston)
> Sent: Thursday, February 27, 2003 2:39 PM
> To: info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org; acpi-devel@lists.sourceforge.net
> Subject: RE: [ACPI] APIC, USB mouse and errors
> 
> 
> What does 'cat /proc/interrupts' show when your running this 
> new kernel?
> 
> Regards,
> John
> --------------------------------
> John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
> Principal Member Technical Staff
>    Industry Standard Servers
>     Hewlett-Packard Company
>     http://www.hp.com/linux
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
