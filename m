From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: RE: ACPI source releases updated (20030509)
Date: Wed, 14 May 2003 13:12:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030514111215.GR19475@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A84725A299@orsmsx401.jf.intel.com> <b9pf9o$jjs$1@main.gmane.org> <20030513085421.GB1338@enigma.daemon.sh> <b9re0e$u0h$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b9re0e$u0h$1@main.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Gray <n8gray-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, May 13, 2003 at 11:38:40AM -0700, Nathan Gray wrote:
> Sebastian Henschel wrote:
> > on the other hand, this patch should not be necessary anyway. users
> > should not patch part of their "bios" by themselves to get their system
> > to work better. but this is how the situation currently looks like, as
> > long as the vendors provide buggy DSDTs. i would consider the patch to
> > be temporary, marked as soon-to-be-deleted. :)
> 
> I think I would like to see this patch included even if vendors supplied
> perfectly good DSDTs.  It's kind of interesting to hack on these things and
> it could allow the enterprising hacker to improve the functionality of her
> machine.  For example, on my machine Dell has put almost every device on
> interrupt 11 without giving me any way to change them.  I'm not an expert,
> but from what I've seen in the ACPI spec I think it might be possible for
> me to override this decision by hacking the DSDT.
> 
> In short, open source is all about hacking and so is this patch. :-)
> 
> I think the only criticism I have of this patch is that (IMVeryHO) it
> doesn't strike me as suitable for long-term inclusion in the kernel.  I
> imagine it would be better to allow the user to specify dsdt=/boot/dsdt.img
> in the same way he specifies initrd=/boot/initrd.img so that these two
> things can be kept cleanly separated.

IMHO, it should be even better to have something like
acpi_tables=/boot/acpi_tables.img (not as a kernel option)

with different tables, not only DSDT.


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
