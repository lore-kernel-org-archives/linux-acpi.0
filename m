From: wwp <subscript-GANU6spQydw@public.gmane.org>
Subject: reading files in /proc/acpi hangs machine for a short time
Date: Fri, 25 Jun 2004 08:29:29 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040625082929.45335181@tethys.solarsys.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi there,


many acpi programs that show the battery/etc. usage that I tested are making
my system not to respond for a very short while, but periodically. For
instance, the mouse is being locked for 1/n of a second, which is not a big
loss of performance, but it really damn itchy for a normal (intensive) usage
of my Dell Inspiron 8200 laptop (kernel 2.4.26). I do remember of some
programs that were not producing such itchyness a long time ago (maybe
because the kernel things were different?).

I've found that if I some files from /proc/acpi (let's say battery state), I
get the same behaviour.

So my questions are:
- is this a known issue?
- program/kernel/dsdt/what-else issued?
- are there known workarounds?
- is it possible to get the acpi states from another place that /proc (if only it
doesn't show the same problem)?


Regards,

-- 
wwp


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
