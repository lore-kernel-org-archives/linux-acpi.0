From: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Subject: Re: Radeon Resuming from S3: Try 2
Date: Thu, 02 Dec 2004 10:59:10 +0100
Message-ID: <1101981551.20007.7.camel@mhcln03>
References: <200412012033.05893.barr.156@osu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200412012033.05893.barr.156-ZbGKxL/pcrQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Mittwoch, den 01.12.2004, 20:33 -0500 schrieb Andrew Barr:
> Given the recent positive developments and success stories concerning resuming 
> ATI hardware from S3 suspend, I thought I'd give suspending my desktop PC to 
> S3. Briefly, relevant parts of my hardware:

[...]

> It appears I have two options: the s3_late_bios patch 
> or dummydriver/resume-finish-split. What do I need to do to try each one? For 
> example, I know I need to pass acpi_sleep=s3_late_bios to my kernel to use 
> that patch. 

correct

> It's unclear to me what I need to do with the dummydriver or 
> resume-finish-split patches.

Nothing. They don't need any kernel options to work. The dummydriver
only works
for two specific devices identified by their PCI-ID (or whatever you
call that).
It will *not* work for other devices.

You'll have better luck using resume-finish-split as I didn't see
anything device specific in there (well, I didn't look very long heh).

These two patches don't help resuming your Radeon, they just prevent a
freeze during resume caused by *other* devices.

HTH

-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
