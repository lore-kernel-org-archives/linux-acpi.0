From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Re: Re: [Swsusp-devel] ACPI A/C adaptor status not updated	upon
 resume
Date: Sat, 19 Jul 2003 16:54:16 +1200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1058590455.2598.6.camel@laptop-linux>
References: <F760B14C9561B941B89469F59BA3A8470255EE9D@orsmsx401.jf.intel.com>
 <20030719041325.GA18250@donkey.nsw.optushome.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030719041325.GA18250-dUyWl4+syqBVEeF2HbSC4pyo+8vLFsNxunOrhLTifxA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ka-shu Wong <kswong-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, EricAltendorf-gZ4DH+Stb0k@public.gmane.org, swsusp-devel <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

Yes, swsusp will be storing the ACPI state (along with all the rest of
memory). Swsusp has no way to tell whether the state is invalid or not,
or to exclude arbitrary parts of the memory from the image (particularly
since we're probably not talking about a whole page here). The easiest
way to overcome this problem at the moment is to make sure the state is
the same when you resume as it is when you suspend. Failing that, a DSDT
override that does the right thing. Does unplugging and plugging in the
power post resume get the BIOS to set things right?

Regards,

Nigel

On Sat, 2003-07-19 at 16:13, Ka-shu Wong wrote:
> I believe what's happening is that software suspend is somehow saving 
> the ACPI state on suspend, and after resume the state from before 
> suspend (which is no longer valid) is restored.
> 
> If the ACPI state is stored in kernel memory, then this makes sense.
> 
> So, my question (to the swsusp people) is whether it is possible to stop
> swsusp from restoring the old (invalid) ACPI state; and
> (to the ACPI people) is whether it is possible to reset the ACPI
> subsystem in some way.
> 
> - KS
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
