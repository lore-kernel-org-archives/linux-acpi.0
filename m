From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: S1 resume failes at hdc with Toshiba Satellite 3000
Date: Mon, 6 Oct 2003 15:53:42 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031006135342.GU11391@poupinou.org>
References: <20031004121942.GA2866@wsc-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031004121942.GA2866-u75qzGzWA6cb1SvskN2V4Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nikolaus Filus <NFilus-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Oct 04, 2003 at 02:19:42PM +0200, Nikolaus Filus wrote:
> Hi,
> 
...

> Oct  4 13:50:07 mobile kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
> 
> Oct  4 13:50:07 mobile kernel: cpufreq: No CPUs supporting ACPI performance management found.
> Oct  4 13:50:07 mobile kernel: BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
> Oct  4 13:50:07 mobile kernel: ACPI: (supports S0 S1 S3 S4 S5)
> 
> 
> BTW: I have a P3 Mobile CPU, why doesn't it support cpufreq?

It does, if you compile with the speedstep-ich driver instead of the
acpi one.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
