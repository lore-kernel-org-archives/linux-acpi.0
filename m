From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: [ACPI-sppt] Re: [ACPI] Reporting success on i8k5 Suspend/Resume linux-2.6.0-test6!!!
Date: Sun, 5 Oct 2003 00:49:06 +0200
Sender: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031004224906.GA1190@elf.ucw.cz>
References: <20031003150423.462e88f4.XaRz69@terra.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031003150423.462e88f4.XaRz69-pCzzcW6XgXY@public.gmane.org>
Errors-To: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-support>
To: Pere Casta?er <XaRz69-pCzzcW6XgXY@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I'm having good news for all linux i8k5 users. With the kernel 2.6.0-test6 and the acpi patch of 20030918 I can suspend the laptop correctly and resume BUT:
> 

Suspend to disk or ram? If ram, you might want to add
acpi_sleep=s3_mode to command line.
							Pavel


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
