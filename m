From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Resume -> higher power drain?
Date: Sat, 7 May 2005 21:59:46 +0200
Message-ID: <20050507195946.GA8212@elf.ucw.cz>
References: <427CC869.1050506@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <427CC869.1050506-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> I just observed a strange phenomenon on my new T42p (latest BIOS).
> I can successfully suspend and resume to and from S3 and S4!
> Kernel ist vanilla 2.6.11.8 using ACPI support scripts from the Ubuntu
> acpi-support package (removes critical modules, does vbe save and
> restore, etc...)
> So far very fine and indeed good work.
> 
> Before suspend I usually see a power consumption of about 16W including
> WLAN, which is nicely low.
> But strangely after resume from either S3 or S4 I have see a power
> consumption of 19W+. This means ~3W more or in other words, roughly 20%
> less runtime.
> This is pretty annoying - not a real show-stoppper but it would be nicer
> without ;)
> 
> I have no idea how to diagnose this. My first guess is that some devices
> are not resumed correctly but I have no real idea how for example gather
> device states before and after suspend, or other means to diagnose this.
> 
> So, if anyone has an idea how I can diagnose this and help this issue to
> be solved, let me know. Or is there already a solution floating around?

Is cpufreq working correctly after resume?

									Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
