From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Radeon M7 and resuming from suspend-to-ram
Date: Thu, 03 Feb 2005 22:07:13 +0100
Message-ID: <42029281.3070207@gmx.net>
References: <41E7D334.6060003@sllpilots.fi>	<1105723866.28126.10.camel@elrond.flymine.org>	<87k6qal75i.fsf-news@hsp-law.de> <1106095573.7368.29.camel@tyrosine> <87ekghkwt0.fsf-news@hsp-law.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <87ekghkwt0.fsf-news-ihuhiKcgPLSELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ralf Gerbig <rge-8kTjH38Bi09AfugRpC6u6w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Ralf Gerbig schrieb:
> * Matthew Garrett writes:
> 
>>On Tue, 2005-01-18 at 23:11 +0100, Ralf Gerbig wrote:
>>
>>>chvt 1 
>>>vbetool vbestate save > /tmp/vbestate
>>>
>>>in /usr/lib/poewersave/scripts/prepare_suspend_to_ram and
>>>
>>>vbetool vbestate restore < /tmp/vbestate
>>>chvt 7
>>>
>>>in /usr/lib/poewersave/scripts/restore_after_suspend_to_ram
>>>
>>>the LCD becomes alive after suspend to ram.
> 
> 
>>Excellent. So far, the best solution we've found is to save the vbestate
>>on boot rather than on suspend. There's a small number of machines that
>>this hangs on, irritatingly, but I'm trying to track them down. It seems
>>far more successful than using video_post for the most part.
> 
> 
> Last night I was too dumbfounded that it actually worked to include
> any details.
> 
[...]
> 
> SuSE does not have a shared libpci, only static so the precompiled
> binary unsurprisingly did not work.
> 
> Compiling the source I got: 
> 
> rge@lapdog2:/usr/src/vbetool-0.2> make
> if gcc -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" 
> -DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\" -DPACKAGE=\"vbetool\" 
> -DVERSION=\"0.2\"  -I. -I.    
> -g -Wall -Werror -pedantic -g -O2 -MT vbetool.o -MD -MP -MF ".deps/vbetool.Tpo" \
>   -c -o vbetool.o `test -f 'vbetool.c' || echo './'`vbetool.c; \
> then mv -f ".deps/vbetool.Tpo" ".deps/vbetool.Po"; \
> else rm -f ".deps/vbetool.Tpo"; exit 1; \
> fi
> In file included from /usr/include/stdlib.h:416,
>                  from vbetool.c:14:
> /usr/include/sys/types.h:62: error: conflicting types for `dev_t'
> /usr/include/linux/types.h:22: error: previous declaration of `dev_t'
> [...]

Yes, the pci.h shipped by SUSE has problems. Simply move the #include
<pci/pci.h> from the beginning to directly before #include <sys/kd.h>

> after fuzing around with -D, I temporally commented out the
> include. Thereafter adding -lpci to the end of the link command, I got
> a working executable.

This is a bug in Makefile.am. Pseudo-diff:

-AM_LDFLAGS = -lpci
+LIBS = -lpci

Then run aclocal, autoconf and automake again.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
