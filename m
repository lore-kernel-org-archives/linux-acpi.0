From: Oliver Dawid <od-VRmHG7Xu4f31qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org>
Subject: S3 broken Samsung P35 - howto debug?
Date: Sun, 21 Nov 2004 16:00:01 +0100
Message-ID: <200411211600.01820.od@fet.uni-hannover.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hi there,

like Matthias Hentges I have problems with my Samsung - mine is a P35. There 
are some differences between these machines. I did not succeed to get S3 
running yet. I can put machine to sleep with echo 3 > /proc/acpi/sleep but on 
pushing the power button again only some devices seem to wake up.

I already got a patch to use old style resume from Matthias but this does not 
work. Not only the display is dead but also the keyboard seems not to accept 
anything. Network interface is not running (rtl 8139) as ping does not 
respond. 

I am using Kernel 2.6.9 with initrd-patch for a fixed dsdt. Any acpi based 
feature seem to work: using the asus_acpi I am able to use the shortcuts, 
hitting power button leads to halt the machine and so on.

Now I got several questions how to proceed:

- which modules are needed to be compiled into kernel directly? Does it 
matter, if ide_* is loaded as module?

- which modules are known not to work properly with acpi sleep/ resume? Which 
should be unloaded before going to sleep?

- Any idea, how to debug on low level without display, connection via ethernet 
etc? Serial port? Printerport? Soldering a module with leds on printer port 
to output states?

Any help would be appreciated.

Regards,
Oliver

-- 
Oliver Dawid * od-9LIF7zR9EMg@public.gmane.org * http://www.fet.uni-hannover.de/~od/


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
