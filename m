From: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>
Subject: [PATCH] s3_bios and lcall $0xc000,$3
Date: Mon, 17 Feb 2003 16:53:16 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302171647410.21415-100000@godzilla.axis.se>
References: <Pine.LNX.4.33.0302171423290.21415-100000@godzilla.axis.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.33.0302171423290.21415-100000-Hi2dXqvvzfEtpH44vsTDoQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 17 Feb 2003, Bjorn Wesen wrote:
> I'm guessing that the bios call corrupt some data segment pointers, because 
> if I print out any of the real_save_* values, they are all zero! WHich 
> obviously causes a crash when you load up a zero GDT, zero CR0, zero CR4 
> etc... 

Yup - the s3_bios triggered lcall corrupts DS (and possibly SS) as well. CS 
is still alive though so redoing the CS->DS duplicating worked.. the 
following is not in patch format but you get the idea :)

	lcall   $0xc000,$3

+       # reset the data and stack segments after possible bios tampering
+       movw    %cs, %ax
+       movw    %ax, %ds
+       movw    %ax, %ss

So now S3 resume works on the travelmate 630! :)

However, the IDE system (using DMA) seems to not survive the resume. WHat is 
the current status of fixing that ? (kernel 2.5.61)

/Bjorn




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
