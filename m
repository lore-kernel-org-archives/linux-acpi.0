From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: Re: Battery status reading problems
Date: Fri, 19 Sep 2003 23:02:46 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0309192257480.1613@phoenix.kerstin.at>
References: <m2vfrpthxt.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2vfrpthxt.fsf-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sep 18, Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org> wrote:
> Reading the battery status still consumes insane amounts of CPU time
Recently, a bug has been fixed by some nice person at intel - the AML code
was executed twice. Although half of the time is still not perfect, it is
a lot better now.

You can find the patch at http://bugme.osdl.org/show_bug.cgi?id=726 , I
hope it will find its way into official sources soon.

While we are on the topic: I got a battery from a friend which caused my
system to throw exceptions AE_TIME in thermal zone(!) code, which didn't
work anymore afterwards (wrong temperature). I don't know
what happened to this battery, but it cannot be loaded, design capacity is
multiplicated by 10 each time I query the "info" and the serial number is
either "Bad" or empty. If anybody is interested, I can post my DSDT or
logfiles. But the problem is with windows as well ...
The battery is original Sony, by the way ...

Markus
-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
