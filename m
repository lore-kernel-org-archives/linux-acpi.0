From: Ralf Gerbig <rge-8kTjH38Bi09AfugRpC6u6w@public.gmane.org>
Subject: Re: Radeon M7 and resuming from suspend-to-ram
Date: Tue, 18 Jan 2005 23:11:21 +0100
Message-ID: <87k6qal75i.fsf-news@hsp-law.de>
References: <41E7D334.6060003@sllpilots.fi>
	<1105723866.28126.10.camel@elrond.flymine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1105723866.28126.10.camel-Xmbc1Sz64/5pghhO6/9/sx2eb7JE58TQ@public.gmane.org> (Matthew
 Garrett's message of "Fri, 14 Jan 2005 17:31:06 +0000")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

* Matthew Garrett writes:

> Try getting vbetool from http://www.srcf.ucam.org/~mjg59/vbetool and
> build it. On boot (before X is started), do 

Dammit, it does work on my Acer Travelmate 380. It took some idiot
hacks to compile on SuSE, but after calling 

chvt 1 
vbetool vbestate save > /tmp/vbestate

in /usr/lib/poewersave/scripts/prepare_suspend_to_ram and

vbetool vbestate restore < /tmp/vbestate
chvt 7

in /usr/lib/poewersave/scripts/restore_after_suspend_to_ram

the LCD becomes alive after suspend to ram.

Thanks for the good stuff,

Ralf
-- 
 P:     Linus Torvalds			patch-2.2.4
-S:     Buried alive in diapers
+S:     Buried alive in reporters


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
