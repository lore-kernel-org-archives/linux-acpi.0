From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: RFC 0/4: make ACPI interpret safe for suspend/resume
Date: Thu, 20 Jan 2005 10:40:42 +0100
Message-ID: <20050120094042.GC1452@elf.ucw.cz>
References: <1106104620.12957.270.camel@sli10-desk.sh.intel.com> <20050119101858.GE25623@elf.ucw.cz> <1106184495.13181.68.camel@sli10-desk.sh.intel.com> <20050120091242.GB1452@elf.ucw.cz> <1106213207.16186.10.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1106213207.16186.10.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > Freezing all processes should not be required. 
> > > How about just make suspend/resume task as a highest priority task with
> > > FIFO scheduler policy? 
> > 
> > That might do the trick for S3,
> What I like it is a) it speeds up freeze process in a system with many
> tasks, b) easy to move to SMP case on the future.
> 
> >  but not for swsusp. Imagine normal
> > process holding some lock you want (for writing image to disk). You
> > can run on FIFO scheduler, but then you block on this lock, and
> > userspace process gets to run, and gets confused.
> Ok, that makes sense. Could we split S3 from swsusp? That is S3 doesn't
> use freeze_process.

Yes, that's certainly an option. I liked the idea of code being
shared, and had refrigerator code handy...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
