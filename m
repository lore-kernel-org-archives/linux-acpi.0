From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: problem with cpu eating too much power, prize given if solved
Date: Wed, 30 Jun 2004 21:35:03 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040630193502.GB12631@elf.ucw.cz>
References: <20040624153513.GB19545@rap.rap.dk> <20040628204008.GK698@openzaurus.ucw.cz> <opsadhbojo4evsfm@smtp.pacific.net.th> <20040629221111.GB25464@elf.ucw.cz> <opsaeu9tyb4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <opsaeu9tyb4evsfm-TBR8pM7LtsqkE96DxU8f+dAkNl5+tjhE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Frank <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Cc: keld-6PR53cSIHaE@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Please refer to http://acpi.sourceforge.net/documentation/sleep.html
> and ACPI spec 2.0a around Page 216
> 
> "Sleep States
> 	S1 - "Stopgrant"
> 	Power to cpu is maintained, but no instructions are executed.
> 	The CPU halts itself and may shut down many of its internal
> 	 components. In Microsoft Windows, the "Standby" command
> 	is associated with this state by default.
> "
> 
> If you look at the original post, S1 "Stopgrant" costs 5W on his celeron. 
> It takes a lot
> more on many 90nm chips. I read in the Centrino datasheet that it can draw 
> 15W
> stopgrant at  _maximum_ vcore!!!. The maximum  possible power consumption 
> is only 25W!.
> Now, that is life with modern CMOS, leakage is most of the power 
> consumption....
> I think it will improve but 1:3 is the best you can expect for multi GHZ 
> CPU's.
> 
> The transmeta i am  typing takes only 0.5W in Stopgrant but is performace 
> is much less at
> "full power" of 5W/600MHz. Its standby to full power ration is 1:10, vs 2:3 
> for P4EE's...
> 
> So again, which (mainboard/notebook) HW does depower the CPU and keeps the 
> rest running ?

> As to ACPI there should be a S2.5 state, or a S3 extension to power down 
> the CPU and run the rest...

Does not that look close to S2?

> So, I stick to the validity of my original post :)

Okay, looks like I was wrong.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
