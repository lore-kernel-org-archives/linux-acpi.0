From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI + Laptop Power Management
Date: Fri, 21 Nov 2003 11:12:32 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031121101232.GL32464@poupinou.org>
References: <C386328088ED7F4E9F81AFBABDDF60DA03386202@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C386328088ED7F4E9F81AFBABDDF60DA03386202-Yw6hFe9C1vnHQcBQSaPqJq0fmWJ9l57d0E9HWUfgJXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 21, 2003 at 12:01:03PM +0800, Ow Mun Heng wrote:
> Hi,
> 
> 	This is a question (not a solution) to determine how to gain maximum
> batt life on a laptop.
> 
> More details on http://bellet.info/~bellet/laptop/t40.html
> 
> Currently, following the recommendations in the link above, I have set
> 'noatime' for my HDs as well as placing commit=600.
> 
> so in /etc/fstab
> 
> /dev/hda	/	etx3	defaults,noatime,commit=600 1 1
> 
> The commit=600 is supposed to stop Kjournal from committing to disk every 5
> seconds and to give a chance to the HD to spin down (not happening!) (can
> check via hdparm -C /dev/hda)
> 
> Doing a hdparm -y /dev/hda (to place the disk into standby) will only work
> for like 10-30 seconds before it spins up again. I have no idea what is
> causing it to spin up again.. (what I/O is going on??)
> 
> There is the option of changing bdflush as well, changing this (5th & 6th)
> to 6000 & 12000 does not yield anything better
> 

I'm using laptop-mode which is now in linux-2.4 since 2.4.23-pre7.
You should really look at.  Look at linux/Documentation/laptop-mode.txt
for more details.


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
