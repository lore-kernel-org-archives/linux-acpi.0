From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: Runlevel for Sleep?
Date: Mon, 9 Sep 2002 11:50:23 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209090855.g898rbA19798@pfn1.pefnos>
References: <Pine.LNX.4.44.0209071232170.1021-100000@cherise.pdx.osdl.net> <200209081126.g88BQjn05186@pfn1.pefnos> <3D7C5FDF.4FB4E759@otello.alma.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3D7C5FDF.4FB4E759-gmoNqwowlqBr8A+qpt3pXFzrSV/HdtiB@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Diego Zuccato <diego-gmoNqwowlqBr8A+qpt3pXFzrSV/HdtiB@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Diego Zuccato wrote:
> "P. Christeas" wrote:
> > Right, on resume we sould only call the scripts that "leave rl. 7", not
> > the ones that enter 3 or 5. This is tricky (in concept). Moreover, I had
> > recommended that the initscripts introduce the words "suspend" and
> > "resume" instead of "stop" and "start". This way, we could partially
> > suspend a service. For example, a network daemon should drop all active
> > connections when suspended, but not die itself (as in 'stop'). It could
> > keep listening to a port.
>
> Why ???
> If you need that daemon to terminate answering pending connections, then
> use stop. If you don't (e.g. there is no timeout on the other side),
> then simply leave it alone. Really, you don't want it to accept more
> connections. What happens if you are suspending a db server (well,
> suspending a server is IMHO a really stupid thing, but...) and after
> giving it "suspend" a new connection request arrives ? It can only be
> discarded (then stop the service...) or accepted (so why in the hell is
> "suspend" needed???).
>
> Just my .02 ...
>
> BYtE,
>  Diego.

The whole point of the initscripts is that this is your call. The kernel 
provides the functionality and you (as the root of the system) are free to 
write any script you feel like doing.
I have suggested the 'suspend/resume' extensions because they might solve a 
few problems for *some* services. For example, you may want to stop serving 
connections, but restarting the service (the old way) may require such time, 
that the sleep/wake operation would take long (and you may not want that).
One more point is that some services may want to be notified that the system 
is going to sleep, even if they do practically nothing about it.
We are not going to handle all cases at the first day of this implementation. 
I just try to imagine situations thay may need design consideration.

P.Christeas 


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
