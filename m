From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PM]No ACPI interrupts after resume from S1
Date: Sat, 25 Oct 2003 21:58:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031025195817.GB505@elf.ucw.cz>
References: <yw1x8yngj7xg.fsf@users.sourceforge.net> <20031020184750.GA26154@hell.org.pl> <yw1xekx7afrz.fsf@kth.se> <20031023082534.GD643@openzaurus.ucw.cz> <yw1xr813f1a3.fsf@kth.se> <3F98FDDF.1040905@cyberone.com.au> <yw1xbrs6652m.fsf@kth.se> <20031024222347.GB728@elf.ucw.cz> <yw1xbrs6p85n.fsf@kth.se> <1067039997.2114.16.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1067039997.2114.16.camel-udXHSmD1qAy4CTf7w+cZoA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Cc: M?ns Rullg?rd <mru-UNjuZkX4dYU@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> Some modules cause problems. If I suspend with the intel-agp driver
> loaded, for example, the computer reboots when copying the original
> kernel back, because the hardware state doesn't match. I can suspend and
> resume my i830 based laptop just fine without it. Once the right changes
> are made to the driver, the module will work, but not yet.
> 
> Pavel, excuse me for jumping in here.

No problem, I'm actually tired of replying to all those mails myself
;-).

									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
