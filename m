From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: ASUS M3N and sleep states
Date: Sat, 27 Dec 2003 22:51:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031227215137.GA28438@hell.org.pl>
References: <3FED7289.1070201@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FED7289.1070201-wlebWZzHoyE@public.gmane.org>
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
> - - S1
> obviously, if I leave the USB module on, the resume process hangs trying
> to set the IRQ for the USB controllers. So, I unload the USB modules and
> the resume process hangs again. I found that the other problem are the
> ALSA modules: if I unload them (and the USB as well), the resume process

[the following is for ASUS L3800C]
Same here for USB (actually, unloading {usb-,}uhci suffices, 2.6 doesn't
hang though). ALSA doesn't seem to care in my case.
About the shutdown: it is likely that a PWRF event is issued after resume
like in my case, kill acpid prior to suspending and see if it makes any
difference (I reported the PWRF problem here a while ago, but have
received no feedback so far).

> - - S4
> without USB and ALSA, I got a clear power-down and for the resume
> (passing to the kernel the option 'resume=/dev/hda6' which is my swap
> partition), the OS seems to resume correctly, it sees my resume command,
> reads the resume partition, but then it reboots and my swap partition is
> corrupted (I need a mkswap on my swap partition).

Kill X and unload AGP or use Nigel's patches from swsusp.sf.net.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
