From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: ASUS M3N and sleep states
Date: Tue, 30 Dec 2003 21:56:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031230205636.GB17344@hell.org.pl>
References: <3FED7289.1070201@pca.it> <20031227215137.GA28438@hell.org.pl> <3FF1CD0D.6030602@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
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

Thus wrote Luca Capello:
> About the PWRF event, I sent this mail to the 'acpid' author: it seems
> that any button you press to resume from S1 (so even not the
> power-button), the 'acpid' generates a PWRF event. This should be avoid,
> I mean, it seems that this happens only in S1 state and not in S3.

It's got nothing to do with acpid, it's just a userspace daemon, anyway.
The real problem is either somewhere in BIOS (and no, it's not in the AML
either) or in the ACPI code. For the record, I get the PWRF also after S3.

And no, I'm not pressing the power button to resume.

> About the ALSA problem, maybe the *real* problem is related to the fact
> that I've an 'osl-0892/semaphore' error in my 'dmesg' and at boot when
> trying to load ALSA drivers (but they work without any problems): IIRC
> this is a known problem on ASUS Centrino laptops (I'm sure at least on
> ASUS M3N) and AFAIK there's no solution ATM.

ALSA's suspend / resume support is not really complete, judging on my
experience. My impression is that it currently "works" by chance on my
machine (ICH3M - CS4299).

> | Kill X and unload AGP or use Nigel's patches from swsusp.sf.net.
> I answered in the Pavel's mail about AGP/DRM modules. Question: the
> Nigel's patches let you leave the AGP modules on?

Well, basically, yes, i.e. I'm able to suspend and resume with a DRI app
running, but that's with Radeon-specific patches to the DRM and DRI
modules. On the other hand, even with those patches both pmdisk and Pavel's
swsusp would reboot at resume if X was running during suspend.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
