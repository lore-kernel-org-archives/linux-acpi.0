From: Andy Dustman <andy-gRfBfDTKyCbR7s880joybQ@public.gmane.org>
Subject: RE: ACPI patches updated (20021111)
Date: Wed, 13 Nov 2002 13:49:28 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0211131346450.9032-100000@gomer.neosouth.net>
References: <Pine.LNX.4.44.0211131310460.7918-100000@gomer.neosouth.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0211131310460.7918-100000-rsZ9VJrEJASOOqyHHM4PTqxOck334EZe@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org" <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 13 Nov 2002, Andy Dustman wrote:

> On Wed, 13 Nov 2002, Moore, Robert wrote:
> 
> > 
> > The UNINITIALIZED_LOCAL error is a bug in the ASL for this machine.  It
> > doesn't always occur because there are two different code paths, one of
> > which initializes Local3 and one that doesn't:
> ... 
> >                         Store (0x0FFF, Local2)
> >                         If (LEqual (Local1, 0x01))
> >                         {
> > -------------> Local3 only gets initialized here:
> > 
> >                             Or (Local2, 0x2000, Local3)
> >                         }
> 
> Sounds like I have no choice but to use a patched DSDT.
> 
>                           Else
>                           {
>                               Store (Local2, Local3)
>                           }
> 
> Any idea if this will work, or if it is bad in some obvious way? Guess 
> I'll just have to give it a try...

Well I've tried it and it appears to work, but since it is an intermittent 
problem, I can't really be sure.



-------------------------------------------------------
This sf.net email is sponsored by: Are you worried about 
your web server security? Click here for a FREE Thawte 
Apache SSL Guide and answer your Apache SSL security 
needs: http://www.gothawte.com/rd523.html
