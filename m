From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: suspend-to-disk: fan always on and misc kernel errors
Date: Mon, 28 Mar 2005 22:50:27 +0200
Message-ID: <20050328205027.GB28568@message-id.gmane0305.slipkontur.de>
References: <4246F06D.40005@cs.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4246F06D.40005-iEixELS/QsY1GQ1Ptb7lUw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Mar 27, 2005 at 07:42:05PM +0200, Andrea Borgia wrote:

> 2) script terminates with error and spews "command not found" problems 
> only in the post-wakeup section, even though full pathnames are used 
> (see script)

you have some funny special characters in there, no wonder bash barfs on that.

> # Unloading modules
> for M in $RELOAD
> do
> ? ? ? ? if /bin/grep -q "^$M[[:blank:]]" /proc/modules
> ? ? ? ? then
> ? ? ? ? ? ? ? ? /sbin/modprobe -r "$M"
> ? ? ? ? fi
> done

> # Reloading modules...
> for M in $RELOAD
> do
> ? ? ? ? if /bin/grep -q "^$M[[:blank:]]" /proc/modules
> ? ? ? ? then
> ? ? ? ? ? ? ? ? /sbin/modprobe "$M"
> ? ? ? ? fi
> done

-- 
Stefan Seyfried



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
