From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: Samsung P35, S3, black screen (radeon))
Date: Fri, 4 Feb 2005 08:48:02 +0100
Message-ID: <20050204074802.GD1086@elf.ucw.cz>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net> <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net> <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4202DF7B.2000506-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > I'd love to see it too. Pavel, even if you don't want to merge it for a
> > while, we can always incorporate it in the Suspend2 patches so it gets
> > some testing. I know I'd try it on my i830 based Omnibook.
> 
> Can we use call_usermodehelper at this early resume stage (before any
> video access)? Calling vm86 directly is probably not going to fly
> because we want to be shielded from any misbehaviour in the bios code
> and it may be necessary to kill the process running the bios code.
> 
> Cases in point: My bios will cause the POSTing application to segfault.
> Others have reported the POSTing application just hangs, but the
> important things are done before the hang, so killing it after maybe
> 5 seconds would be ok.
> 
> Rough outline how to do that without adding tons of code:
> We need a call_usermodehelper_from_ram_with_timeout for that.
> 
> Kernel:                          Userspace:
> User wants to enter S3
> init_mutex_locked(s3_sem)
> call_usermodehelper("vesaposter")
>                                  vesaposter calls LRMI_init
>                                  vesaposter mlocks all its memory
>                                  vesaposter calls into kernel
>                                           and down(s3_sem)
> suspend vesafb
> 
> User has triggered resume
> run wakeup.S
> thaw essential threads
> set a timer of 5 seconds
> up(s3_sem)
> thaw and schedule vesaposter
> wait for timer or vesaposter termination
>                                  vesaposter returns from kernel
>                                  vesaposter posts video card
>                                  vesaposter terminates
> resume vesafb
> continue resume
> 
> Problems with that approach:
> - vesaposter has to be locked in memory to avoid disk accesses
> - vesafb has to refrain from touching video until after POST
> - the vesaposter thread has to be the first unfrozen and
>   scheduled and completed thread. Only after that we can resume
>   vesafb and other threads
> - the locking will be tricky

- it is ugly

What about simply blocking all video accesses before disk (etc) is
resumed, so that "normal" (not locked in memory) application can be
used?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
