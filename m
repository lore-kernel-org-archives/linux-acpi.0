From: Fedor Karpelevitch <fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
Subject: Re: double power button events on presario 900 - apparently a timing issue?
Date: Wed, 24 Sep 2003 16:21:11 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309241621.11993.fedor@karpelevitch.net>
References: <200309240723.28526.fedor@karpelevitch.net> <20030924111121.F53806@root.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030924111121.F53806-Y6VGUYTwhu0@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Nate Lawson wrote:
> On Wed, 24 Sep 2003, Fedor Karpelevitch wrote:
> > as I previously mentioned I am seeing an annoying problem on my
> > presario 900 - when power button (works as FF here) is pressed it
> > generates two events every time. I was experimentin with
> > debugging output and noticed an interesting thing - if I do
> > echo 0xffffffff > /proc/acpi/debug_level
> > to get verbose debug output the problem goes away - I only get
> > one event every time button is pressed. Looks like the problem is
> > caused by some kind timing issue which goes away when debugging
> > slows it down. Does this sound like a reasonable guess? Would
> > anyone suggest how this can be debugged further?
>
> It means you need to debounce the event.

do you mean debouncing on the receiving end? or would that be some way 
to avoid that in the kernel code?

Fedor.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
