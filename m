From: Andreas Dieling <snow-1pFVYSAoaJAREI5ypv3d1g@public.gmane.org>
Subject: acpi_serialize not working?
Date: Thu, 9 Sep 2004 15:15:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200409091515.18129.snow@quantentunnel.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi,

i have an Asus M6N notebook. Me and other M6N users have the problem that the 
fan sometimes stops working which results in an overheating of the system. 
The problem occurs under Linux and under Windows.

After much investigation i could figure out the problem: 

It is a problem with concurrently appearing acpi events. If i am reading cpu 
temperature via acpi in an endless loop and the fan is switching on 
collateral the fan controll and temperature readout is crashing and left 
non-functional.

After i patched the dsdt and marked all aml methods as "Serialized" the 
problem doesn't occur anymore :-)

Since other M6N users may not want to patch their dsdt i tested acpi_serialize 
as a kernel option. I thought it should have the same effect, but it doesn't 
seem to work because the fan/temperatur problem occured again...

Is this a bug or has the acpi_serialize option a different purpose?

thx Andreas


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
