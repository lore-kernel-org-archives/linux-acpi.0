From: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: Success with kernel-swsusp and Nvidia-closed-source
Date: Thu, 04 Nov 2004 13:11:07 +1100
Message-ID: <1099534267.3991.52.camel@desktop.cunninghams>
References: <Pine.LNX.4.60.0411031215260.1187@frog.athome>
	 <200411031958.47910.christian.hesse@linuxob.de>
	 <Pine.LNX.4.60.0411032322410.4984@frog.athome>
Reply-To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0411032322410.4984-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: Christian Hesse <christian.hesse-5lmcC6f56PSELgA04lAiVw@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi.

On Thu, 2004-11-04 at 09:29, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Salut Christian,
> On Wed, 3 Nov 2004, Christian Hesse wrote:
> > I'm using software suspend 2.1. For me suspend works fine, but the system
> > freezes as soon as it is resumed, I only see a black screen then. Driver nv
> > works without any problems. Any hints what could be the cause?
> I did not patch in anything into the kernel. I used a vanilla 2.6.9 (only 
> the Makefile was patched to show 2.6.9 instead of 8 ... maybe somebody 
> watched a bit too much tv... :-)
> So I did not use swsusp 2.1. And I could not manage to freeze on resume 
> this time. So, why didn't you try the vanilla-kernel, with the 
> Haggi' s patch for the nvidia driver?
> When you test - be sure to sync before suspending. It's the second best, 
> besides having a jung backup handy.

I guess I'm doing something driver related that Pavel isn't or vv :>.
Can I get a pointer to the driver source?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
