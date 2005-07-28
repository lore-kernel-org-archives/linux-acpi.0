From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: git-acpi.patch failures (AE_NULL_OBJECT)
Date: Thu, 28 Jul 2005 12:58:11 -0700
Message-ID: <20050728125811.0bcc12ec.akpm@osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B30042CFE2F@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30042CFE2F-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
> > For a while now (days, at least) I've been getting a stream of ACPI
> > method execution failures due to the tree which I pull from
> > master.kernel.org:/pub/scm/linux/kernel/git/lenb/to-akpm.git
> 
> > This doesn't happen with current -linus.
> 
> > It's a fairly vanilla x86 PC which Intel is loaning me.
> 
> >[\_SB_.PCI0.USB_._S3D] (Node cff9c1a0), AE_NULL_OBJECT
> >    ACPI-0171: *** Error: Method execution failed 
> 
> Is the issue limited to these AE_NULL_OBJECT failure warnings,
> or did something functional break?

I'm not aware of any functional breakage, but I don't really use acpi on
this box, beyond `halt -p' and wake-on-LAN.

> Looks like the warnings are all related to _S3D -- which we use to
> determine the appropriate D-state upon suspend-to-ram.

OK..  But current -linus doesn't generate those warnings.

> Hmmm, I'm not seeing these -- maybe BIOS dependent.
> Can you check that you've got the latest BIOS for the box?

I wouldn't know where to get it from!  It's some no-name box which Sunil
sent me.

> If you do, can you stick the output from acpidmp or acpidump
> in a bugzilla?

hm, where do I find acpidmp or acpidump?


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
