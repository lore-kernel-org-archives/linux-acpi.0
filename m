From: Florian Engelhardt <flo-MALAOO1t6vMdnm+yROfE0A@public.gmane.org>
Subject: Re: system freezes for 0.2 to 0.5 seconds when reading
 /proc/acpi/thermal_zone/THRM/temperature
Date: Thu, 28 Jul 2005 09:00:14 +0200
Message-ID: <20050728090014.2305def4@localhost>
References: <20050728002244.5163ac4a@localhost>
	<20050727161605.5711fcf7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050727161605.5711fcf7.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

On Wed, 27 Jul 2005 16:16:05 -0700
Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org> wrote:

> Florian Engelhardt <flo-MALAOO1t6vMdnm+yROfE0A@public.gmane.org> wrote:
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


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
