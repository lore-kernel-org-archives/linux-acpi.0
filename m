From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Radeon PM Support
Date: 04 Aug 2004 10:52:54 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1091631174.2297.90.camel@dhcppc4>
References: <1091139240.26511.9.camel@6-allhosts>
	 <20040730141028.GE21359@luna.mooo.com><20040730162756.4f300a5c@localhost>
	 <20040730190047.GH21359@luna.mooo.com>
	<1091560208.24759.15.camel@6-allhosts> <41103952.2030707@optonline.net>
	 <1091583216.2974.2.camel@localhost.localdomain>
	 <1091590835.2304.64.camel@dhcppc4>  <yzohdrjqu6p.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <yzohdrjqu6p.fsf-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ole.rohne-vJEk5272eHo@public.gmane.org
Cc: Acpi Devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Erik Tews <erik-KVSZC2aA8+zw/snApU8qRLNAH6kLmebB@public.gmane.org>, Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>, Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-08-04 at 02:43, ole.rohne-vJEk5272eHo@public.gmane.org wrote:
> Len> Some folks have had good luck getting Radeon to resume
> Len> after applying this patch.  I saw it fix a Dell 600m/Radeon.
> 
> Len> http://lists.debian.org/debian-x/2004/03/msg03482.html
> 
> The same folks were even happier with a more recent patch that moves
> the S3 resume POST where really belongs: into kernel space:
> 
> <http://article.gmane.org/gmane.linux.acpi.devel/8879>

Thanks Ole, for pointing that out.
I too would prefer a kernel-based solution that
applies to all video adapters.  I would
like a solution that applies to x86_64
in addition to i386.

I saw the note about this patch fixing the dell 600m
with the Radeon 9000.  I haven't yet seen reports of it
fixing other system's video on S3 resume, including
the Radeon 7000 that is the subject of this thread.
Can you summarize the feedback you've got so far?

Can you re-post the cleaned up patch?
Maybe good to go to lkml with it for broader review
and feedback.

thanks,
-Len




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
