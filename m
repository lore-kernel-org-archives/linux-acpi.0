From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 resume on Omnibook XE3-GF
Date: Mon, 29 Jul 2002 13:00:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020729110018.GC835@atrey.karlin.mff.cuni.cz>
References: <20020726104037.GC279@elf.ucw.cz> <000901c234df$a524d100$0201010a@cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000901c234df$a524d100$0201010a-39LOpZwlz18NEHC595MGIQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Cc: "'ACPI List (E-mail)'" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> Quite apart from this, the video card (i830mg) seems to need to be
> completely reinitialised. I downloaded a document from Intel on the video
> card, but I'm not knowledgable enough to be able to use it (I got the idea
> that it needs to be reinitialised from this documents - it talks about S3
> putting the card in the same state as S5).
> 
> The system also runs very slowly. It looks like this could be CPU throttling
> because even a beep gets made long. The DSDT includes a hint that there is
> throttling, but no actual methods, so I can't use /proc/acpi to
> reset it.

Can you check that sleep 1; echo foo takes one second? It is possible
that clock is not reinitialized correctly.

> That's all I know about - there may of course be more.
> 
> I am, of course, happy to send and try anything you want that will help in
> dealing with these issues. Just ask.

									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
