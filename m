From: Vadim Zeitlin <vadim-oE/GLL+f5xMgsBAKwltoeQ@public.gmane.org>
Subject: Re[6]: HP nw8000 never wakes up from acpi suspend
Date: Sun, 10 Oct 2004 01:41:04 +0200 (Romance Daylight Time)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E1CGQpe-0001Ju-00@smtp.tt-solutions.com>
References: <3ACA40606221794F80A5670F0AF15F8405BD1229@pdsmsx403>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: INLINE
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8405BD1229@pdsmsx403>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 10 Oct 2004 00:21:16 +0800 "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

YL> >YL> It sounds like VGA issue.
YL> >
YL> > Is there any workaround?
YL> 
YL> Please reference document: linux/Documentation/power/video.txt

 Thank you, I read this and tried using acpi_sleep parameters as well as a
few other things but to no avail.

YL> Basically, we use this debug mechanism to debug ACPI subsystem itself.
YL> The suspend/resume issue is system wide. I guess these debug
YL> information will not help you, before you can affirm ACPI subsystem has
YL> bug.

 I'd really like to find some way to get more information about what's
going on. I must have rebooted ~50 times today (which is probably more than
during my last 8 or something years of using Linux extensively combined)
and this is just not the most effective way to debug :-(

YL> > What else can I do?
YL> 
YL> Maybe you need to remove some driver like USB.... , and make
YL> sure the resume process can reach some point.

 As I said, I unloaded everything, including USB, PCMCIA, sound, mouse and
network drivers. It didn't help at all, whatever point the resume reaches I
can't see it. I'd really like to fix this -- what use is a notebook which
can't be suspended/closed? -- but I have no idea about what else I could
do. I'll try contacting HP but I have little hope this can help.

 Anyhow, thanks again for your replies,
VZ



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
