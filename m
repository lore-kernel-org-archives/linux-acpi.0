From: =?iso-8859-15?q?=D8ystein=20Olsen?= <oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org>
Subject: Re: kernel 2.6.0-test4 /proc/acpi/sleep gone?
Date: Thu, 11 Sep 2003 19:22:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309111922.45350.oystein.olsen@astro.uio.no>
References: <20030910171318.GA7804@temporealericerca.org> <200309110913.42894.oystein.olsen@astro.uio.no> <20030911160434.GA3663@temporealericerca.org>
Reply-To: oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030911160434.GA3663-jls8/fvKqZ4sTkdEz0+zqIaCUm+kVXi4@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: marco trevisani <marco-HRfF0UPXfskm4RdzfppkhA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 11 September 2003 18:04, you wrote:
>  11/09/2003 alle 09:13:42, +0200, =D8ystein Olsen [AKA oystein.olsen] ha=
=20
scritto/escribi=F3/wrote:
> > On Wednesday 10 September 2003 19:13, marco-l0SEpsmuUtBegcJQxxnBRDe48wsgrGvP@public.gmane.org wrote:
> > > Hi,
> > > i've noticed a similar question from another user (without answer if i
> > > recall cerrectly):
> > > i'm running kernel 2.6.0-test4 with swsusp and sleep selected and acpi
> > > on. Curiously /proc/acpi/sleep does not show up...any possible clue
> > > or...change?
> >
> > http://zurich.ai.mit.edu/pipermail/omnibook/2003-August/002785.html
>
> Thank you for you reply. Though even in /proc/sys/ it is missing
> power/state, if i understood correctly that posting, which referrs to
> /proc/sys/power/state as the new place for standby etc. Am I correct?
>
> 		      thanks,
> 		      marco

Sorry for not being clear. You have to add a line to your /etc/fstab that l=
ook=20
like this:

none                    /sys            sysfs   defaults                0 0

Then make the directory /sys and mount /sys (or reboot). Then you'll find=20
/sys/power/state, and you can echo -n ' one of {standby|mem|disk} to=20
/sys/power/state.=20

=2D-=20
=D8ystein Olsen, oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org, http://folk.uio.no/oeysteio
Institute of Theoretical Astrophysics, http://www.astro.uio.no
University of Oslo, Norway



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
