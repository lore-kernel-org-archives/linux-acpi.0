From: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Subject: Toshiba hwclock problems
Date: Thu, 8 May 2003 11:24:15 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305081123.14153.mflt1@micrologica.com.hk>
References: <Pine.LNX.4.21.0305072228010.15977-100000@vista.rtm.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.21.0305072228010.15977-100000-fIJwbSqd/OutujjWdiIZrQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rob Miller <rob-7HoZ3oJp7ZtBDgjK7y7TUQ@public.gmane.org>
Cc: swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 08 May 2003 05:29, Rob Miller wrote:
> > BTW, you had no hwclock hang with acpi20030424 requiring reset?
>
> Ah, I was unable to get acpi20030424 to work with swsusp, perhaps
> this was the problem -- though I didn't see anything to make me
> think of this when I saw the mention of hwclock problems on this
> list.  The only references to hwclock I see on the ACPI list are
> 'hwclock --hctosys', but this doesn't seem to resolve a sysetm hang
> issue -- can you supply another pointer to this fix ?
>

Got a RH9-pre  installation

My L2 Hung in rc.sysinit at hwclock and would have hung also in 
halt at hwclock.

Nigel pointed out to add --directisa to hwclock entries in scripts, (going directly to isa hw)

It works for me.

You could grep for hwclock in your init scripts and add --directisa

Regards
Michael





-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
