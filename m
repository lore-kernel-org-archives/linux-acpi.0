From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: S3 suspend and serial console
Date: Sat, 05 Feb 2005 14:29:52 +0100
Message-ID: <4204CA50.8090906@gmx.net>
References: <42023083.8030508@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <42023083.8030508-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Carl-Daniel Hailfinger schrieb:
> Hi,
> 
> on resume from S3, my serial console prints garbage and stops working.
> I assume the BIOS resets the serial port on resume, but I have
> abolutely no idea how to find out what speed and parity the serial
> port has after resume. A quick try of 9600,57600,115200 didn't
> succeed and I now wonder if
> - the kernel could reset the serial ports on resume
> - the kernel could read the current parameters from the UART and print
> them out so I can adjust my serial console.
> 
> Oh well... after some investigation, it seems the serial console
> goes back to normal after issuing the command
> echo foo >/dev/ttyS0

>/dev/ttyS0
fixes it, too. So you're right, Pavel.


> Could it be that the UART state is out-of-sync or something like that
> after resume and the serial console code doesn't notice?

If you add an open()/close() to the S3 wakeup code, how can you
find out which device you're supposed to open, that is which device
the serial console is attached to? And how early can you open() the
serial port? Before the "Back to C!" printk?

Once you have a patch, please mail it to me. I'll surely test it ;-)

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
