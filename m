From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Still problems with ACPI sleep state
Date: Fri, 25 Jun 2004 23:30:35 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040625232835.R6228@root.org>
References: <200406251547.21050.mailinglisten@merula.de> <1088172763.1918.1.camel@camel>
 <20040625211440.P5510@root.org> <opr96uc8fj4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <opr96uc8fj4evsfm-TBR8pM7LtsqkE96DxU8f+dAkNl5+tjhE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Frank <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

[context recovered]
On Sat, 26 Jun 2004, Michael Frank wrote:
> On Fri, 25 Jun 2004 21:15:21 -0700 (PDT), Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org> wrote:
> > On Fri, 25 Jun 2004, Herman Sheremetyev wrote:
> >> Try booting with acpi_sleep=s3_bios, I had the same problem on my Asus
> >> M6N and that made the LCD come back on after an S3 resume.
> >>
> >> -Herman
> >
> > Could someone familiar with Linux let me know what s3_bios does
> > differently from a normal S3?
> >
> > -Nate
>
> The suspend is performed in the BIOS without OS interaction.
>
> BIOS grabs CPU/its state, suspends devices, saves state,  powers down
> and on powerup restores state, resumes devices, releases its state/CPU.
>
> (more or less)
>
> In short, BIOS does all the work. Used to be like that before ACPI.
> And few systems do it now like that...

I could use a bit more technical response.  For instance, are SLP_TYP_A/B
written to a different register?  If so, which?  Does the system
transition to legacy mode (disabling ACPI), trigger APM suspend, then
re-enable ACPI on resume?  What caveats are there?

-Nate


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
