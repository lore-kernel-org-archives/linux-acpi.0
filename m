From: Jes Sorensen <jes-dtAfj9ClZIwnoBwkMbRkTB2eb7JE58TQ@public.gmane.org>
Subject: Re: [DMESG] cpumask_t in action
Date: 06 Nov 2003 15:11:48 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <yq0y8utp88r.fsf@trained-monkey.org>
References: <20031105222202.GA24119@sgi.com>
	<20031106165159.GE26869@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031106165159.GE26869-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>>>> "Matthew" == Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org> writes:

Matthew> On Wed, Nov 05, 2003 at 02:22:02PM -0800, Jesse Barnes wrote:

Matthew> There's a number of things here that annoy me.  One is the
Matthew> stupid "Processor 8192/1 is spinning up".  I would expect
Matthew> "Processor 2/96 is spinning up", but why have this line at
Matthew> all?  I'd also like to see "Bringing up 3", "Processor 1 has
Matthew> spun up..." and "CPU 1 IS NOW UP!" go away.  That'd cut us
Matthew> down to:

>> CPU 3: 61 virtual and 50 physical address bits CPU 3: nasid 2,
>> slice 2, cnode 1 CPU 3: base freq=200.000MHz, ITC ratio=15/2, ITC
>> freq=1500.000MHz+/--1ppm Calibrating delay loop... 2241.08 BogoMIPS
>> CPU3: CPU has booted.  Starting migration thread for cpu 3

Matthew> A 40% reduction in per-cpu verbosity ;-)

Why not turn it the other way and just report the success of booted
CPUs and more detailed results for the CPUs that failed? I know there
are cases where you want the debug info in case of tracking kernel
bugs, but one could stick a compile time debug flag into the code for
that case, 960 - 40% = 576 lines of guff is still way too much IMHO,
especially over a serial console.

Cheers,
Jes


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
