From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: Runlevel for Sleep?
Date: Sun, 8 Sep 2002 14:23:33 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209081126.g88BQjn05186@pfn1.pefnos>
References: <Pine.LNX.4.44.0209071232170.1021-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0209071232170.1021-100000-yZQdDDOm3n9ZQn2sFP3R7eTW4wlIGRCZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Patrick Mochel wrote:
> In essence, we're going to be doing something similar. It's just a matter
> of how we articulate it. Also, remember that we must do the converse
> action on resume (call all the init scripts again). But, is that really a
> runlevel transition? We'd be transferring back from 7 (or whatever) to 3
> or 5. But, we don't want to restart everything; only the stuff that we
> suspended.

Right, on resume we sould only call the scripts that "leave rl. 7", not the 
ones that enter 3 or 5. This is tricky (in concept). Moreover, I had 
recommended that the initscripts introduce the words "suspend" and "resume" 
instead of "stop" and "start". This way, we could partially suspend a service.
For example, a network daemon should drop all active connections when 
suspended, but not die itself (as in 'stop'). It could keep listening to a 
port.
One more thing  (as Lyle Seaman has pointed out) is that sometimes we don't 
want to suspend, even though the user has pressed the 'suspend button'. This 
means that the initscripts should be allowed to fail, in a manner such that 
the sleep state will not be eventually entered.


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
