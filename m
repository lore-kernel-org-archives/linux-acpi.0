From: Tony Glader <Tony.Glader-cP9NhJtB8odr1ooMESYBxBZCeNDtXRbv@public.gmane.org>
Subject: Re: No events when pressing power button
Date: Fri, 2 Aug 2002 09:36:37 +0300 (EEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0208020934070.9566-100000@blueberrysolutions.com>
References: <20020802022638.A10668@tarnation.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020802022638.A10668-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Aaron Gaudio <prothonotar-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org>
Cc: Linux ACPI Devel Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2 Aug 2002, Aaron Gaudio wrote:

> If you want to read from /proc/acpi/event directly, kill acpid. Otherwise,
> the event will be consumed by acpid and you'll never see anything on
> /proc/acpi/event.

Of course I killed acpid. Otherwise I just got something like 'Device or 
resource busy'.

> If you want to see things from acpid, you need to define an event (acpid
> won't log any activity unless it has an action defined for the event).

I have defined that pushing button should run '/sbin/shutdown -h 0'.

I also noticed that ACPI doesn't power off everytime my computer when I 
shutdown it. About in 50% shutdowns it powers off and 50% doesn't.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
