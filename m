From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: Re: RE: ACPI source releases updated (20030509)
Date: Tue, 13 May 2003 11:38:12 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0305131133540.10441@dynast.gaugusch.at>
References: <F760B14C9561B941B89469F59BA3A84725A299@orsmsx401.jf.intel.com>
 <b9pf9o$jjs$1@main.gmane.org> <20030513085421.GB1338@enigma.daemon.sh>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030513085421.GB1338-adzhR0EPeY/7X6WiDY61Ug@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On May 13, Sebastian Henschel <shensche-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org> wrote:
> on the other hand, this patch should not be necessary anyway. users
> should not patch part of their "bios" by themselves to get their system
> to work better. but this is how the situation currently looks like, as
> long as the vendors provide buggy DSDTs. i would consider the patch to
> be temporary, marked as soon-to-be-deleted. :)
Do you really think, that there will be no broken bios'es around any more
some day? Just a few weeks ago I fixed the dsdt of a 4 year old compaq
laptop. And I'm pretty sure that nobody will ever fix this DSDT at compaq
and provide a bios update ...

Another positive aspect of my patch is, that users can keep distribution
kernels and still override their DSDT. SuSE, Mandrake, etc. put a lot of
effort and good patches in their kernels and it is not always easy to
recompile them (at least it's very time consuming because of the huge
number of modules that is usually included). So, dsdt-in-initrd is one
reason less to compile your own kernel (or to be forced to do so).

Markus
-- 
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
                      / \


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
