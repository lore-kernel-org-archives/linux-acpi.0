From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: PNPACPI breaks my asus k6-2 parallel port
Date: Tue, 7 Dec 2004 02:21:33 +0000
Message-ID: <20041207022133.GB22171@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


Turning on PNPACPI changes this in my dmesg:

-parport0: PC-style at 0x378 [PCSPP(,...)]
-lp0: using parport0 (polling).
+ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
+ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
+parport: PnPBIOS parport detected.
+parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
+lp0: using parport0 (interrupt-driven).
+pnp: Device 00:08 activated.
+parport: PnPBIOS parport detected.
+parport1: PC-style at 0x278, irq 5 [PCSPP(,...)]
+lp1: using parport1 (interrupt-driven).

As a result, my parallel port stops working.  Any more information I can
provide?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
