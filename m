From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: D600 resume from RAM with black screen, ethernet tg3 is buggy
Date: Thu, 25 Sep 2003 15:24:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030925132427.GJ11901@openzaurus.ucw.cz>
References: <3F6C8721.5050604@vsb.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3F6C8721.5050604-jmYXjVuSQ4U@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Petr Olivka <petr.olivka-jmYXjVuSQ4U@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

>   2.6.0-test5 + test5-pm2.diff - kernel without modules, static
> 
>      - suspend "standby" do not switch off lcd. Is it ok?

+/- yes.

>      -suspend to ram work, but after resume is display black. Without 
> test5-pm2 do not resume back and hang with black screen.

So with -test5-pm2 machine resumes okay, you can type commands
etc, but can't see anything? Try passing cmd line
option acpi_sleep=s3_mode (or how is it called)...
 
>      -suspend to disk hang after hdc and hda suspended (hda is used 
>      for resume, why is suspended?). result:

Thats okay, we want to suspend hda, save its state,
resume hda, save state to hda, suspend hda, powerdown.

> Where are problems? How can I help to solve them?

Can you mail me diff between vanilla and -test5-pm2?
Can you try suspending with echo 4 > /proc/acpi/sleep?
(that should call old working code... provided it propagates down correctly).
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
