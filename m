From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: AMD64 - kernel freezes when inserting processor/powernow-k8 module
Date: Thu, 3 Jun 2004 22:08:00 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040603200759.GA4507@openzaurus.ucw.cz>
References: <40BE06B2.5090808@renninger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40BE06B2.5090808-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> the machine (AMD64 - 3200+) seems to have a terrible written DSDT.
> After disassembling I could fix several small errors to get it 
> compiled again.

That's Arima, right? Is it production hw, btw?

I hate marketing numbers; is it 2GHz CPU? I have 2GHz Arima prototype here.
I got it to work okay, modulo internal speakers (headphones work)
and keyboard likes to loose clicks.

> loading the powernow-k8 module freezes the machine immediately 
> (POWERNOW-K8_ACPI compiled in and not compiled in)
> 
> loading the processor module freezes the machine also at once.
> (could not get any info, even with acpi_debug function trace on, 
> syslog buffering disabled).
> 
> Other ACPI related modules load and work fine (ac, battery, fan, of 
> course not thermal as it depends on the processor mod).

Strange, these work for me.

Ouch, you do know about neccesity of moving IO_PORT_BASE, right?

> If someone has a similar machine (AMD64 3200+), I would appreciate if 
> you can send me your DSDT to compare it with mine.

Ping me privately.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
