From: Dax Kelson <dax-tjn3EnM4d99Wk0Htik3J/w@public.gmane.org>
Subject: Re: [ltp] ibm-acpi-0.2
Date: Sun, 15 Aug 2004 02:19:21 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092557960.10752.10.camel@mentorng.gurulabs.com>
References: <20040810080826.GD28939@aero.ensim.com>
	 <20040814211247.GS20883@aero.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040814211247.GS20883-AKoe11r2kkOzaBltdDZI6w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: linux-thinkpad-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 2004-08-14 at 15:12, Borislav Deianov wrote:
> Hi,
> 
> This is the second alpha release of my ACPI driver for IBM ThinkPad
> laptops. The features currently supported are:
> 
> 	- Fn key combinations
> 	- Bluetooth enable and disable

Without your driver, Bluetooth enable/disable already works fine on my
T42p.

When I press Fn+F5, the led lights up and the following messages show up
in dmesg:

usb 4-1: new full speed USB device using address 2
Bluetooth: Core ver 2.6
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.6
usbcore: registered new driver hci_usb

When I press Fn+F5 again, the led turns off and I get:

usb 4-1: USB disconnect, address 2

Does it work differently on older ThinkPads? Can I use your driver
without messing up the already working Bluetooth enable/disable?

Dax Kelson
Guru Labs



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
