From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: What's up with the Embedded Controller driver? [was
 Re: [ACPI] patched sms-cm acpi/ec.c to 2.6.11.5]
Date: Tue, 29 Mar 2005 09:50:25 -0500
Message-ID: <42496B31.5010408@bartol.udel.edu>
References: <3ACA40606221794F80A5670F0AF15F8407923522@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8407923522@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>, ACPI devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Yu, Luming wrote:
> You modified DSDT just remove some AML methods that related to EC.
> That means it just delete the problem. 
> I believe if you think this is the regression, just because the changeset
> http://linux-acpi.bkbits.net:8080/26-latest-test/diffs/include/acpi/acconfig.h@1.55?nav=index.html|src/.|src/include|src/include/acpi|hist/include/acpi/acconfig.h
> make _those AML methods just run.
> So, this is NOT a regression problem.
> 
> Please cat /proc/interrupts to me before accessing EC and after accessing EC.(using burst mode EC patch)
> 

Hi Yuming --

I'm using your ec patch, plus a DSDT modified using my sbs-cm package
(which accesses the Smart Battery system through the EC address space
handler). Here's what happens to the interrupts when I access the battery:

rhdt@sto ~ $ cat /proc/interrupts
           CPU0
  0:  127116981          XT-PIC  timer
  1:     213426          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  6:     171382          XT-PIC  i915@pci:0000:00:02.0, uhci_hcd,
uhci_hcd, uhci_hcd, eth1
  8:          8          XT-PIC  rtc
  9:    3305062          XT-PIC  acpi
 10:    1965890          XT-PIC  Intel 82801DB-ICH4, yenta, ehci_hcd,
ipw2200
 12:    4335843          XT-PIC  i8042
 14:     466033          XT-PIC  ide0
 15:         28          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
rhdt@sto ~ $ cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mA
remaining capacity:      4081 mAh
present voltage:         16699 mV
rhdt@sto ~ $ cat /proc/interrupts
           CPU0
  0:  127131974          XT-PIC  timer
  1:     213488          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  6:     171462          XT-PIC  i915@pci:0000:00:02.0, uhci_hcd,
uhci_hcd, uhci_hcd, eth1
  8:          8          XT-PIC  rtc
  9:    3305297          XT-PIC  acpi
 10:    1966133          XT-PIC  Intel 82801DB-ICH4, yenta, ehci_hcd,
ipw2200
 12:    4335843          XT-PIC  i8042
 14:     466065          XT-PIC  ide0
 15:         28          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0

Note that the battery access took over 5 seconds! And note, of course,
the big jump in the acpi interrupt count.

cheers,

Rich


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
