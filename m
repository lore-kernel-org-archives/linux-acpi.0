From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: Some questions about ACPI and laptops
Date: Fri, 26 Jul 2002 01:18:23 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200207252221.g6PMLok24412@pfn1.pefnos>
References: <Pine.GSO.4.21.0207251105100.27979-100000@crak.roomfullaspies.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.GSO.4.21.0207251105100.27979-100000-LxWW08Vivvfua1+Tvyfzj5USO3DlRtUf@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Mathias Kolehmainen <mathiask-bdq14YP6qtRg9hUCZPvPmw@public.gmane.org>, Hanno =?iso-8859-7?q?B=F6ck?= <hanno-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> You may be able to slow down your machine if you have support for chani=
ng
> the either the performance or the throttling.

> On Thu, 25 Jul 2002, Hanno B=F6ck wrote:
> > - Most time I use my laptop simply to work, i don't need the full
> > power of my system. Is it possible to slowdown my pc to make the
> > battery last longer?
>

We have had some conversation in this list about that a few months ago. I=
t=20
seems the processor will 'fall' by itself in the 'C' states (see=20
/proc/acpi/processor/CPU0/power ) when the load is low.  That way, it wil=
l=20
run slower.
The question is: will a throttling (=3D not allow the processor to run at=
 max/A=20
speed) result in a lower consumption?
The answer is : the 'C' states theoretically have the ideal consumption. =
Some=20
manufacturers may have gotten it wrong. We should add a daemon which will=
=20
throttle. Then plot a graph of the power and performance and see if any=20
method is better than the other.
I have seen such a daemon, but I don't think its results are reliable, si=
nce=20
it polls the /proc/load?? . I think we could have results only if the=20
'throttling daemon' resides in the very heart of the kernel (in academic:=
=20
never trust an experiment done in a coarse way).=20

That's the current state of power efficiency (IMHO). The ACPI team may no=
t=20
have better results soon, but rest asure that there is already some power=
=20
conservation (remember that Linux itself makes very good use of the=20
processing power).

P. Christeas


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
