From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Processor C states and USB problem
Date: Wed, 14 Jan 2004 10:10:39 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720CC9@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Diego SANTA CRUZ <dsanta-W/9V78bTXrinCNX9eg9BBA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > > I picked up this thread and I'm interested in knowing a=20
> bit more about
> > > bus mastering and C3, as my laptop never goes into C3. I=20
> own a Dell
> > > Inspiron 8500 (details at
> > > http://ltswww.epfl.ch/~dsanta/resources/dell-i8500-linux).
> > >=20

How did you know your processor never transition to C3 mode?

> > > This is what I get for the power states:
> > > # cat /proc/acpi/processor/CPU0/power
> > > active state:            C2
> > > default state:           C1
> > > bus master activity:     ffffffff
> > > states:
> > >     C1:                  promotion[C2] demotion[--]=20
> > > latency[000] usage[00039800]
> > >    *C2:                  promotion[C3] demotion[C1]=20
> > > latency[050] usage[00573330]
> > >     C3:                  promotion[--] demotion[C2]=20
> > > latency[050] usage[00000004]
> > >=20

Usage of C3 is 4.=20



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
