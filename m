From: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: FYI: ACPI 'sleep 1' resets atkbd keycodes
Date: Sun, 25 Jan 2004 11:50:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040125105038.GA2014@ucw.cz>
References: <200401251137.21646.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200401251137.21646.p_christ-U04EIuiosng@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 25, 2004 at 11:37:19AM +0200, P. Christeas wrote:
> This may be just a minor issue:
> I had to use the setkeycodes utility to enable some extra keys (that weren't 
> mapped by kernel's atkbd tables).
> After waking from sleep 1, those keys were reset. That is, I had to use 
> 'setkeycodes' again to customize the tables again.
> 
> IMHO the way kernel works now is correct. It should *not* have extra code just 
> to handle that. Just make sure anybody that alters his kbd tables puts some 
> extra script to recover the tables after an ACPI wake.
> This should be more like a note to Linux distributors.

Hmm, I, on the other hand don't think it's correct. Because the kernel
has extra code to delete the tables on wake, which is wrong. Thanks for
noticing.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
