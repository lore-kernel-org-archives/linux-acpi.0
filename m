From: Diego Zuccato <diego-gmoNqwowlqBr8A+qpt3pXFzrSV/HdtiB@public.gmane.org>
Subject: Re: IDE instability W/ ACPI ?
Date: Fri, 26 Jul 2002 13:35:26 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D41885E.996A7493@otello.alma.unibo.it>
References: <3D372E8F.64B4A0A1@otello.alma.unibo.it> <20020726103733.GB279@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Pavel Machek <pavel-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Cc: Acpi List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Pavel Machek wrote:

> PCMCIA fan? How does that beast look like, and how does it guarantee
> CPU not overheating?
It's an "empty" PCMCIA card with some holes to let air flow. On the
external part there's a fan.

Let's try some ASCII art :-)
________
|       \___________________________
|___________________________________|

The fan is in the thick end. The thin end must be inserted in the PCMCIA
slot.
It's not really a big cooler (just 2-3 Celsius degrees less than
without), but at least it's something.
It doesen't GUARANTEE cpu doesen't overheat, but just TRIES.

BYtE,
 Diego.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
