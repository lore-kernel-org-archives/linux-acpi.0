From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Applications & ACPI events
Date: Mon, 13 Oct 2003 21:08:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031013190856.GJ15441@elf.ucw.cz>
References: <20031013133837.GA9178@hell.org.pl> <Pine.LNX.4.44.0310130958540.17450-100000@cherise> <20031013171704.GH15441@elf.ucw.cz> <20031013185914.GB1958@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031013185914.GB1958-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Alan Hourihane <alanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > It's also unncessary for X to do a full save/restore of the video card on 
> > > every VT switch. I personally find it annoying to wait a second or two 
> > > when switching from X to the console. 
> > What if game or another X server is running on different console.
> 
> I think Pavel is right in this sense, but aside from that it would be 
> extremely convenient to be able to suspend and resume directly from X,
> without VT switching. I personally don't care if I have to wait additional
> 4 seconds of VT switch when resuming from S4, but the same delay is
> unacceptable for S1, and even S3 (remember what ACPI spec says about
> timings). That's why we really need a way for kernel to tell the userspace
> (at least X) that a suspend / resume cycle is going on.

Patrick just presented such way, it looks okay.

*But* I think it is not going to speed anything up. Doing console
switch is probably as fast as resume.

OTOH, during S3 suspend, you can get away without "savning"... Okay,
some speedups are possible. Right solution for fast S1 is not to
switch consoles, not to stop processes etc. But that assumes hardware
that works...

Plus your comment about X development cycle looks accurate :-(. 
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
