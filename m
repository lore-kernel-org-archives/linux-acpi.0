From: Alexei Gilchrist <a.gilchrist-6NCMjze5YvWHXe+LvDLADg@public.gmane.org>
Subject: S3 partial sucess on centrino 855GM
Date: Tue, 02 Mar 2004 13:42:07 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078198927.1259.12.camel@qubit>
References: <C386328088ED7F4E9F81AFBABDDF60DA045C6E87@wdmyexch02.my.asia.wdc.com>
	 <4043FCE7.5040703@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4043FCE7.5040703-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The following was pointed out to me on another list and I've verified it
works on my Panasonic W2 (centrino, 855GM):

kernel 2.6.1 or 2.6.3, XFree86 v4.4, using VESA driver for X, S3 will
work, the screen will switch on again using a combination of Ctr-Alt-F8
and Ctrl-Alt-F7.

It doesn't work from a console, or using the i810 driver. Also the
network card seems dead afterwards and a reboot will hang the machine.

Still, it's a partial success for reviving a dead screen that seems to 
plague several centrino laptops.

Anyone with this problem care to check other versions of XFree86, and
verify it on other laptops? 

I don't know if it's possible to take whatever initialisation the VESA
driver is doing and always executing it on resume?

cheers,

Alexei 
 



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
