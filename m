From: Axel Siebenwirth <axel-t/t5jHnNTs4@public.gmane.org>
Subject: Re: Newbie questions
Date: Sat, 3 Aug 2002 14:49:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020803124913.GA11839@prester.freenet.de>
References: <20020803041040.10310.qmail@web20904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020803041040.10310.qmail-L8+/D2FWflyA/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Gustavo Sverzut Barbieri <gsbarbieri-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Gustavo!

On Sat, 03 Aug 2002, Gustavo Sverzut Barbieri wrote:

> I'm trying to use ACPI withou success. The kernel
> 2.5.{29,30} don't even compile (error with: save_flags
> and restore_flags, listed below).

drivers/acpi/system.c lacks the inclusion of linux/interrupt.h.

So add
#include <linux/interrupt.h>
to drivers/acpi/system.c and it should build.

> I got acpid, but I got nothing more than mapping the
> buttons (power and lid) to run what I desire. I wanna
> know how I put it to sleep (suspend, and how to come
> back)

Don't really know about but Pavel Machek is working on software suspend for
2.5 kernels. Tried it every now and then but it's not 100% working yet since
it's still under development as the whole 2.5 kernel is.
Better is you stickt to 2.4 kernels.
To get acpid work with 2.5 kernels you need a patch for acpid to get it to 
work with latest acpi.

Regards,
Axel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
