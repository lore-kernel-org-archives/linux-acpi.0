From: Lu Tong <ltong-r3+FECOBLOPAaqN1iTbosg@public.gmane.org>
Subject: Re: Question about space handling
Date: Thu, 3 Apr 2003 13:05:01 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030403180501.GA17187@dao.cs.ohiou.edu>
References: <20030403023956.GA4679@dao.cs.ohiou.edu> <200304030358.h333wNj02932@throb.netspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200304030358.h333wNj02932-7GtV0IYKK74tA4QZiFxQkx2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 02, 2003 at 10:58:23PM -0500, bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org wrote:
> 
> I understand your theory on what's happening, but wouldn't we have the
> same problem if acpi_ec_add is being mistakenly called on
> address_space_handler? 

acpi_ec_add was called at the right time. look at my trace.

> Or some other reason the same structure is being
> assigned for both handlers (like a forgotten increment)?

it seems not the case according to my trace.
 
> I guess the place to start is to see where/when the "makeshift" ec
> handler is being installed, where/when the SystemMemory handler is
> being installed.  If they are being installed on top of each other,
> then it must be some kind of race condition or incrementation problem.

totally agree. wish i could have some time this weekend to work on this problem.good luck. 

--ltong


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
