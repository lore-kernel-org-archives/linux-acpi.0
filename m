From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Device power for suspend/resume
Date: Mon, 12 Apr 2004 17:38:45 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040412172333.Y71599@root.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Cc: acpi-h+KGxgPPiopAfugRpC6u6w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'm soliciting some comments on proper steps to take with device power on
the suspend/resume path.  There are some complications like _SxD and none
of us support them yet.  Here are the abbreviated steps as I see them
(only device power code, not general sleep steps):

1. All devices put in power state inferred by power resource
   ... except if _SxD exists, put them in that state instead
   ... except if enabling for wake, put in state in _PRW
2. Turn off all power resources no longer referenced
3. Enable wake for all devices that have _PRW

[suspend/resume]

4. Turn on all power resources
5. Turn on all devices
6. Run _S0D on devices and put them in the corresponding power state
7. Turn off devices previously off before suspend
8. Turn off all power resources no longer referenced

While examining how to implement this, I ran into some confusing
questions.

A. _S0D is not referenced in the spec but it appears some ASL uses this
for docking connectors.  It returns 3 for when a bus isn't connected to
anything (undocked) and 0 when it is present.  I'm guessing this should be
run on resume after everything is running to see if we can power down a
device that is not available (step 7 above).

B. The requirement to turn on power resources referenced in _PRW appears
to be the overriding factor in the suspend path.  That's why I do it last
above.

C. It's not clear how _SxD overrides the power resource Sx value since a
device can't be in a higher state than its power resource.  This appears
to be a minor issue since most devices that have _SxD that is higher than
the desired sleep state do not have a power resource.

D. If a device has _PSx methods but no power resource, should it be put in
a state equal to its Sx state unless there is an overriding _SxD?  For
example, all devices should be put in D3 for S3, then power off
unreferenced power resources.  What if you're going to S1 but there's no
_PS1?  Leave it in _PS0 unless there is an _S1D saying otherwise?

One other issue:  there's a bug in hwsleep.c where we don't clear WAK_STS
in the S5 path.  That should be changed.

Comments will help everyone get suspend/resume working better since it
appears devices in the wrong power states affect stability here.

Thanks,
-Nate


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
