From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Re: Re: [PATCH] Don't disable interrupts during EC access
Date: Wed, 17 Nov 2004 13:59:11 +0100
Message-ID: <20041117125911.GA25745@message-id.gmane0305.slipkontur.de>
References: <3ACA40606221794F80A5670F0AF15F84041AC095@pdsmsx403>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC095@pdsmsx403>
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


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 17, 2004 at 08:02:49PM +0800, Yu, Luming wrote:
> I didn't find DSDT on acpi.sf.net,
> could you share it with me?

it is attached
 
> BTW, When you poll battery info,
> please cat /proc/interrupts to me.

e239:~ # cat /proc/interrupts ; cat /proc/acpi/battery/BAT0/info > /dev/null ; cat /proc/interrupts
           CPU0
  0:  259010928          XT-PIC  timer
  1:       2513          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  7:    2782492          XT-PIC  Intel 82801DB-ICH4
  9:         14          XT-PIC  acpi
 11:   24077232          XT-PIC  uhci_hcd, uhci_hcd, uhci_hcd, ehci_hcd, yenta, yenta, eth0, radeon@pci:0000:01:00.0
 12:      92120          XT-PIC  i8042
 14:     805416          XT-PIC  ide0
 15:    1932859          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
MIS:          0
           CPU0
  0:  259011120          XT-PIC  timer
  1:       2513          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  7:    2782494          XT-PIC  Intel 82801DB-ICH4
  9:         14          XT-PIC  acpi
 11:   24077251          XT-PIC  uhci_hcd, uhci_hcd, uhci_hcd, ehci_hcd, yenta, yenta, eth0, radeon@pci:0000:01:00.0
 12:      92120          XT-PIC  i8042
 14:     805416          XT-PIC  ide0
 15:    1932859          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
MIS:          0
-- 
Stefan Seyfried

--DocE+STaALJfprDB
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="dsdt.gz"
Content-Transfer-Encoding: base64

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

--DocE+STaALJfprDB--



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
