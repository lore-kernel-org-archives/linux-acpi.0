From: Christoph Tavan <chefturner-S0/GAf8tV78@public.gmane.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was: Re: Resume from Suspend to RAM))
Date: Mon, 13 Jun 2005 01:01:19 +0200
Message-ID: <200506130101.20005.chefturner@web.de>
References: <200506061531.41132.stefandoesinger@gmx.at> <200506122255.38020.chefturner@web.de> <878y1fjltd.fsf@www.codersbase.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
List-Id: linux-acpi@vger.kernel.org

Hello!

On Sunday 12 June 2005 23:40, Jason Dagit wrote:
> >> Would you mind posting the patch as attachment and the exact
> >> command I have to issue in my kernel directory?
> >
> > That would be great!!!
>
> the command I used from linux-2.6.12-rc6/ was:
> patch drivers/acpi/hardware/hwsleep.c patch-s3.diff
>
> that assumes patch-s3.diff is in the linux-2.6.12-rc6 directory. =A0I'm
> also attaching the patch file again as you requested.

Patching mm-sources-2.6.12-rc4 this way went fine now!

My Samsung X30 Laptop "suspends" and "resumes" fine with the patch, so=20
kernel-code seems to be OK.

When I boot it with init=3D/bin/bash without the patch, it also seems to su=
spend=20
and resume fine except for the display which stays black. Everything else=20
seems to work: I can type "reboot" and the machine reboots properly!

Any ideas?

Thanks, Christoph Tavan


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
