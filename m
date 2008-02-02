From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PATCH] thinkpad-acpi patches for 2.6.25
	(replaces batch 1)
Date: Fri, 1 Feb 2008 22:28:08 -0500
Message-ID: <200802012228.08452.lenb@kernel.org>
References: <1199804577-32017-1-git-send-email-hmh@hmh.eng.br>
	<200801240055.20906.lenb@kernel.org>
	<20080125192046.GA3972@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080125192046.GA3972-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Friday 25 January 2008 14:20, Henrique de Moraes Holschuh wrote:
> Len,
> 
> Given that there are four cleanup patches in the batch, I didn't even
> attempt to bother with checkpatch on anything before the "some checkpatch
> fluff" patch.  There are, for example, no tab/space problems in the final
> thinkpad_acpi.c file.
> 
> After the entire patchset is applied, there are still a few lines over 80
> chars, but that's because they are MUCH more readable the way they are in
> that particular hunk of code.
> 
> The braces checkpatch will complain about in the final thinkpad_acpi.c file
> are there for good reasons.  They are in points of the code where I expect a
> maintenance addition of one or two lines could happen, and that means any
> such patches would be a lot cleaner.   That warning is just weird, anyway.
> 
> There will be also an error about a macro needing do - while. Well, that one
> *does not* need it, and it is never used as a function.
> 
> So, please apply the entire set and check the final thinkpad_acpi.c file
> with checkpatch --file...  It is in *much* better state than what you got
> with that checkpatch run: 1 error and 12 warnings, which are all explained
> above.
> 
> Patches after the cleanups are checkpatch-clean (except for the details
> explained above).

applied.
thanks Henrique.

-Len


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
