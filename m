From: Tim Hockin <thockin-xsfywfwIY+M@public.gmane.org>
Subject: Re: ASUS M3N and sleep states
Date: Mon, 5 Jan 2004 10:19:22 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040105181922.GK11597@sun.com>
References: <3FED7289.1070201@pca.it> <20031227215137.GA28438@hell.org.pl> <3FF1CD0D.6030602@pca.it>
Reply-To: thockin-xsfywfwIY+M@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FF1CD0D.6030602-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 30, 2003 at 08:07:57PM +0100, Luca Capello wrote:
> sometimes I'm a bit stupid... You're right, there's a PWRF event once
> you resume from S1 and this is the cause for the entering in 'INIT 0'.
> Stopping 'acpid' or renaming the action associated to the PWRF event all
> goes well: I got a complete S1 and a complete resume. There're 2 new
> problems, now: after resuming from S1, the fan turns on loudly and I
> can't reboot (but the 'shutdown -h now' works).

I don't know any of the backstory on these - what's up?  Anything I need to
look at?

> About the PWRF event, I sent this mail to the 'acpid' author: it seems
> that any button you press to resume from S1 (so even not the
> power-button), the 'acpid' generates a PWRF event. This should be avoid,
> I mean, it seems that this happens only in S1 state and not in S3.

I *promise* you there is no PWRF event that acpid generates.  All acpid does
is relay the stuff your kernel sends.  And the kernel mostly relays BIOS
stuff.

acpid does not create anything on it's own.


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
