From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 on Intel Desktop Board D865GBF
Date: Thu, 27 May 2004 23:06:59 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040527210659.GD997@openzaurus.ucw.cz>
References: <1085272779.7511.11.camel@300mlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1085272779.7511.11.camel-Yau0ytKvSx2eZLLa646FqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I'm trying to get S3 to work on an Intel D865GBF Desktop Board (Intel
> 865G chipset) running a 2.6.6 vanilla kernel. Right now, the computer
> powers up after a resume and some devices initialize (CD drives), but
> the display remains off. Adding acpi_sleep=s3_mode to the command line
> does nothing (visibly) and acpi_sleep=s3_bios causes a Video BIOS
> identification screen to be displayed. The keyboard and mouse do not
> work, and pinging the machine's wireless card fails as well.
> 
> When the machine resumes, the power LED is off, and pressing the reset
> switch fails to bring up the BIOS "silent boot" screen. Only by forcibly
> shutting off the machine (hold down the power button, pull the plug) and
> turning back on can I get it to boot.
> 
> What needs done to get S3 working on a system like this?

First I'd complain about broken reset button...

...and than you need some assembly hacking.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
