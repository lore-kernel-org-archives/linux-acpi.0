From: Arjen Verweij <a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org>
Subject: Re: Impossible to compile iasl
Date: Fri, 26 Nov 2004 01:57:56 +0100
Message-ID: <41A67F94.4040604@student.tudelft.nl>
References: <20041125215456.53EA218000F6@mwinf0812.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20041125215456.53EA218000F6-afEMCSx7HWSXUJFIH1ktwRXaG6MH5uyT@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: vincent.legarrec-39ZsbGIQGT5GWvitb5QawA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Yep, same problem here. I tried using acpisrc also, from tools/acpisrc 
which compiles cleanly, but doesn't "Linuxify" the code. Or did I 
misinterpret the purpose of this tool...

Regards,

Arjen

sphere@barton:~/media/acpica-unix-20041105/compiler$ gcc -v
Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.4/specs
Configured with: ../src/configure -v 
--enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr 
--mandir=/usr/share/man --infodir=/usr/share/info 
--with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared 
--with-system-zlib --enable-nls --without-included-gettext 
--enable-__cxa_atexit --enable-clocale=gnu --enable-debug 
--enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i486-linux
Thread model: posix
gcc version 3.3.4 (Debian 1:3.3.4-11)


vincent.legarrec wrote:

>Hi, I downloaded iasl from
>http://www.intel.com/technology/iapc/acpi/downloads.htm and I can't compile
>it.
>I need iasl because I have the recurrent message : ACPI:
>acpi_ec_space_handler: bit_width should be 8
>
>Is anyone have the same problem? 
>
>Thanks
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now. 
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>  
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
