From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: If your ACPI-enabled machine does clean shutdown randomly...
Date: Fri, 28 Nov 2003 17:10:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031128161030.GC303@elf.ucw.cz>
References: <20031128145249.GA563@elf.ucw.cz> <1070035371.1055.13.camel@golgoth01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1070035371.1055.13.camel-yzJ1TzNew8IqMp+WYRx65w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Damien Sandras <dsandras-AvcYnRpcIedBDgjK7y7TUQ@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > ...then you probably need this one. (One notebook I have here
> > certainly needs it).
> > 
> > It seems that acpi likes to report completely bogus value from time to
> > time...
> > 
> 
> The problem with that patch is that it is filling the logs, but it is
> certainly better than shutting the machine down without warning. I had
> that problem and it took me a few minutes to figure out that it was
> ACPI.

I'm not pushing this patch for inclusion, only its second part.

> However, I didn't have that problem with kernel 2.6.0 test 9, it
> appeared with 2.6.0 test 10 and test 11. I have mailed the list to see
> if there was no patch I could reverse to determine where the problem
> was, but I got no reaction, so I guess I will have to live with it ;)

I have this on rather strange hw, so my tests do not count :-(.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
