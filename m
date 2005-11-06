From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: hard drive errors on acpi s3 resume
Date: Sun, 6 Nov 2005 17:27:39 +0100
Message-ID: <20051106162739.GA28697@elf.ucw.cz>
References: <20051104063946.BB9CA3DF4@xprdmailfe12.nwk.excite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051104063946.BB9CA3DF4-ch062KcR4Qw632oaNHexgA1yzfppHFFyQQ4Iyu8u01E@public.gmane.org>
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

> i've been trying to get s3 working on my sony vaio, but i'm having
>some problems concerning the hard drive during resume. after a resume
>i see these messages in dmesg:

...
> 
> the drive eventually spins up and the resume is a success, but it takes like two minutes(too long) and i'm afraid it may be damaging my hard drive.


Please fit your mails to 80 columns.

Also I'm afraid you'll have to ask this on ide lists; this is not an
ACPI but a driver problem.

[Are you doing suspend in middle of some disk operation?]
								Pavel

-- 
Thanks, Sharp!


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
