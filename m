From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Wed, 4 Aug 2004 21:00:22 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408042100.24705.stefandoesinger@gmx.at>
References: <1091139240.26511.9.camel@6-allhosts> <1091631174.2297.90.camel@dhcppc4> <52654.199.172.169.15.1091641493.squirrel@webmail.localnet.com>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <52654.199.172.169.15.1091641493.squirrel-2RFepEojUI20LjuDPgauC1aTQe2KTcn/@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ole.rohne-vJEk5272eHo@public.gmane.org, erik-KVSZC2aA8+zw/snApU8qRLNAH6kLmebB@public.gmane.org, nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org, barr.156-ZbGKxL/pcrQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Mittwoch, 4. August 2004 19:44 schrieb count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org:
> This S3 resume POST patch has to go into the official ACPI/kernel
> source, just has to. POST'ing the video adapter on resume is
> absolutely fundamental. That some older non-Radeon cards can
> do without and we've gone this long without it is just amazing
> coincidence. This should go in right away, anything is better
> than nothing. -Huw
I think this patch only works for radeon cards, and not in all circumstances. 
It doesn't work for me(ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 
9000] (rev 01)). Strangely, user mode based VGA rom post works.

I am allready trying to debug this with Ole, but it seems that he's on 
holyday. Any ideas?

There is some resume code in drivers/video/aty/radeon_pm.c written by ATI, but 
it's only compiled on PowerMac and is only tested for <=R200 and S2.
I tried to activate it(remove arch and model checking), but it only made my 
display flash a few times. Perhaps we should ask ATI for help.

Stefan


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
