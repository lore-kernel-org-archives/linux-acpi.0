From: Takanori Watanabe <takawata-yzSWc4HAx5xL9jVzuh4AOg@public.gmane.org>
Subject: Re: PNPACPI breaks my asus k6-2 parallel port
Date: Tue, 07 Dec 2004 13:14:31 +0900
Message-ID: <200412070414.NAA01833@axe-inc.co.jp>
References: <20041207022133.GB22171@parcelfarce.linux.theplanet.co.uk>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: Your message of "Tue, 07 Dec 2004 02:21:33 GMT."
             <20041207022133.GB22171-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In message <20041207022133.GB22171-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>, Matthew 
Wilcox wrote:
>
>Turning on PNPACPI changes this in my dmesg:
>
>-parport0: PC-style at 0x378 [PCSPP(,...)]
>-lp0: using parport0 (polling).
>+ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>+ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
>+parport: PnPBIOS parport detected.
>+parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
>+lp0: using parport0 (interrupt-driven).
>+pnp: Device 00:08 activated.
>+parport: PnPBIOS parport detected.
>+parport1: PC-style at 0x278, irq 5 [PCSPP(,...)]
>+lp1: using parport1 (interrupt-driven).
>
>As a result, my parallel port stops working.  Any more information I can
>provide?

I don't know little about Linux specific, but generally,
a Printer port device will appear several times as ACPI devices.

If you forget to check device status (_STA), 
confliction will occur as you got.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
