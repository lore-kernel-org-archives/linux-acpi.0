From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: RE: ACPI can't perform S5 soft off
Date: Tue, 8 Jun 2004 12:04:22 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040608120259.I80205@root.org>
References: <000801c44d5a$f99f0440$ba00a8c0@hasslemonkey.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <000801c44d5a$f99f0440$ba00a8c0-1LCzNYzl4/K5rx9LGsG9jg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gareth Wheelton <gareth-1LCzNYzl4/K5rx9LGsG9jg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 8 Jun 2004, Gareth Wheelton wrote:
> Kernel	= 2.4.26
> Motherboard = Abit KT7-RAID with Bios Issue Date:2002/07/11
>
> Turns out configuring the kernel without CONFIG_RTC solved my problem.
> Not sure about how CONFIG_X86_UP_APIC influences this problem as that
> was unset already.
>
> If you have time please could you explain how these configurations have
> prevented my machine entering S5.

The question is, why does disabling the RTC affect S5?  I don't know how
Linux handles GPEs but it sounds like it's not disabling/enabling the
proper GPEs for S5 (based on lowest sleep state in _PRW).  Is this
possible?

-Nate


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
