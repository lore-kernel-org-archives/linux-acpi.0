From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: PBLK length again
Date: Wed, 23 Jun 2004 13:32:08 -0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040623133208.GA3152@message-id.gmane0305.slipkontur.de>
References: <BAY16-F112kKIBXEHt30004aded@hotmail.com> <20040620154726.GT20511@parcelfarce.linux.theplanet.co.uk> <1087770015.23371.27.camel@djinn> <40D73F9E.4030805@pca.it> <1087850404.2501.43.camel@camel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1087850404.2501.43.camel-O4LVqDAXoJg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 21, 2004 at 04:40:04PM -0400, Herman Sheremetyev wrote:

> From the research I've done I am fairly certain that 7 is not a legal
> value but Asus insists on breaking the spec by sticking 5's and 7's in
> PBLK length even though they mean 6, and Windows doesn't seem to mind. 
> There should be a way for Linux to deal with this too I think.

IIRC there was a discussion on this list some time ago and the outcome was,
that intel once shipped a "BIOS programmers guide" which told that 7 was
allowed. Later they changed their mind and decided only 6 was correct.
So there was some consent that 7 should also be allowed in the linux
implementation. Unfortunately nobody ever implemeted it.
This is all IIRC, YMMV.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
