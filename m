From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Re: power is always C2 on toshiba A40 261
Date: Wed, 23 Jun 2004 23:32:50 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040623233202.W90370@root.org>
References: <20040623181434.44916.qmail@web90003.mail.scd.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040623181434.44916.qmail-uo4e3NHVv3LcEUl5EaY66YglqE1Y4D90QQ4Iyu8u01E@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Olive Esseret <olive_esseret-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 23 Jun 2004, Olive Esseret wrote:
> --- Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
> wrote:
> > On Wed, Jun 23, 2004 at 05:25:35AM -0700, Olive
> > Esseret wrote:
> > > Hello,
> >
> > > The content of the file
> > >
> > > /proc/acpi/processor/CPU0/power
> > > (see attached file power.txt.bz2)
> >
> > (it is a bit cumbersome attaching such small files
> > compressed :-)
> >
> > > shows that I am *always* in C2 sate. I see also
> > that I
> >
> > you are probably using a USB mouse on a uhci-hcd
> > controller.
> > Unplug the mouse and it will enter C3.
>
> Thank you, you are entirely right. But my question was
> more about why I am never C1 even whan I use nearly
> 100% of CPU (I use this laptop mainly with the AC
> adaptator and I do not want to loose performance)

Maybe you're lucky and your C2 has such a low latency that it's considered
just as fast as C1.  The T40 specifies a 1 microsecond latency for C2
(same as C1).

-Nate


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
