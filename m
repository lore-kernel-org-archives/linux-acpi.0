From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: Applications & ACPI events
Date: Tue, 14 Oct 2003 16:04:31 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0310141556320.803-100000@cherise>
References: <20031013171704.GH15441@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031013171704.GH15441-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Alan Hourihane <alanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> > It's also unncessary for X to do a full save/restore of the video card on 
> > every VT switch. I personally find it annoying to wait a second or two 
> > when switching from X to the console. 
> 
> ??
> 
> What if game or another X server is running on different console.

Is it really the current X server's responsibility to provide for what
ever may be running on what ever console the user switches to? That seems
backwards - the application that is being switched to should save the
state of that which it's switching from. This is an X question, though, 
and not fodder for this list.. 

> Patch looks reasonable, but:
> 
> STATE= should really be more finegrained. ACPI s3 is really differnent
> from apm -s, and it looks to me like you'll only tell userspace 'mem'.

Well, it depends on what X (and in general userspace) needs to know on a 
power-state transition. Alan, how does/will X behave differently for each 
power state that we can enter? 

I really don't want to lose the abstraction, since it currently is 
platform-neutral, and doesn't include any x86isms.

> Hmm, apm.. they already have some mechanism to do just this. These two
> should be coordinated. [And this one certainly looks nicer than apm
> way.]

I agree. If we can agree on an interface, it should be usable for any 
platform's power management notification. 

> Kernel waiting for userspace to finish with pm_sem held... If that
> code tries to do "echo platform > disk" in the meantime, you get ugly
> deadlock.

Then, that would be a bug, and would be fixed in early stages of testing. 
:) 


	Pat



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
