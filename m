From: Jamin W. Collins <jcollins-u0TlgVUp4POoiH3BShWgcg@public.gmane.org>
Subject: Re: C1VN, ACPI and ESD/ASD = const CPU
Date: Tue, 27 Aug 2002 10:31:43 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020827103143.2dda513e.jcollins@asgardsrealm.net>
References: <20020827091844.7af7a982.jcollins@asgardsrealm.net>
	<20020827144826.GC32423@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020827144826.GC32423-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
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

On Tue, 27 Aug 2002 15:48:26 +0100
Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org> wrote:

> If you stop acpid (if you run it) and cat /proc/acpi/events, do you get
> a constant stream of events during this high system load?

Nope a "cat /proc/acpi/event" reports nothing.  The laptop doesn't seem to
suffer any ill effects from the reported CPU utilization.  In fact, I
haven't noticed any slow down to speak of.  Below is the output of "acpi
-V" while asd is running:

     Battery 1: charging, 100%
     Thermal 1: ok, 48.0 degrees C
  AC Adapter 1: on-line

After several minutes of more or less idling this looks like:

     Battery 1: charging, 100%
     Thermal 1: ok, 42.0 degrees C
  AC Adapter 1: on-line

So, the temperature isn't really fluxating that much.

-- 
Jamin W. Collins


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
