From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: Re: reading battery status and CPU time
Date: Thu, 10 Apr 2003 15:18:51 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0304101513220.27207@dynast.gaugusch.at>
References: <m2n0j6uktr.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2n0j6uktr.fsf-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Apr 4, Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org> wrote:
> FYI: reading battery status still consumes lots of CPU time. Unless it's
> supposed to be that way?
> This is on 2.4.21-pre6 with acpi-20030328. Sharp Mebius PC-MT1-H3.
I have the same on a Sony Vaio FX405 (0.11 sec for one "cat state").
I just disassembled and recompiled my DSDT and put some debug output
there.
Very interesting: _BIF gets called twice!
It would still mean 0.05 secs for one query, but it would at least help a
little bit.

Maybe someone can also tell me, why there are two _BIF methods in my dsdt
and only one is called. Could it be for the second battery slot? I just
pulled the battery out of the first one and the machine crashed ... maybe
my dsdt is a bit broken.
I had to remove several Store(Local0, Local0) (NOOP's?????) to make it
compile. There were no other warnings except missing return code of _WAK
(but I don't/can't use ACPI suspend).

btw: Does anybody know how I could print out 1/100 sec accurate timestamps
via syslog/dmesg?

thanks
Markus

-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
