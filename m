From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Applications & ACPI events
Date: Mon, 13 Oct 2003 19:17:04 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031013171704.GH15441@elf.ucw.cz>
References: <20031013133837.GA9178@hell.org.pl> <Pine.LNX.4.44.0310130958540.17450-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310130958540.17450-100000-L1xM/EEGAB4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Alan Hourihane <alanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > That exactly my point.  And I think it should not do full save/restore
> > > on only VT switch, but we may try to have a better fine grained stuff for,
> > > something like 'hey, X we have to go S3, please consider'.
> > 
> > I second that. Sure, VT switch is necessary, but it takes quite a few
> > seconds, which is unacceptable for S1 for example (Radeon M7 needs the
> > restore after S1 too).
> 
> It's also unncessary for X to do a full save/restore of the video card on 
> every VT switch. I personally find it annoying to wait a second or two 
> when switching from X to the console. 

??

What if game or another X server is running on different console.
 
> The proper semantics can be obtained with this patch, which I sent to Alan 
> last week after asking for a solution. It calls /sbin/hotplug on suspend 
> and resume, passing the state that we're entering in the environment 
> variables. 

Patch looks reasonable, but:

STATE= should really be more finegrained. ACPI s3 is really differnent
from apm -s, and it looks to me like you'll only tell userspace 'mem'.

Hmm, apm.. they already have some mechanism to do just this. These two
should be coordinated. [And this one certainly looks nicer than apm
way.]

> The kernel will wait for userspace to finish, so it is free to do whatever 
> it needs (shutdown 3d engines, etc). For now, the kernel will not 
> recognize the return value, though there should be a patch floating around 
> in the -mm tree that fixes that.. 

Kernel waiting for userspace to finish with pm_sem held... If that
code tries to do "echo platform > disk" in the meantime, you get ugly
deadlock.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
