From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Desktop and S3 suspend the Holy Grail of ACPI?
Date: Tue, 2 Mar 2004 23:34:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040302223446.GG1225@elf.ucw.cz>
References: <4038F499.2060302@verizon.net> <20040225182030.GG1214@elf.ucw.cz> <40410A69.3070800@verizon.net> <20040228220435.GD10530@elf.ucw.cz> <4041136B.9000904@verizon.net> <20040228230941.GA488@elf.ucw.cz> <4043ECB4.7080203@verizon.net> <20040302101904.GA303@elf.ucw.cz> <404501D8.8090506@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <404501D8.8090506-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nick Lidakis <nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> As a test I suspened the machine twice; each time the machine was off 
> for approximately 5 minutes. It resumed twice without any problems (into 
> X with a mozilla and xmms)
> As another test, I opned up a few apps in different workspaces: abiword 
> with a document, mozilla browser and mail, xmms playing an internet 
> stream. I then suspended in hopes of resuming the next day after school. 
> After about 14hrs I tried to resume, and everything seemed fine, excpet 
> my USB mouse was unrespnsive. I was able to brinx X down into a working 
> console, startx again, but still no mouse.
> 
> In debian kernel 2.6.3 I have the NIC and USB options compiled in. 
> Should these be modules that are removed before swsusp?
> There's aslo mention of a swsusp script, but was unable to find one in 
> ../Documentation/power or via apt-cache search; I'm assuming that I need 
> this script, which will remove the modules before swsusp and modprobe 
> them after resume.

You should not need any script; but it probably has better chance
working with USB modules removed. Anyway that's a bug in USB support,
ask on USB list.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
