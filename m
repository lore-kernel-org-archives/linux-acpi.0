From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: problem with cpu eating too much power, prize given if solved
Date: Wed, 30 Jun 2004 21:37:39 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040630193739.GC12631@elf.ucw.cz>
References: <20040624153513.GB19545@rap.rap.dk> <20040628204008.GK698@openzaurus.ucw.cz> <opsadhbojo4evsfm@smtp.pacific.net.th> <20040629221111.GB25464@elf.ucw.cz> <opsaeu9tyb4evsfm@smtp.pacific.net.th> <20040630173754.GA29587@rap.rap.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040630173754.GA29587-EittdKFJ/bZ/SzgSGea1oA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Keld J?rn Simonsen <keld-6PR53cSIHaE@public.gmane.org>
Cc: Michael Frank <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Please refer to http://acpi.sourceforge.net/documentation/sleep.html
> > and ACPI spec 2.0a around Page 216
> > 
> > "Sleep States
> > 	S1 - "Stopgrant"
> > 	Power to cpu is maintained, but no instructions are executed.
> > 	The CPU halts itself and may shut down many of its internal
> > 	 components. In Microsoft Windows, the "Standby" command
> > 	is associated with this state by default.
> > "
> 
> Well, I think what I want is S2, from the same document:
> 
>      S2
> 
>      While defined in the spec, this state is not currently in use. It
>      resembles S3 with the qualification that some devices are permitted to
>      remain on.
...

> I would like the CPU to power down, save things in memory, and then
> still have the screen and associated hardware on, and possibly also the
> keyboard and mouse if that is needed to capture an ACPI event, including
> the actual keystroke. This seems to be S2. I am not sure if all of S2
> needs to be implemented to do what I asked for, I just would like the
> functionality I described.

Unfortunately, your machine does not support S2. Actually, I do not
know any machine that does.

> > So again, which (mainboard/notebook) HW does depower the CPU and keeps the 
> > rest running ?
> 
> I thought this was something that most mainboards would support, given
> that we make the appropiate SW in the kernel. 
> 
> Another thing is that if a mainboard/BIOS supports ACPI, then it should
> actually support all of ACPI, including S2 support. Or am I wrong?

You are wrong at this. It is completely okay to support ACPI but no
sleep states at all (for example).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
