From: David Eriksson <twogood-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: Oops during startup
Date: Wed, 02 Jun 2004 08:28:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1086157732.2833.155.camel@zion.2good.net>
References: <20040602013512.GA570@paladin>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040602013512.GA570-FdgSi869q7U@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ethan Glasser-Camp <glasse-IL7dBOYR4Vg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-06-02 at 03:35, Ethan Glasser-Camp wrote:
> 2.6.6 oopses on startup for me. acpi=off seems to work OK.
> 
> My Thinkpad T-30 has served me faithfully for about 1.5 years, but was
> needing some service so I took it to the shop today. They gave me a
> replacement laptop (same model, still a T-30), but when I tried to
> boot up, I got a kernel oops. 2.6.5 boots up fine, and so does 2.6.6
> when given the boot parameter acpi=off. The machines are basically
> identical except for the CD-ROM drive. Might this cause a problem? Or
> should I be pointing a finger at the ACPI tables and other firmware?
> 
> Since the kernel oopses before it finishes booting up, I can't even
> scroll up to the top of it to see what the oops message is. I can copy
> the callback if it helps. How can I help to diagnose the problem?

I suggest that you first verify that you have the latest version of the
BIOS and Embedded Controller Program. Compare the numbers provided by
your BIOS with those on this page:

http://www-3.ibm.com/pc/support/site.wss/document.do?lndocid=MIGR-42358

-- 
Regards,
               -\- David Eriksson -/-

        SynCE - http://synce.sourceforge.net
       CalcEm - http://calcem.sourceforge.net
      ScummVM - http://scummvm.sourceforge.net
     Desquirr - http://desquirr.sourceforge.net
  SetiWrapper - http://setiwrapper.sourceforge.net



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
