From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Fri, 06 Aug 2004 13:10:01 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1091823001.16369.35.camel@neuromancer.home.net>
References: <1091139240.26511.9.camel@6-allhosts>
	 <20040730141028.GE21359@luna.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040730141028.GE21359-4cxDFgrrBECgSpxsJD1C4w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-07-30 at 07:10, Micha Feigin wrote:
> On Thu, Jul 29, 2004 at 10:14:00PM +0000, Andrew Barr wrote:
> > I just bought a Radeon 7000 video card on-line. What is the status of
> > and plans for power management support for this card? I read
> 
> I am not sure about the current state of things. AFAIK the problem was
> with dri suspend support for radeon, and at the time at least, the card
> was reset on VT switch to enable suspend. IIRC the patch was
> incorporated into main the main tree quite some time ago.

I think this problem must be 2fold. 

1. The Bios implementation
2. the X server

Why? Cause by experience on my D600 system running RH9 and now FC2, it's
been better and better.

On RH9, 2.4 kernel, I had to switch to virtual terminal before I get
back my display. No 3D/dri support

Rh9 2.6 kernel, no need to switch to VT. Still no 3D.

Fc2 2.6 kernel. No need for VT and There's DRI/3d (Tux racer works
Great/fast)

But I keep complaining because I can't run America's Army and Unreal
Tournament etc.
> 
> I have no experience with S3 suspend (my laptop doesn't seem to support
> it) but it does suspend with swsusp2 if I switch VT.

S3 is a different beast. I believe it's the code implementation. I heard
that FreeBSD users seems to be able to get it working. 

Linux Users are getting there too. (Debian) and what I've heard but not
understood is the Need for POSTing the VGA card.

S4 works for Me. S3 Nope.
> > Regards,
> > Andrew Barr
> > 
> > 
> > 
> > -------------------------------------------------------
> > This SF.Net email is sponsored by OSTG. Have you noticed the changes on
> > Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
> > one more big change to announce. We are now OSTG- Open Source Technology
> > Group. Come see the changes on the new OSTG site. www.ostg.com
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >  
> >  +++++++++++++++++++++++++++++++++++++++++++
> >  This Mail Was Scanned By Mail-seCure System
> >  at the Tel-Aviv University CC.
> > 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by OSTG. Have you noticed the changes on
> Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
> one more big change to announce. We are now OSTG- Open Source Technology
> Group. Come see the changes on the new OSTG site. www.ostg.com
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

-- 
Ow Mun Heng
Fedora GNU/Linux Core 2 on D600 1.4Ghz CPU kernel
2.6.7-2.jul1-interactive 
Neuromancer 13:05:47 up 4:24, 6 users, load average: 2.36, 1.96, 2.44 


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
