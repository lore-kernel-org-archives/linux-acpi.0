From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Fwd: Re: echo -n * > /proc/acpi/sleep has no effect
Date: Thu, 20 Feb 2003 17:29:28 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030220172928.GC7432@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Sorry Thomas, fired that off to you instead of the list.
It wasn't intended as a personal rant :)

Thomas Alderweireld [Thomas.Alderweireld-vJEk5272eHo@public.gmane.org] wrote:
> Linux laptom 2.4.21-pre4 #1 Thu Feb 20 15:49:58 CET 2003 i686 i686 i386 GNU/Linux
> and acpi-20030218-2.4.21-pre4.diff 
> 
> Nevertheless, when I do:
> echo -n * (*=1,2,3,4)  > /proc/acpi/sleep  does not do 
> anything. 

It's not meant to, there is no sleep support in kernel 2.4 (except for
APM which requires no software support)

> Any idea, what I can do about this......

You may be able to patch with swsusp support and get software suspend to
disk but it reboots or hangs on resume with my laptop

The problem with 2.4 is that driver writers weren't writing for suspend
capability, so either someone else has patched it in (if you're lucky)
or it's doesn't suspend at all, so may be in indeterminate state before
or after suspend.

You can try a kernel 2.5 kernel but there are no guarantees there either.
It will at least do "something" although that something may be to hard
crash your laptop requiring removal of battery and mains to restart
(along with potential dataloss).

People are only just starting to change drivers to support suspension
and the first step is to have a plain motherboard, keyboard, ide and
display enabled kernel suspend properly on every laptop.

I follow the developer discussion here and try a suspend every time
someone mentions something new which may make a difference - changes to
lcalls, things to make sure are stopped before suspending...  I don't
expect someone to fix these things for me specifically, but I'm happy to
try things out when they're done and see if they make a difference.

I am a coder myself, but I don't have any experience of the low level
debugging which is required, and also the care you must take in using a
debugging method which doesn't use a device which is supposed to be
frozen or powered down already.  My guess is that the keyboard
controller is probably the best tool here, with 3 leds and user
feedback :)  It's also probably one of the few components which is
identical across all systems.  I've never seen any led blinking or
anything during suspend.  I expect that when the developers are ready
for further testing they'll set various combinations so that people can
report which stage through the suspend process the system is getting to
before hanging.

Suspend is not ready for (most) users yet and don't expect it any time
soon AFAICS.

If suspend support is made a requirement for 2.6 driver validation then
that will be your best hope.  My advice for now is to be patient.


Faye

-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

On Monday mornings I am dedicated to the proposition that all men are
created jerks.
		-- H. Allen Smith, "Let the Crabgrass Grow"


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
