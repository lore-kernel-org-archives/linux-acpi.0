From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: trackpoint dead after S3 suspend
Date: Mon, 24 Nov 2003 10:54:48 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031124095448.GB459@elf.ucw.cz>
References: <3FB3B9D0.5020408@netspace.org> <20031116225331.GA206@elf.ucw.cz> <20031119145809.GA14399@hell.org.pl> <3FC05E17.1010208@netspace.org> <20031123103209.GA279@elf.ucw.cz> <3FC1A754.5080209@netspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FC1A754.5080209-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Brian Perkins <bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> the patch you posted to l-k still doesn't work. 
> It wasn't clean, so I had to hand patch it against the current bk tree.
> I'm not sure if I might have been missing another patch.
> Anyway, the following patch to i8042.c(instead of yours) causes my 
> keyboard to work.
> It's not a major modification, mostly it saves the control register 
> before suspending, and then resetting it on resume.

It is at least whitespace-damaged... [And I do not like the
approach... You only reinit single register; is it possible that it
breaks on another system where other registers are forgotten over
suspend?]

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
