From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: hard drive errors on acpi s3 resume
Date: Tue, 8 Nov 2005 00:34:47 +0100
Message-ID: <20051107233447.GD2034@elf.ucw.cz>
References: <20051104063946.BB9CA3DF4@xprdmailfe12.nwk.excite.com> <20051106162739.GA28697@elf.ucw.cz> <1131310139.1212.37.camel@localhost.localdomain> <20051107012229.GA19681@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051107012229.GA19681-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, sdfa <slinky1776-wzCN7aUSXSrQT0dZR+AlfA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > Also I'm afraid you'll have to ask this on ide lists; this is not an
> > > ACPI but a driver problem.
> > 
> > Its probably also an ACPI problem. ACPI provides disk suspend/resume
> > methods but nobody as hooked them to anything. Basically you shouldn't
> > mix ACPI S3 and IDE disks in Linux until this is done.
> 
> There's a patch that floated on here a while ago - we're shipping it in 
> Ubuntu. Hang on...
> 
> http://www.codon.org.uk/~mjg59/tmp/external-drivers-ide_sleep.dpatch is 
> what we're shipping - it seems to work in most cases, but not all. It 
> implements the _GTM and _STM methods, but doesn't do anything with _GTF 
> since the IDE layer hasn't been resumed at the point where this code 
> executes, so there's no existing mechanism to execute the taskfile 
> commands returned. It may help in this case.

Its coding style leaves something to be desired, but otherwise it
looks okay. Unfortunately, I do not need it on my machines, so someone
else has to test/submit this one.

								Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
