From: Barry Kitson <b.kitson-EkmVulN54Sk@public.gmane.org>
Subject: Masquerading operating systems (with ACPI_OS_NAME) does cause
 grief.
Date: Sun, 09 Jan 2005 23:40:52 +1000
Message-ID: <1105278053.23887.35.camel@dangun.glencairn.bogus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

The following messages ....
http://sourceforge.net/mailarchive/message.php?msg_id=9558174
http://sourceforge.net/mailarchive/message.php?msg_id=9559475
suggest that there are no known problems resulting from pretending your
favourite OS is something it's not.  Well, bad news.....

Please note that (modulo VGA, which has it's own special set of
problems) the only string (prefix) that causes suspend/resume of linux
2.6.10 to fail on a VIA EPIA CL10000 Mini-ITX motherboard (with either
of the two available BIOS versions - 1.16 or 1.23) is the newish (but
not entirely accurate) default of ACPI_OS_NAME="Microsoft Windows NT".
When Linux declares itself to be NT, resumes just don't happen.  The fan
and power supply wake up, but that's about all.  

Are we really sure this value of ACPI_OS_NAME should be the default?
Could I suggest a return to "truth" as a default, with prominent
suggestions within the documentation of what lies to try when the truth
fails?

For the info of anyone stumbling over this message with a EPIA
suspend/resume problems, setting "acpi_os_name=Linux" in the boot
parameters (e.g. in /etc/lilo.conf, add a line
append="acpi_os_name=Linux") may help you too.  On the CL10000, it's not
necessary to remove usb or rhine modules, and networking seems to resume
nicely. If you want to see anything interesting on a monitor connected
to the VGA port, you're overly optimistic.

Have fun,

Barry.






-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
