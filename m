From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] s3_bios and lcall $0xc000,$3
Date: 18 Feb 2003 16:56:47 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1045587407.2231.2.camel@passion.cambridge.redhat.com>
References: <20030218000206.GC7372@atrey.karlin.mff.cuni.cz>
	 <Pine.LNX.4.33.0302180216520.21776-100000@godzilla.axis.se>
	 <20030218111954.GB5277@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030218111954.GB5277-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2003-02-18 at 11:19, Pavel Machek wrote:
> > It seems pretty bleak since for example the reason I needed s3_bios on the 
> > travelmate was because the TFT did not want to come on by just doing the int 
> > 0x10h call or the VESA set video mode call. Some other magic was needed 
> > which apparently the lcall did. And we can't really have specific VGA wakeup 
> > codes for every possible card or laptop.. I tried searching the ralph brown 
> > irq list for that lcall but could not find any - what documentation did you 
> > dig up this magic call from ? :))
> 
> Its call bios uses to initialize video roms. It really should be in
> interrupt list somewhere. [Someone helped me with that].

Not just video ROMS -- it's the way the BIOS handles _all_ BIOS
extensions -- SCSI drivers, network boot roms, etc. It scans from
0xC0000 up to 0xE0000 in steps of (IIRC) 0x2000, checking for a 
'0x55 0xaa' signature and jumping to offset 0003 in the relevant segment
if it finds such. Your video BIOS generally lives at segment 0xC000, and
when run it will initialise the hardware and install itself on the INT
10h vector for later use.

-- 
dwmw2


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
