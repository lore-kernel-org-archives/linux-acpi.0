From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Problems waking up from S3 (2.5.25-dj2)
Date: Mon, 29 Jul 2002 16:23:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020729142333.GA977@elf.ucw.cz>
References: <20020720170919.GA9308@dutidad.twi.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020720170919.GA9308-V1rPnKwUOrA59+mn7qD7y50iERQUc4G+@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I would like to make use of the S3 (suspend to ram) sleep state.  

Good.

> I've done
> the prerequisite searching on lists and on google, but it's difficult to
> find conclusive answers.  It _seems_ that S3 _could_ be working on 2.5
> kernels, but it also seems that many people have had the problem of not
> being able to trigger a wake-up from S3.

S3 works for me, somehow on Omnibook XE3. Works once on toshiba
4030cdt. Crashes but can be solved by not calling bios on desktop
athlon.

> I have this same problem and would like to know what possible courses of
> action there are.  I am experimenting with 2.5.25-dj2 (acpi-20020611
> integrated) on a i845 laptop with Phoenix BIOS 4.0 release 6.  For the
> moment, swsusp will not work on this laptop (due to the fact that the Radeon
> has the switch to VT X freezing problem) so I'm looking at S3 as a temporary
> alternative.

Perhaps it is easier to make swsusp working?

> The laptop goes to sleep nicely when I do "echo 3 > /proc/acpi/sleep".  It
> ends up with the power led flashing (which, according to documentation,
> should happen during S3) and everything quiet.  However, nothing I do then
> can make it wake-up again: no amount of pressing keyboard keys, the power
> button, the sleep button, etc. will result in any activity.  Eventually, I
> have to keep the power button depressed for 4 seconds after which the laptop
> actually switches off completely.
> 
> My question is this: Is S3 supposed to work with this kernel?  If so, how
> can I configure it (perhaps build new ACPI tables?) so that the laptop will
> wake-up from S3 sleep?

Yep.

> I saw this bit in hwsleep.c:
>         /*
>          * _PSW methods could be run here to enable wake-on keyboard, LAN, etc.
>          */
>         status = acpi_get_sleep_type_data (sleep_state,
>                           &acpi_gbl_sleep_type_a, &acpi_gbl_sleep_type_b);
> 
> Which does look suspicious (in a good way) but I wouldn't know what to do
> with it.

There's some line you might want to comment out... lets see...

Comment this out:

        status = acpi_hw_disable_non_wakeup_gpes();
        if (ACPI_FAILURE (status)) {
                return_ACPI_STATUS (status);
        }


									Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
