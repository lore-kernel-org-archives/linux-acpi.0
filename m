From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ASUS M3N standby resume regression in 2.6.x -- works under 2.4.x
Date: Wed, 19 Jan 2005 16:24:16 +0100
Message-ID: <20050119152416.GC476@openzaurus.ucw.cz>
References: <200501111652.28556.jcard@fe.up.pt> <20050112224425.GB2139@elf.ucw.cz> <200501141909.34406.jcard@fe.up.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200501141909.34406.jcard-A1Gx7Te15Zc@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: JoCardoso <jcard-A1Gx7Te15Zc@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> OK, I have compiled 2.6.11-rc1 without USB support.
> 
> dmesg output is appended. There are some acpi related errors/warnings. 
> 
> But now, the system don't enters S1.
> Upon "echo 1 > /proc/acpi/sleep" in runlevel 1, the following message is 
> printed: (the ... mean I'm ommiting some figures I don't think are 
> important )
> 
> Stopping tasks: ===|
> ------[ cut here]----
> Kernel bug at drivers/pci/pci.c:330!

Hmm, I probably have broken S1... I'll check.

> The system went to standby (power LED flashing, blank screen), and upon 
> pressing the power button again to resume from sleep, the LCD screen 
> turned on, showing the following:
> 
>    Stopping tasks: ===|
>      hwsleep-0306 [78] acpi_enter_sleep_state: Entering sleep state [S1]
> 
> So, there is obviously a problem with the e100 network driver. But the 
> system is locked, the keyboard does not works.
> 
> S3 doesn't work either, but never worked, even in 2.4.xx
> 
> And now, after the S3 test, at power up, my laptop starts, the fan works 
> for a couple of seconds, and the laptop shuts down itself -- without 
> even showing the initial bios messages!
> 
> What is the next step? A new laptop? WinXP? (sorry, but I'm not exactly 
> happy)

You can always donate your laptop to me :-).

Add printks to find out what goes wrong... You may want to disable some device_suspend()
and device_resume() calls.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
