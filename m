From: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Subject: Re: [BKPATCH] ACPI for 2.4
Date: Sun, 8 Feb 2004 09:20:59 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040208082059.GD29363@alpha.home.local>
References: <1076145024.8687.32.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1076145024.8687.32.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Len,

On Sat, Feb 07, 2004 at 04:10:24AM -0500, Len Brown wrote:
> 	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.4.25
> 
> 	the AML param fix is in 2.6 -- the others changes
> 	are Asus and Toshiba model specific.

I encountered something strange that I still cannot explain. I have two
machines, one athlon-based VAIO notebook and one P4-based supermicro 1U
server, which don't poweroff when I halt them or send them a Sysrq-O. At
first, I only noticed this on the VAIO so I thought that something changed
in ACPI recently, because it was OK around 2.4.21 or 2.4.22 with acpi patch
from around 09/2003, but I believe that the problem appeared when I used
2.4.23 + the acpi-20031203 patch, which is now included in 2.4.25-rc1. But
then I discovered that I can poweroff both the notebook and the 1U by a
simple "echo 5 >/proc/acpi/sleep".

So I've added printk's into acpi_power_off(), and I see that the system
doesn't return from acpi_enter_sleep_state_prep(S5), which itself hangs
on the call to acpi_evaluate_object(NULL, "\\_PTS",...). If I comment
out this line, it now goes on through the next calls, then normally leaves
acpi_enter_sleep_state_prep(), then powers off correctly. I have not tested
yet you very latest patch, but I don't think it would change anything.

Do you have any idea ? What can I provide to help in resolving this problem ?

Regards,
Willy



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
