From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ASUS M3N standby resume regression in 2.6.x -- works under 2.4.x
Date: Wed, 12 Jan 2005 23:44:25 +0100
Message-ID: <20050112224425.GB2139@elf.ucw.cz>
References: <200501111652.28556.jcard@fe.up.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200501111652.28556.jcard-A1Gx7Te15Zc@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jo?o Cardoso <jcard-A1Gx7Te15Zc@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> In my ASUS M3N laptop, Centrino based, standby (S1) works fine with 
> linux 2.4.x, x>~24, but fails for all 2.6.x series.
> 
> In runlevel 1, even with all modules unloaded (but the filesystem 
> modules and usbcore, I can't remove it), the system enters standby upon 
> executing
>    echo 1 > /proc/acpi/sleep
> but after pressing the power button to resume the PC hangs.
> Standby works fine under linux-2.4.x, even under runlevel 5.
> 
> Upon resume, the system becomes blocked, and nothing is written to the 
> logs, so I can't give more details other that the ones written to the 
> screen:
> 
> Stopping tasks:===|
> hwsleep_0315[28215] acpi_enter_sleep_state: Entering sleep state [S1]
> Back to C!
> ACPI: pci interrupt 0000:00:02:0[A] -> GSI 11 (level, low) -> IRQ 11
> 
> The hwsleep_0315[xxx] message can vary, depending on the modules loaded, 
> the xxx can be 28 or 22.
> With all usb modules loaded the message says
>    PCI: setting latency time of device yyyy to 64
> where yyy corresponds to the threee 
>    USB Controller: Intel Corp. 82801DB USB
> 
> So, somehow the system starts resuming (the LCD turns on after pressing 
> the power button to resume), but hangs after that. Under 2.4.x any 
> button starts standby resume, but under 2.6.x only the power button is 
> responsible; curiously, under 2.4.x the power button shouldn't be used 
> to resume, because it generates two acpi events.
> 
> What else can I do to help you helping me? :)

Obviously try again without usb ever loaded. Recompile kernel without
USB support if you have to.

Does keyboard work? Try to find out where it hangs. Try noapic. Did
you try with 2.6.11-rc1?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
