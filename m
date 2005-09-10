From: "Randy.Dunlap" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: ibm-acpi
Date: Fri, 9 Sep 2005 18:41:27 -0700
Message-ID: <20050909184127.54f739da.rdunlap@xenotime.net>
References: <20050909081601.0071c822.fbusse@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050909081601.0071c822.fbusse-Mmb7MZpHnFY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fridtjof Busse <fbusse-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 9 Sep 2005 08:16:01 +0200 Fridtjof Busse wrote:

> Hi
> I'm not sure if this is the right place to ask, but the
> MAINTAINERS-file in the kernel lists nobody else:
> Who is responsible for keeping ibm-acpi up2date in the kernel? The
> version in the kernel is 0.8, while 0.11 is the current available
> version. But since the ibm-acpi developers don't answer mails anymore,
> I can't figure out if they maintain the driver in the kernel themselves.
> Anyhow, the version in the kernel should be updated, especially since
> 0.11 doesn't build with the current kernel (2.6.13), though that's easy
> fixable (but still annoying).
> Thus a current in-kernel driver would be a good thing since it supports
> lots of new hardware.

It appears that its author still maintains it (at least that's
what it looks like on http://ibm-acpi.sourceforge.net/ ).

MODULE_AUTHOR("Borislav Deianov");
borislav-iA+eEnwkJgzk1uMJSBkQmQ@public.gmane.org

---
~Randy


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
