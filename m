From: Nathan Gray <n8gray-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
Subject: Re: RE: ACPI source releases updated (20030509)
Date: Tue, 13 May 2003 11:38:40 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <b9re0e$u0h$1@main.gmane.org>
References: <F760B14C9561B941B89469F59BA3A84725A299@orsmsx401.jf.intel.com> <b9pf9o$jjs$1@main.gmane.org> <20030513085421.GB1338@enigma.daemon.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Sebastian Henschel wrote:
> on the other hand, this patch should not be necessary anyway. users
> should not patch part of their "bios" by themselves to get their system
> to work better. but this is how the situation currently looks like, as
> long as the vendors provide buggy DSDTs. i would consider the patch to
> be temporary, marked as soon-to-be-deleted. :)

I think I would like to see this patch included even if vendors supplied
perfectly good DSDTs.  It's kind of interesting to hack on these things and
it could allow the enterprising hacker to improve the functionality of her
machine.  For example, on my machine Dell has put almost every device on
interrupt 11 without giving me any way to change them.  I'm not an expert,
but from what I've seen in the ACPI spec I think it might be possible for
me to override this decision by hacking the DSDT.

In short, open source is all about hacking and so is this patch. :-)

I think the only criticism I have of this patch is that (IMVeryHO) it
doesn't strike me as suitable for long-term inclusion in the kernel.  I
imagine it would be better to allow the user to specify dsdt=/boot/dsdt.img
in the same way he specifies initrd=/boot/initrd.img so that these two
things can be kept cleanly separated.

Cheers,
-n8

-- 
>>>-- Nathaniel Gray -- Caltech Computer Science ------>
>>>-- Mojave Project -- http://mojave.cs.caltech.edu -->



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
