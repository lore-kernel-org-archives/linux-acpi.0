From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ACPI patch status (2.6)
Date: Tue, 30 Sep 2003 09:07:06 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030930070706.GB8827@wotan.suse.de>
References: <1064902694.2535.159.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1064902694.2535.159.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 30, 2003 at 02:18:14AM -0400, Brown, Len wrote:
> FYI,
> The following changes are currently in the ACPI test tree
> http://linux-acpi.bkbits.net/linux-acpi-test-2.6.0
> available for testing before push to 2.6.0
> 
> The associated plain patches are also available here:
> ftp.kernel.org:/pub/linux/kernel/people/lenb/acpi/patches/test/
> 
> Yes, it has been too long since the last push into 2.6.
> The good news is that we'll have finally got 2.6 back in sync with 2.4.
> 
> If you seen any regressions, please let me know.

My ACPI tolerant patch is not included. Without this it will not boot
on many HP servers and some other multiprocessor boxes.

-Andi


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
