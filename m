From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] s3_bios and lcall $0xc000,$3
Date: Tue, 18 Feb 2003 12:21:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030218112141.GC5277@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.33.0302171423290.21415-100000@godzilla.axis.se> <Pine.LNX.4.33.0302171647410.21415-100000@godzilla.axis.se> <20030217171610.GC25625@poup.poupinou.org> <1045505626.5596.20.camel@laptop-linux.cunninghams> <20030217235512.GA7372@atrey.karlin.mff.cuni.cz> <1045532563.2161.9.camel@laptop-linux.cunninghams> <1045534117.3556.12.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1045534117.3556.12.camel-udXHSmD1qAz9bBlWBkG5g4WQyAnV0byH@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > I'm talking about S3 (sorry typo before when I said S4==S5) - if I've
> > read the specs right (and experience does match this), the i830 video
> > card looses all state when switched to S3.
> 
> Sorry about replying to myself, but here are some extracts. I'm not at
> all an expert on drivers, so I'll freely admit that I might be
> misunderstanding these.
> 
> Page 1:
> Intel? 830 Chipset Family: 82830
> Graphics and Memory Controller
> Hub (GMCH-M)
> Datasheet
> January 2002
> Order Number: 298338-003
> 
> Page 180 says:
> G1/S3: Power and context lost to chipset.
> 
> Page 184 adds...
> 
> The final level of power savings for the Intel 830 Chipset family GMCH-M
> is achievable when the Host Clock, Memory Group, and I/O clock group
> clocks are shutdown and the GMCH-M is powered down. This occurs when the
> system transitions to the S3 state. During transition to the S3 state,
> first the STPCLK# is asserted and the Stop Grant cycle snooped by the
> GMCH-M and forwarded over Hub interface where it is received by the
> ICH3-M. At this point the GMCH-M is functioning in the C2 State. The
> GMCH-M places all of the SDRAM components into the self-refresh mode.
> After the GMCH-M has placed all of the SDRAM components in self refresh,
> it is safe to enter the STR State. The ICH3-M will then assert a signal,
> SLP_S1#, to the clock synthesizer to shutdown all of the clocks in the
> Host and Memory Clock Groups. The GMCH-M will assume that no AGP,
> AGP/PCI, or hub interface cycle (except special cycles) will occur while
> the GMCH-M is in the C3 State. The processor cannot snoop its caches to
> maintain coherency while in the C3 State. GMCH-M contains no isolation
> circuitry and MUST be powered down once STR is reached. If GMCHM is
> powered up and driving outputs to devices that are powered down,
> component damage will result.
> 
> (You may remember me talking a while ago about lspci -vv not even
> looking sane after resume. I guess this is the cause).

:-( This is too deep magic even for me.

								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
