From: =?iso-8859-1?q?Jo=E3o_Cardoso?= <jcard-A1Gx7Te15Zc@public.gmane.org>
Subject: Re: ASUS M3N standby resume regression in 2.6.x -- works under 2.4.x
Date: Thu, 13 Jan 2005 16:20:35 +0000
Message-ID: <200501131620.35657.jcard@fe.up.pt>
References: <200501111652.28556.jcard@fe.up.pt> <20050112224425.GB2139@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050112224425.GB2139-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 12 January 2005 22:44, Pavel Machek wrote:
> Hi!
>
> > In my ASUS M3N laptop, Centrino based, standby (S1) works fine with
> > linux 2.4.x, x>~24, but fails for all 2.6.x series.
...
> > What else can I do to help you helping me? :)
>
> Obviously try again without usb ever loaded. Recompile kernel without
> USB support if you have to.

I will try that. I can manually remove all usb related modules, but not 
usbcore.

> Does keyboard work?

No, after S1 resume I have to keep the power button pressed for some 6 
sec to power off the laptop.

> Try to find out where it hangs.

How? I don't know were to start.

I have compiled the kernel with CONFIG_ACPI_DEBUG, but I don't know how 
to use it. What shall I "echo" to /proc/acpy/debug_layer 
and /proc/acpy/debug_level, in order to debug this standby/resume 
problem? Remember that as soon as resume happens the laptop hangs, and 
nothing is written to the system logs (only to the screen) -- can we 
force syslog to circunvent the disk buffer/cache?

> Try noapic.

I dont' configure apic in the kernel, as it used to give problems in my 
laptop.

> Did you try with 2.6.11-rc1?

No. I have tried all 2.6.x kernels, but all they fail. 
I will try and I report latter.

Thanks,
Joao

> 								Pavel



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
