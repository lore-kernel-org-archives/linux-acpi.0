From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Radeon M7 and resuming from suspend-to-ram
Date: Wed, 19 Jan 2005 00:46:13 +0000
Message-ID: <1106095573.7368.29.camel@tyrosine>
References: <41E7D334.6060003@sllpilots.fi>
	 <1105723866.28126.10.camel@elrond.flymine.org>
	 <87k6qal75i.fsf-news@hsp-law.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87k6qal75i.fsf-news-ihuhiKcgPLSELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-01-18 at 23:11 +0100, Ralf Gerbig wrote:

> chvt 1 
> vbetool vbestate save > /tmp/vbestate
> 
> in /usr/lib/poewersave/scripts/prepare_suspend_to_ram and
> 
> vbetool vbestate restore < /tmp/vbestate
> chvt 7
> 
> in /usr/lib/poewersave/scripts/restore_after_suspend_to_ram
> 
> the LCD becomes alive after suspend to ram.

Excellent. So far, the best solution we've found is to save the vbestate
on boot rather than on suspend. There's a small number of machines that
this hangs on, irritatingly, but I'm trying to track them down. It seems
far more successful than using video_post for the most part.
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
