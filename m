From: Flavio Bruno Leitner <fbl-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
Subject: Re: missing cmpxchg on i386.
Date: Tue, 30 Mar 2004 10:15:08 -0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040330131508.GA3844@conectiva.com.br>
References: <20040324162347.GA10134@conectiva.com.br> <20040330123735.GD461@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040330123735.GD461-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 30, 2004 at 02:37:35PM +0200, Pavel Machek wrote:
> On St 24-03-04 13:23:47, Flavio Bruno Leitner wrote:
> > 
> > Compiling for i386 I got a lot of 
> > include/asm/acpi.h: In function `__acpi_acquire_global_lock`:
> > include/asm/acpi.h:74: warning: implict declaration of function 'cmpxchg' 
> 
> Try compiling for pentium+...

It's impossible, we need to have kernel optimized for i386.
I revert the ChangeSet 1.1557.83.7 until this get fixed.

-- 
Flávio Bruno Leitner <fbl-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
[ E74B 0BD0 5E05 C385 239E  531C BC17 D670 7FF0 A9E0 ]


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
