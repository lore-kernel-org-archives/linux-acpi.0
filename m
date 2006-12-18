From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend to RAM on lifebook 7110
Date: Mon, 18 Dec 2006 13:16:45 +0100
Message-ID: <20061218121645.GD2000@elf.ucw.cz>
References: <20061208123358.GA3724@invalid.invalid>
	<20061208211308.GA5157@erebor.ics.muni.cz>
	<20061218065136.GG26170@suse.de>
	<20061218111142.GA27070@srcf.ucam.org>
	<20061218112916.GB6636@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20061218112916.GB6636@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Stefan Seyfried <seife@suse.de>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Miroslav Ruda <ruda@ics.muni.cz>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> thanks for explaining this, i am obviously not too deep into that
> PCI bus stuff :-)
> 
...
> > > I thought that this should somehow go away by the PCI bus suspend/resume
> > > methods that somewhen back got merged by Greg K-H.
> > 
> > The kernel will only save and restore the standardised PCI configuration 
> > registers - anything else needs to be handled by the specific device 
> > driver. Unfortunately, in the graphics hardware case, the closest thing 
> > to that is the framebuffer driver. Which we don't tend to use.
> 
> So the question is: should we either
>  - implement a minimal "graphics card PCI suspend resume" "driver" in the
>    kernel that will do this even if no framebuffer is used, or

We are going there, but it is *hard* to do, due to kernel graphics
missdesign. Could take years.

>  - implement this as a workaround in userspace?
> 
> I mean - it is not rocket science to do it in s2ram, but it just seems
> more correct (to me) to do it in the kernel, where the correct locking
> and ordering is more or less guaranteed.

Lets do it in userspace. Doing in kernel is right, but it will be
hard.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
