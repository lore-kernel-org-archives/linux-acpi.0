From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Crash with fs corruption on 2.4.23-rc1 + CONFIG_ACPI_PROCESSOR
Date: Mon, 17 Nov 2003 10:31:36 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031117102931.B60721@root.org>
References: <20031113161857.GM26911@roosevelt.alcove-fr>
 <20031114124713.GK32464@poupinou.org> <20031114152403.GK29316@roosevelt.alcove-fr>
 <20031115065020.GO32464@poupinou.org> <20031115134811.GA2630@hottah.alcove-fr>
 <20031117131800.GQ32464@poupinou.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031117131800.GQ32464-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 17 Nov 2003, Ducrot Bruno wrote:
> On Sat, Nov 15, 2003 at 02:48:11PM +0100, Stelian Pop wrote:
> > On Sat, Nov 15, 2003 at 07:50:20AM +0100, Ducrot Bruno wrote:
> >
> > > I think the trouble come from C3, just need to check some values.  If you
> > > can, it may be usefull that you disable C3, with something like that:
> > >
> > > +		acpi_fadt.plvl3_lat = 1234;
> >
> > And the patch works, your assumption was correct.
> >
> > Now, C3 seem to be reported as supported, 2.6 (correctly) doesn't
> > promote to it, but 2.4 does. I can't find an obvious reason by reading
> > the processor.c code (almost identical between 2.4/2.6...)
>
> No, 2.6 have some trouble, I guess, because C3 should be promoted.  I guess
> you are using a USB bridge driver, which need to be rewrotten somehow, because
> it does a lot of DMA transfers just to check if a device is plugged..
> That affect all USB driver, but not EHCI IIRC.

BTW, you were right about USB causing huge numbers of BM events.  Without
it in my kernel, things are quiet and C3 is used.  I just committed the
driver (FreeBSD).  Playing mp3s also results in BM activity but that is
expected.  I plan to add a quiesce method to our USB drivers so that ACPI
can shut the polling off while idle.

-Nate


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
