From: marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org
Subject: Re: ACPI and APM
Date: Mon, 26 Aug 2002 12:19:27 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0208261203070.3643-100000@flyby>
References: <20020825120034.4f3ce5b4.valvoline@tiscalinet.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020825120034.4f3ce5b4.valvoline-KGm45+8e4WzOeuqD6ShaSA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 25 Aug 2002, valvoline wrote:

> On Sat, 24 Aug 2002 18:12:58 -0300 (BRT)
> Christian Lyra <lyra-kkgK+NGu78pV51zT55DYLA@public.gmane.org> wrote:
>
>
>
> > 	I would sugest that you didnt disable button flags in ACPI, and
> > just create a script that on a button event generated from ACPI to just
> > call apm -s (I think APM doesnt understand the Lid Button).
>
> It's a great idea! :)...i'll try as soon as possible, and i'll send you
> my feedback.
>
> > to test your hack/patch. May you sent me a patch or the guidelines so I
> > can test it too?
>
> you can download the patch from this url:
>
> http://www.vrlteam.org/patch-apm_acpi_010.tgz
>
> the patch contain both my "kernel hacking" and the official
> 20020821-patch.diff, so you have to apply the patch to a clean 2.4.19
> kernel tree.

Are you sure that your patch is againt clean 2.4.19 kernel?
Or your patch is not so clean ;)

> after that you have to configure your kernel. enable both APM and
> ACPI features. i've flagged the following:
>
> Under APM Support:
>
> - Enable PM at boot time
> - Enable console blanking using APM
>
> "Allow Interrupts during APM BIOS calls" and "Use real mode APM BIOS
> call to power off" doesn't work for me (the system become instable during
> apm --suspend or apm --standby calls, and a shutdown -h now, command
> produce a reboot of the machine...), just try your machine, and give me
> your feedback.
>
> Under ACPI Support:
>
> - Enable ACPI Support
> - Button
> - Fan
> - Processor
> - Thermal Zone
>
>
> I've disable the "AC Adapter" and "Battery" to avoid conflicts with
> APM support, but again, you can try.
>
> After that, recompile your kernel, and get a try on it. you'll notice,
> that "sleep" voice under /proc/acpi, will not be available, but
> APM --suspend and --standby features, will works fine!

I tried enabling both APM and ACPI. I patched a clean 2.4.19 kernel
using acpi-20020821-2.4.19 and then I commented out PM_IS_ACTIVE()
control in arch/i386/kernel/apm.c around 1902 line (is your kernel hack
limited to this only?).

But, when I issue apm --suspend my vaio fx601 doesn't suspend: lcd goes
blank and power doesn't off; instead, as side effect, cd spin on :/
My kernel as Local APIC disabled because, enabling it, acpi doesn't
shitch off my pc on halt and either hsf driver for soft modem doesn't work.

--
Regards,  Marco Gigante
Student at Pisa University - Computer Engineering



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
