From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Resume -> higher power drain?
Date: Sat, 7 May 2005 22:02:25 +0200
Message-ID: <20050507200225.GB8212@elf.ucw.cz>
References: <427CC869.1050506@kernelconcepts.de> <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net> <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net> <1115475297.10424.4.camel@localhost> <20050507144417.GA3100@isilmar.linta.de> <427CDE7B.5040306@kernelconcepts.de> <427CE3EF.1010005@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <427CE3EF.1010005-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, Hendrik =?iso-8859-1?Q?J=FCrgens?= <hjuerg-ULHALamj7Vx/+Jgy1241yg@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> >>>Also, does the bus master activity rates typically seen (check 
> >>>/proc/acpi/processor/*/power every once in a while) differ
> >>>between pre-suspend and post-suspend?
> > This again is interesting!
> > What does this bus master activity indicate?
> > 
> > Before suspend I see the CPU sporadically changing from C2 to C3 and
> > back and bus master activity to have values between 00000000 and some
> > higher values on activity, like 00200000 or even f0000000.
> > 
> > After suspend/resume this changed!
> > The CPU is now fixed at C2 and does not switch between C2 and C3.
> > Also the bus master activity is ffffffff in idle state and changes to
> > strange values on activity, like f7ffffff - quite different than before.
> 
> OK, just fixed this ;)
> 
> The problem seemed to be related to suspend/resume scripts, so to say. I
> did enable vbetool to save/restore VESA state and doing vbetool post.
> 
> Using s3_bios resume this is not necessary!
> 
> And after disabling vbetool usage at all the bus master activity is back
> to normal again after resume!
> 
> So at least for my T42p I can recommend NOT to use vbetool at all for
> suspend/resume but rather to use s3_bios!

Can you suggest a patch to Documentation/power/video.txt?
								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
