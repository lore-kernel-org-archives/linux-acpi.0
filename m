From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: Re: Sleep on an ASUS M2400
Date: Sun, 4 Aug 2002 15:12:59 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020804131259.GA32735@schiggy.intern.quelltext.com>
References: <3D498BB5.6070902@lanscape.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3D498BB5.6070902-rrVOh9T094gb1SvskN2V4Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Nicolas Bessert <Nicolas.Bessert-rrVOh9T094gb1SvskN2V4Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 01, 2002 at 09:27:49PM +0200, Nicolas Bessert wrote:
> Hello,
> I have an ASUS M2400 with an AWARD Bios but
> "echo -n 1> /proc/acpi/sleep"

Attention: ^^^ Stupid error. This won't write a "1" to /proc/acpi/sleep!

You want to do "echo -n 1 >/proc/acpi/sleep" (with a space between the
"1" and the ">").

This error comes up so often that all docs should be changed to suggest

    echo >/proc/acpi/sleep 1

(The "-n" doesn't hurt but is superfluous.)

Good luck!
Arndt


> did not have any effect.
> I use a 2.4.18 Kernel with
> acpi-20020709-2.4.18.diff.gz
> nocorruption.2.acpi.diff
> CONFIG_ACPI_SLEEP.patch
> Is this the current development status for the sleep mode,or is there
> something missing in my patches or knowlage.
> 
> Thanks a lot
> 
> Nicolas


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
