From: Jing Su <gargamel.su-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: problem with DSDT
Date: Wed, 9 Feb 2005 11:15:20 -0500
Message-ID: <f11de95f05020908153e13d0dc@mail.gmail.com>
Reply-To: Jing Su <gargamel.su-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hello All,

I have an Acer TM382.  I have successfully compiled and inserted my
own over-ride DSDT, and I can get the machine to go into S3 sleep and
successfully wake.  Unfortunately, this never works more than once
after a reboot.

I believe the problem is somehow related to dsdt stuff.  Here's the
dmesg output:

Restarting tasks... done
    ACPI-0294: *** Error: Looking up [ECCT] in namespace, AE_ALREADY_EXISTS
    ACPI-1138: *** Error: Method execution failed
[\_SB_.PCI0.LPCB.EC__.COMD] (Node c145d5c0), AE_ALREADY_EXISTS
    ACPI-0643: *** Error: Looking up [ECCT] in namespace, AE_NOT_FOUND
    ACPI-1138: *** Error: Method execution failed
[\_SB_.PCI0.LPCB.EC__.COMD] (Node c145d5c0), AE_NOT_FOUND
    ACPI-1138: *** Error: Method execution failed
[\_SB_.PCI0.LPCB.EC__._Q35] (Node c145d360), AE_NOT_FOUND
    ACPI-0294: *** Error: Looking up [ECCT] in namespace, AE_ALREADY_EXISTS
    ACPI-1138: *** Error: Method execution failed
[\_SB_.PCI0.LPCB.EC__.COMD] (Node c145d5c0), AE_ALREADY_EXISTS
    ACPI-0643: *** Error: Looking up [ECCT] in namespace, AE_NOT_FOUND
    ACPI-1138: *** Error: Method execution failed
[\_SB_.PCI0.LPCB.EC__.COMD] (Node c145d5c0), AE_NOT_FOUND
    ACPI-1138: *** Error: Method execution failed
[\_SB_.PCI0.LPCB.EC__._Q35] (Node c145d360), AE_NOT_FOUND


I'd appreciate it if anyone can offer some insight into resolving this problem.

Thanks
-Jing


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
