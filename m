From: Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was: Re: Resume from Suspend to RAM))
Date: Mon, 13 Jun 2005 12:55:46 +0200
Message-ID: <200506131255.47223.hugelmopf@web.de>
References: <200506061531.41132.stefandoesinger@gmx.at> <200506122255.38020.chefturner@web.de> <878y1fjltd.fsf@www.codersbase.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <878y1fjltd.fsf-mMfbam+mt929kzlf/Hu3QdBPR1lH4CV8@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Jason Dagit <dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org>, Christoph Tavan <chefturner-S0/GAf8tV78@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> What is your version of gcc?  I just got around to trying this patch
> out today using 2.6.12-rc6 and everything worked great.  In fact, the
> patch even does the suspend/resume correctly.  Now, it doesn't
> actually go to sleep so it's not useful, but it was just for
> testing/debugging right?
>
> I'm using gcc 3.3.5 (Debian 1:3.3.5-13).
>
> >> Would you mind posting the patch as attachment and the exact
> >> command I have to issue in my kernel directory?
> >
> > That would be great!!!
>
> the command I used from linux-2.6.12-rc6/ was:
> patch drivers/acpi/hardware/hwsleep.c patch-s3.diff
>
> that assumes patch-s3.diff is in the linux-2.6.12-rc6 directory.  I'm
> also attaching the patch file again as you requested.

Thanks a lot ... it works now. I guess, when copy-pasting, some tabs got lost, 
which confused the patching.

Now patching as well as compiling (with Debian gcc 3.3.5) works.

Will post resume-results after reboot.

Thanks,
Frank


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
