From: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: S3 resume problems on HP compaq nc4010
Date: Mon, 10 May 2004 13:32:47 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1084157331.20487.41.camel@laptop-linux.wpcb.org.au>
References: <1083777804.4093.71.camel@descent.netsplit.com>
	 <20040509015516.GA5487@elf.ucw.cz> <1084117826.2372.32.camel@syndicate>
	 <20040509213919.GA13603@atrey.karlin.mff.cuni.cz>
	 <1084139548.14657.4.camel@syndicate>
	 <20040509215621.GB15307@atrey.karlin.mff.cuni.cz>
	 <1084140024.14657.8.camel@syndicate>
	 <20040509232856.GA2504@atrey.karlin.mff.cuni.cz>
Reply-To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040509232856.GA2504-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Scott James Remnant <scott-Umf49k1wg4FWk0Htik3J/w@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Mon, 2004-05-10 at 09:28, Pavel Machek wrote:
> > > * due to video issues, swsusp should be easier to get working than
> > >   S3. Try that first.
> > > 
> > Doesn't work either.  I got swsusp2 to work, but that has to shut down X
> > and unload all the modules otherwise it won't resume; and that takes
> > longer than a simple shutdown and boot -- so I abandoned it.  Plus it
> > scared me -- too much pretty :)
> 
> Can you try just without dri/agp with swsusp2? That might do the
> trick. Try to locate exactly which modules cause problems.

It should work fine without having to shutdown X, and even better now we
have last week's pagedir patch applied.

> dri/agp are known offenders, and fix is known by now.
> 
> Complain to Nigel about prettyness... I certainly did ;-).

You can't please everyone :> If you want it to look ugly, turn on
debugging info!

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
