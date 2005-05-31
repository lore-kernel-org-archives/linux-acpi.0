From: Hannes Diethelm <hannes-diethelm-goEDY2E6dbVyDzI6CaY1VQ@public.gmane.org>
Subject: Re: Fw: [Bugme-new] [Bug 4496] New: Interrupt-problem
	depends on sound-playing: irq 10: nobody cared!
Date: Tue, 31 May 2005 20:57:25 +0200
Message-ID: <1117565845.4783.7.camel@localhost.localdomain>
References: <20050525224328.734adc03.akpm@osdl.org>
	 <200505261546.31915.bjorn.helgaas@hp.com>
	 <1117486138.4887.19.camel@localhost.localdomain>
	 <200505310957.28789.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200505310957.28789.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hmm... I found another ting...

In the working kernel (2.6.11.7 whithout acpi), ther are this lines in
dmesg:

[drm] Initialized drm 1.0.0 20040925
PCI: No IRQ known for interrupt pin C of device 0000:02:07.0. Probably
buggy MP table.
[drm] Initialized radeon 1.14.0 20050125 on minor 0: ATI Technologies
Inc RV280 [Radeon 9200 PRO]
[drm] Loading R200 Microcode


In the buggy kernel:

[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:02:07.0[A] -> GSI 19 (level, low) -> IRQ 20
[drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies
Inc RV280 [Radeon 9200 PRO]
[drm] Loading R200 Microcode

I'll restart and mail you the hole informations...




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
