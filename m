From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Re: Clevo 650 Notebook: LCD not working after resume from S3
Date: Sun, 10 Jul 2005 07:28:51 +0200
Message-ID: <20050710052851.GA27772@tangens.sinus.cz>
References: <20050707155839.GA12706@tangens.sinus.cz> <20050709120030.GE1878@elf.ucw.cz>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050709120030.GE1878-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Hi!
> 
> >   I would like to ask here, because all my semi-amateur attempts to fix the
> > problem described below have failed.
> >   I have a Mironet notebook, which seems to be relabelled Clevo 650.
> >   I can use almost all advantages of its ACPI features, excluding one: the
> > "suspend to memory" (S3) feature. To be more precise, suspend itself seems
> > to work perfectly, but the following resume fails in a way that it doesn't
> > enable the LCD panel. I tried my best to find the problem and fix
> 
> See Doc*/power/video.txt (and mail me a patch when you get it working).
> 
> 									Pavel
Hi Pavel, Hi all the acpi folks,
  thanks, I thought I've read all from Doc* which is related to the problem but
I evidently didn't :-). 
  So, s3_bios is the right formula for me. Interesting is, that after resume
from s3_bios sleep the display is not working as well, but it CAN be revived by
switching from sisfb console to X (provided it was in the console mode during
the sleep) and even the switch back to sisfb works well so the display is fully
operable. With normal s3, even this manipulation didn't revive the display.
  So I wrote my lid switch event script that it calls chvt to the text console
before the sleep and calls chvt to X after the wakeup and it works really well.
  However, I've found another quirks with S3 sleep regarding USB, which I
solved by modularizing ohci-hcd and by unloading it before the sleep so it
doesn't matter actually.

                        Regards, Pavel Troller


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
