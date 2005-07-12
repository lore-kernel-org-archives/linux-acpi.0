From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Thinkpad A21m oops when go to sleep second time
Date: Tue, 12 Jul 2005 12:07:19 +0100
Message-ID: <20050712110719.GA8576@srcf.ucam.org>
References: <42D36A97.2080807@mydatex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42D36A97.2080807-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Daniel Smolik <marvin-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 12, 2005 at 09:00:39AM +0200, Daniel Smolik wrote:

> [<c020c9be>] uart_suspend_port+0xde/0xf0

This is in the serial code. The problem seems to be that not all serial 
ports are found on resume. Take a look at the following boot-time dmesg 
output:

[4294670.599000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294670.599000] ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
[4294670.601000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

Note that ttyS0 is found twice. After resume, ttyS0 is still available, 
but ttyS2 now gives ENODEV. If the device was held open over suspend, 
then the next suspend explodes when it tries to suspend the second 
serial device.

Anyone have any idea what's going on here? I'm guessing some sort of 
issue with legacy and ACPI device discovery?
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
