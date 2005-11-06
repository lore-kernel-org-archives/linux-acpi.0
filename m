From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: hard drive errors on acpi s3 resume
Date: Sun, 6 Nov 2005 21:21:36 +0100
Message-ID: <20051106202136.GG29901@elf.ucw.cz>
References: <20051104063946.BB9CA3DF4@xprdmailfe12.nwk.excite.com> <20051106162739.GA28697@elf.ucw.cz> <1131310139.1212.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1131310139.1212.37.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: sdfa <slinky1776-wzCN7aUSXSrQT0dZR+AlfA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Also I'm afraid you'll have to ask this on ide lists; this is not an
> > ACPI but a driver problem.
> 
> Its probably also an ACPI problem. ACPI provides disk suspend/resume
> methods but nobody as hooked them to anything. Basically you shouldn't
> mix ACPI S3 and IDE disks in Linux until this is done.

Okay, I keep forgetting about this one.

slinky, can you take a look if your DSDT does something interesting in
IDE suspend/resume methods?

> Usually it'll work but if it doesn't then you may want to join in
> writing the needed code.

Could we work around it by hdparm -y /dev/hda just before S3? There
should be nothing to save about stopped harddrive ;-).
								Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
