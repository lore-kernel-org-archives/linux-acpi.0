From: Florian Engelhardt <flo@dotbox.org>
Subject: Re: system freezes for 0.2 to 0.5 seconds when reading
 /proc/acpi/thermal_zone/THRM/temperature
Date: Thu, 28 Jul 2005 08:49:38 +0200
Message-ID: <20050728084938.480b46d1@localhost>
References: <20050728002244.5163ac4a@localhost>
	<20050727161605.5711fcf7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261284AbVG1Gq7@vger.kernel.org>
In-Reply-To: <20050727161605.5711fcf7.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hello,

On Wed, 27 Jul 2005 16:16:05 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Florian Engelhardt <flo@dotbox.org> wrote:
> >
> > Hello,
> > 
> > first of all, sorry for the long headline.
> > second:
> > Every time, i try to do the following:
> > cat /proc/acpi/thermal_zone/THRM/temperature
> > the whole system looks up for a short period of time (something
> > about 0.5s). realy everything, video and audio encoding, mouse and
> > keyboard input, firefox playing a flash animation, ...
> > I am also getting the following:
> > Losing some ticks... checking if CPU frequency changed.
> > 
> > maybe these two things are belonging to each other.
> > 
> > I am using a 2.6.12-rc3-mm1 kernel on a amd64 with a nvidia nforce4
> > mainboard.
> 
> It might help if you were to generate a kernel profile:
> 
> readprofile -r

returns:
/proc/profile: No such file or directory

do i have to activate something special during kernel configuration?

btw: i saw that mm2 is available. Are there any changes in it, which
could solve this problem?

flo

> for i in $(seq 10)
> do
> 	cat /proc/acpi/thermal_zone/THRM/temperature
> done
> readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40
> 
> 


-- 
"I may have invented it, but Bill made it famous"
David Bradley, who invented the (in)famous ctrl-alt-del key combination
