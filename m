From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: hard drive errors on acpi s3 resume
Date: Fri, 7 Oct 2005 06:31:26 +0000
Message-ID: <20051007063126.GB1917@spitz.ucw.cz>
References: <20051108030627.93670109EB8@xprdmailfe1.nwk.excite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051108030627.93670109EB8-ch062KcR4Qzgx848pHWfrcMwje2lEl0q0E9HWUfgJXw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sdfa <slinky1776-wzCN7aUSXSrQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> about spinning the drive down before s3: 
> 
> when i do a hdparm -y /dev/hda, the drive immediately spins back up, probably due to some logger daemon. i've tried killing syslogd and klogd, but this still happens.
> 
>

Try init=bin/bash with ext2 (not ext3).

						Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
